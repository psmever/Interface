Notepad_Vars  = {}  -- variables saved between sessions
Notepad_CVars = {}  -- variables saved between sessions per character

local _lastInsertedLink
local _lastInsertedLinkTime
local _fonts = {}
local _fontHeights = { 7, 8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 32, 36, 48, 72 }


function Notepad_OnLoad(self)
    -- register events
    self:RegisterEvent("PLAYER_LEAVING_WORLD")
    self:RegisterEvent("VARIABLES_LOADED")

    -- settings
    Notepad.CurrentTabID = 1

    -- setup locale
    local locale = GetLocale()
    if locale == "deDE" then
        Notepad_DefineStrings_de()
    elseif locale == "ruRU" then
        Notepad_DefineStrings_ru()
    else
        Notepad_DefineStrings_en()
    end

    -- initialization
    Notepad_UpdateFonts()

    -- register slash command
    SlashCmdList["Notepad_Toggle"] = Notepad_Toggle
    SLASH_Notepad_Toggle1 = "/notepad"
    SLASH_Notepad_Toggle2 = "/np"

    -- register hooks
    hooksecurefunc("ChatEdit_InsertLink", Notepad_InsertLink)
    hooksecurefunc("ReloadUI", Notepad_SaveNote)
    hooksecurefunc("OpenStackSplitFrame", Notepad_OpenStackSplitFrame)

    -- setup notes frame
    NotepadTitleText:SetText(NOTEPAD_STRING.TITLE)
    self.Tabs = { NotepadGeneralTab, NotepadCharacterTab, NotepadSettingsTab }
    NotepadGeneralTab:SetText(NOTEPAD_STRING.GENERAL_NOTES)
    NotepadCharacterTab:SetText(string.format(NOTEPAD_STRING.CHAR_NOTES, UnitName("player")))
    NotepadSettingsTab:GetNormalTexture():ClearAllPoints()
    NotepadSettingsTab:GetNormalTexture():SetPoint("BOTTOM", NotepadSettingsTab, "BOTTOM", 1, 2)
    PanelTemplates_TabResize(NotepadGeneralTab, 0)
    PanelTemplates_TabResize(NotepadCharacterTab, 0)
    NotepadGeneralTabHighlightTexture:SetWidth(NotepadGeneralTab:GetTextWidth() + 30)
    NotepadCharacterTabHighlightTexture:SetWidth(NotepadCharacterTab:GetTextWidth() + 30)
    NotepadSettingsTabHighlightTexture:SetWidth(22)
    PanelTemplates_SetNumTabs(self, 3)
    PanelTemplates_SetTab(self, 1)
    FauxScrollFrame_SetOffset(NotepadTitleScrollFrame, 0)
    for i = 1, 8 do
        _G["NotepadNoteTitle" .. i]:SetNormalTexture("")
        _G["NotepadNoteTitle" .. i .. "Text"]:SetPoint("TOPLEFT", "NotepadNoteTitle" .. i, "TOPLEFT", 3, 0)
    end
    NotepadNoteTitleHighlightTexture:SetVertexColor(1, 0.82, 0)
    NotepadNewNoteButton.tooltipText = NOTEPAD_STRING.NEW_TIP
    NotepadDeleteNoteButton.tooltipText = NOTEPAD_STRING.DELETE_TIP
    NotepadRenameNoteButton:SetText(NOTEPAD_STRING.RENAME)
    NotepadRenameNoteButton.tooltipText = NOTEPAD_STRING.RENAME_TIP
    NotepadSaveButton:SetText(NOTEPAD_STRING.SAVE)
    NotepadSaveButton.tooltipText = NOTEPAD_STRING.SAVE_TIP
    
    -- setup as UI panel
    UIPanelWindows["Notepad"] = { area = "left", pushable = 5, whileDead = 1 }
    
    -- setup popup
    StaticPopupDialogs["NOTEPAD_TITLE"] = {
        text = NOTEPAD_STRING.NOTE_TITLE,
        button1 = ACCEPT,
        button2 = CANCEL,
        hasEditBox = 1,
        maxLetters = 50,
        timeout = 0,
        exclusive = 1,
        whileDead = 1,
        hideOnEscape = 1,
        OnAccept = function(self)
            Notepad_SetTitle(_G[self:GetName() .. "EditBox"]:GetText())
        end,
        OnShow = function(self)
            _G[self:GetName() .. "EditBox"]:SetFocus()
        end,
        OnHide = function(self)
            _G[self:GetName() .. "EditBox"]:SetText("")
        end,
        EditBoxOnEnterPressed = function(self)
            Notepad_SetTitle(_G[self:GetParent():GetName() .. "EditBox"]:GetText())
            self:GetParent():Hide()
        end,
        EditBoxOnEscapePressed = function(self)
            self:GetParent():Hide()
        end
    }
end


function Notepad_Initialize()
    -- setup variable default values
    if not Notepad_Vars.MinimapIcon then
        Notepad_Vars.MinimapIcon = { hide = false }
    end
    if not Notepad_Vars.NoteFontName then
        Notepad_Vars.NoteFontName = "Friz Quadrata TT"
    end
    if not Notepad_Vars.NoteFontHeight then
        Notepad_Vars.NoteFontHeight = 10
    end
    if not Notepad_Vars.Notes then
        Notepad_Vars.Notes = {}
    end
    if not Notepad_CVars.Notes then
        Notepad_CVars.Notes = {}
    end

    -- initialize notes frame
    Notepad_SetFont()

    -- initialize settings
    NotepadSettingsMinimapIconVisibleLabel:SetText(NOTEPAD_STRING.OPTIONS.SHOWMINIMAPBUTTON)
    NotepadSettingsMinimapIconVisible:SetChecked(not Notepad_Vars.MinimapIcon.hide)
    NotepadSettingsFontSelectionLabel:SetText(NOTEPAD_STRING.OPTIONS.FONTNAME)
    UIDropDownMenu_JustifyText(NotepadSettingsFontSelection, "LEFT")
    UIDropDownMenu_SetButtonWidth(NotepadSettingsFontSelection, 245)
    UIDropDownMenu_SetWidth(NotepadSettingsFontSelection, 230)
    UIDropDownMenu_Initialize(NotepadSettingsFontSelection, NotepadSettingsFontSelection_Initialize)
    for i, font in ipairs(_fonts) do
        if font.Name == Notepad_Vars.NoteFontName then
            Notepad_SelectFont(i)
            break
        end
    end
    NotepadSettingsFontHeightSelectionLabel:SetText(NOTEPAD_STRING.OPTIONS.FONTHEIGHT)
    UIDropDownMenu_SetButtonWidth(NotepadSettingsFontHeightSelection, 55)
    UIDropDownMenu_SetWidth(NotepadSettingsFontHeightSelection, 40)
    UIDropDownMenu_Initialize(NotepadSettingsFontHeightSelection, NotepadSettingsFontHeightSelection_Initialize)
    for i, fontHeight in ipairs(_fontHeights) do
        if fontHeight == Notepad_Vars.NoteFontHeight then
            UIDropDownMenu_SetSelectedID(NotepadSettingsFontHeightSelection, i)
            break
        end
    end
    
    -- setup DataBroker
    local dataBroker = LibStub:GetLibrary("LibDataBroker-1.1")
    local dataObject = dataBroker:NewDataObject(
        "Notepad",
        {
            icon = "Interface\\Icons\\inv_scroll_01",
            text = "Notepad",
            type = "launcher",
            OnClick =
                function(frame, button)
                    Notepad_Toggle()
                end,
            OnTooltipShow =
                function(tooltip)
                    tooltip:AddLine("Notepad")
                end
        }
    )
    
    -- setup minimap icon
    LibStub:GetLibrary("LibDBIcon-1.0"):Register("Notepad", dataObject, Notepad_Vars.MinimapIcon)
end


function Notepad_OnShow()
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_OPEN)
    Notepad_Update()
end


function Notepad_OnHide()
    Notepad_SaveNote()
    PlaySound(SOUNDKIT.IG_CHARACTER_INFO_CLOSE)
end


function Notepad_OnEvent(self, event, ...)
    if event == "PLAYER_LEAVING_WORLD" then
        Notepad_SaveNote()
    elseif event == "VARIABLES_LOADED" then
        Notepad_Initialize()
        self:UnregisterEvent("VARIABLES_LOADED")
    end
end

function Notepad_OnHyperlinkClick(self, link, text, button)
    SetItemRef(link, text, button)
end


function Notepad_InsertLink(text)
    if NotepadEditBox:HasFocus() then
        -- when inserting links from a chat frame the function is called twice => ignore identical calls within 100 ms
        local linkTime = GetTime()
        if text ~= _lastInsertedLink or not _lastInsertedLinkTime or linkTime > _lastInsertedLinkTime + 0.1 then
            NotepadEditBox:Insert(text)
            _lastInsertedLink = text
            _lastInsertedLinkTime = linkTime
        end
    end
end


function Notepad_SaveNote()
    if Notepad.NoteChanged then
        if Notepad.SelectedNote then
            Notepad.Notes[Notepad.SelectedNote].Note = NotepadEditBox:GetText()
        end
        Notepad.NoteChanged = nil
    end
end


function Notepad_SelectFont(index)
    UIDropDownMenu_SetSelectedID(NotepadSettingsFontSelection, index)
    NotepadSettingsFontSelectionText:SetFont(_fonts[index].File, 12, "")
end


function Notepad_SetFont(fontName, fontHeight)
    if fontName then
        Notepad_Vars.NoteFontName = fontName
    end
    if fontHeight then
        Notepad_Vars.NoteFontHeight = fontHeight
    end
    
    for i, font in ipairs(_fonts) do
        if font.Name == Notepad_Vars.NoteFontName then
            NotepadEditBox:SetFont(font.File, Notepad_Vars.NoteFontHeight, "")
            break;
        end
    end
end


function Notepad_SetTitle(title)
    local doFocus, doSort, doUpdate

    if Notepad.Mode == "edit" then
        Notepad.Notes[Notepad.SelectedNote].Title = title
        doSort = true
        doUpdate = true
    elseif Notepad.Mode == "new" then
        table.insert(Notepad.Notes, { Title = title, Note = ""})
        Notepad.NoteCount = Notepad.NoteCount + 1
        Notepad.SelectedNote = Notepad.NoteCount
        doSort = true
        doUpdate = true
        doFocus = true
    end

    if doSort then
        table.sort(Notepad.Notes, Notepad_Sort)

        -- find new position of  selected note
        for i = 1, Notepad.NoteCount do
            if Notepad.Notes[i].Title == title then
                Notepad.SelectedNote = i
                break
            end
        end

        -- scroll to new position of selected note
        local offset = FauxScrollFrame_GetOffset(NotepadTitleScrollFrame)
        local value
        if Notepad.SelectedNote <= offset then
            value = Notepad.SelectedNote - 1
        elseif Notepad.SelectedNote > offset + 8 then
            value = Notepad.SelectedNote - 8
        end
        if value then
            NotepadTitleScrollFrameScrollBar:SetValue(16 * value)
            FauxScrollFrame_SetOffset(NotepadTitleScrollFrame, value)
        end
    end

    if doUpdate then
        Notepad_Update()
    end

    if doFocus then
        NotepadEditBox:SetFocus()
    end
end


function Notepad_ShowMinimapIcon(show)
    local iconLib = LibStub:GetLibrary("LibDBIcon-1.0")
    Notepad_Vars.MinimapIcon.hide = not show   
    if show then
        iconLib:Show("Notepad")
    else
        iconLib:Hide("Notepad")
    end
end


function Notepad_Sort(a, b)
    return string.upper(a.Title) < string.upper(b.Title)
end


function Notepad_Toggle()
    if Notepad:IsVisible() then
        HideUIPanel(Notepad)
    else
        ShowUIPanel(Notepad)
    end
end


function Notepad_Update()
    local isEdit, isSettings

    if Notepad.CurrentTabID == 1 then
        isEdit = true
        Notepad.Notes = Notepad_Vars.Notes
    elseif Notepad.CurrentTabID == 2 then
        isEdit = true
        Notepad.Notes = Notepad_CVars.Notes
    else
        isSettings = true
        Notepad.Notes = nil
    end

    Notepad.NoteChanged = nil

    -- edit
    if isEdit then
        if not Notepad.Notes then
            Notepad.Notes = {}
        end
        Notepad.NoteCount = #Notepad.Notes

        -- highlight selected title
        local noteTitle, index, offset
        offset = FauxScrollFrame_GetOffset(NotepadTitleScrollFrame)
        FauxScrollFrame_Update(NotepadTitleScrollFrame, Notepad.NoteCount, 8, 16, nil, nil, nil, NotepadNoteTitleHighlight, 350, 316)
        NotepadNoteTitleHighlight:Hide()
        for i = 1, 8 do
            index = offset + i
            noteTitle = _G["NotepadNoteTitle" .. i]
            if index > Notepad.NoteCount then
                noteTitle:Hide()
            else
                noteTitle:SetID(index)
                noteTitle:SetText(Notepad.Notes[index].Title)
                noteTitle:Show()
                if index == Notepad.SelectedNote then
                    NotepadNoteTitleHighlight:SetPoint("TOPLEFT", noteTitle)
                    NotepadNoteTitleHighlight:SetPoint("BOTTOMRIGHT", noteTitle)
                    NotepadNoteTitleHighlight:Show()
                    noteTitle:LockHighlight()
                else
                    noteTitle:UnlockHighlight()
                end
            end
        end

        NotepadNotesTitles:Show()
        NotepadSeparator:Show()

        if Notepad.SelectedNote then
            NotepadEditTitle:SetText(Notepad.Notes[Notepad.SelectedNote].Title)
            NotepadEdit:Show()
            NotepadEditBox:ClearFocus()
            NotepadEditBox:SetText(Notepad.Notes[Notepad.SelectedNote].Note)
            NotepadDeleteNoteButton:Enable()
            NotepadRenameNoteButton:Enable()
        else
            NotepadEdit:Hide()
            NotepadEditBox:SetText("")
            NotepadDeleteNoteButton:Disable()
            NotepadRenameNoteButton:Disable()
        end

        NotepadNewNoteButton:Show()
        NotepadDeleteNoteButton:Show()
        NotepadRenameNoteButton:Show()
    else
        Notepad.NoteCount = 0
        NotepadNotesTitles:Hide()
        NotepadSeparator:Hide()
        NotepadEdit:Hide()
        NotepadNewNoteButton:Hide()
        NotepadDeleteNoteButton:Hide()
        NotepadRenameNoteButton:Hide()
    end

    -- settings
    if isSettings then
        NotepadSettings:Show()
    else
        NotepadSettings:Hide()
    end
end


function Notepad_UpdateFonts()
    local newFonts

    for i, fontName in ipairs(LibStub:GetLibrary("LibSharedMedia-3.0"):List("font")) do
        if i > #_fonts or _fonts[i].Name ~= fontName then
            local fontFile = LibStub:GetLibrary("LibSharedMedia-3.0"):Fetch("font", fontName)
            local fontObject = CreateFont("NotepadFont_" .. fontName)
            fontObject:SetFont(fontFile, 12, "")
            local font = {
                Name = fontName,
                File = fontFile,
                Object = fontObject
            }
            table.insert(_fonts, i, font)
            newFonts = true
        end
    end

    if newFonts then
        Notepad_SetFont()
    end
end


function NotepadDeleteNoteButton_OnClick()
    if Notepad.SelectedNote then
        table.remove(Notepad.Notes, Notepad.SelectedNote)
        Notepad.SelectedNote = nil
        Notepad_Update()
    end
end


function NotepadEditBox_OnTextChanged(self)
    Notepad.NoteChanged = true
    NotepadEditScrollFrame:UpdateScrollChildRect()
    local _, max = NotepadEditScrollFrameScrollBar:GetMinMaxValues()
    if max ~= 0 and self.Max ~= max then
        if NotepadEditScrollFrameScrollBar:GetValue() == self.Max then
            NotepadEditScrollFrameScrollBar:SetValue(max)
        end
        self.Max = max
    end
end


function NotepadNewNoteButton_OnClick()
    Notepad_SaveNote()
    Notepad.Mode = "new"
    StaticPopup_Show("NOTEPAD_TITLE")
end


function NotepadNoteTitle_OnClick(self)
    StaticPopup_Hide("NOTEPAD_TITLE")
    Notepad_SaveNote()
    Notepad.SelectedNote = self:GetID()
    Notepad_Update()
end


function NotepadRenameNoteButton_OnClick()
    Notepad_SaveNote()
    Notepad.Mode = "edit"
    local dialog = StaticPopup_Show("NOTEPAD_TITLE")
    _G[dialog:GetName() .. "EditBox"]:SetText(Notepad.Notes[Notepad.SelectedNote].Title)
end



function NotepadSettingsFontSelection_Initialize(self)
    Notepad_UpdateFonts()

    for i, font in ipairs(_fonts) do
        info = UIDropDownMenu_CreateInfo()
        info.text = font.Name
        info.func = NotepadSettingsFontSelection_OnSelect
        info.arg1 = font.Name
        UIDropDownMenu_AddButton(info)
        local button = _G["DropDownList1Button" .. i]
        button:SetNormalFontObject(font.Object)
        button:SetHighlightFontObject(font.Object)
    end
end


function NotepadSettingsFontSelection_OnSelect(self, fontName)
    Notepad_SelectFont(self:GetID())
    Notepad_SetFont(fontName, nil)
end


function NotepadSettingsFontHeightSelection_Initialize(self)
    for i, fontHeight in ipairs(_fontHeights) do
        info = UIDropDownMenu_CreateInfo()
        info.text = fontHeight
        info.func = NotepadSettingsFontHeightSelection_OnSelect
        info.arg1 = fontHeight
        UIDropDownMenu_AddButton(info)
    end
end


function NotepadSettingsFontHeightSelection_OnSelect(self, fontHeight)
    UIDropDownMenu_SetSelectedID(NotepadSettingsFontHeightSelection, self:GetID())
    Notepad_SetFont(nil, fontHeight)
end


function NotepadTab_OnClick(self)
    local tabID = self:GetID()
    if tabID == Notepad.CurrentTabID then
        return
    end
    
    if Notepad.CurrentTabID < 3 then
        Notepad_SaveNote()
        Notepad.SelectedNote = nil
        NotepadEditBox:ClearFocus()
        NotepadEditBox:SetText("")
    end
    
    Notepad.CurrentTabID = tabID
    PanelTemplates_SetTab(Notepad, tabID)

    Notepad_Update()
end


function Notepad_OpenStackSplitFrame(maxStack, parent, anchor, anchorTo, stackCount)
    -- when linking a splittable item from a container WoW opens the stack split frame => close it if opened at the same time
    if _lastInsertedLinkTime and GetTime() - _lastInsertedLinkTime < 0.01 then
        StackSplitFrame:Hide()
    end
end
