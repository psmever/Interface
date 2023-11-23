﻿local IRF3 = _G[...]
local wipe = _G.table.wipe
local LBDB = LibStub("LibBlueDB-1.0")
local L = LibStub("AceLocale-3.0"):GetLocale("IRF3")
IRF3.classes = { "WARRIOR", "DRUID", "PALADIN", "DEATHKNIGHT", "PRIEST", "SHAMAN", "ROGUE", "MAGE", "WARLOCK", "HUNTER" }
local function newTable() return {} end
local defaultProfile = L["Lime_Default"]
local colorWhite = { 1, 1, 1 }
local colorRed = { 1, 0, 0 }
local colorGreen = { 0, 1, 0 }
local colorOrange = {1, 0.4,0.04}
local colorYellow = { 1, 1, 0 }
local L = LibStub("AceLocale-3.0"):GetLocale("IRF3")
local default = {
	run = true,
	use = 1,	-- 1:항상 2:파티 및 공격대 3:공격대
	lock = false, scale = 1,shiftmove=false,
	anchor = "TOPLEFT", dir = 1, width = 80, height = 50, offset = 1, highlightAlpha = 0.5,petwidth2=80,petheight2=50,
	usePet = 3, petHeight = 12, petanchor = "TOPLEFT", petscale = 1, petcolumn = 5, petdir = 1,
	border = false, borderBackdrop = { 0,0,0,1}, borderBackdropBorder = { 0,0,0,1},
	partyTag = true, partyTagParty = { 0.28, 0.7, 0.8 }, partyTagRaid = { 0, 0, 0},
	anchor = "TOPLEFT",
	groupby = "GROUP",	-- GROUP:파티별 CLASS:직업별
	sortName = false,
	column = 8,
	grouporder = { 1, 2, 3, 4, 5, 6, 7, 8 },
	groupshown = { true, true, true, true, true, true, true, true },
	classorder = IRF3.classes,
	classshown = { WARRIOR = true, DRUID = true, PALADIN = true, DEATHKNIGHT = true, PRIEST = true, SHAMAN = true, ROGUE = true, MAGE = true, WARLOCK = true, HUNTER = true},
	useManager = true, managerPos = 25,
	castingSent = 0,	-- 0:사용 안함 1: 항상 표시 2: 마우스 오버시 표시
	enableClickCast = true, useClique = false,
--	FadeInFrequency=1,
	enableInstantHealth = false,
	enableHealComm = false,
	smootheffect = false,
	units = {
		backgroundColor = { 0.10, 0.10, 0.10, 0.55 },
		orientation = 1,
		displayPowerBar = true, powerBarHeight = 0.10, powerBarPos = 2,
		displayHealPrediction = true, healPredictionAlpha = 1.00, myHealPredictionColor = colorGreen, myHoTPredictionColor = colorGreen, otherHealPredictionColor = colorOrange, otherHoTPredictionColor = colorOrange,  AbsorbPredictionColor = { 0, 0.7, 1 },
		healIcon = true, healIconOther = true,  healIconPos = "BOTTOMLEFT", healIconSize = 10,
		displayRaidRoleIcon = true, displayRaidRoleIcon2 = true, roleIconPos = "TOPLEFT", roleIconSize = 12, centerStatusIcon = true, roleIcontype = 0,
		useRaidIcon = true, displayRaidRoleIconTank = false, raidIconPos = "TOPLEFT", raidIconSize = 12, raidIconSelf = true, raidIconTarget = false, raidIconFilter = { true, true, true, true, true, true, true, true },
		useClassColors = true, usePetClassColors=false, className = false, outRangeName = true, outRangeName2 = false, offlineName = true, deathName = true, outRangeAlpha = 0.35, hidepetName=false,
		useBossAura = true, bossAuraSize = 18, bossAuraPos = "CENTER", bossAuraAlpha = 0.75, bossAuraTimer = true,
		bossAuraOpt = 1,	-- 1:남은 시간 2:경과 시간 0:시간 표시 안함
		useSurvivalSkill = true, enableSurvivalMultiline =true, showSurvivalSkillTimer = true, showSurvivalSkillSub = false, showSurvivalSkillPotion = true, showSurvivalAsSpellTimer=true,
		showSurvivalAsSpellIcon={true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,false,true,true},
		showSurvivalAsSpellIconPos="TOPRIGHT",showSurvivalAsSpellIconSize=1.5,
		fadeOutOfRangeHealth = true, fadeOutOfRangePower = true, fadeOutAlpha = 0.35,
		texture = "Smooth",
		tooltip = 2,		-- 1:항상 2:비전투중에만 3:전투중에만 0:표시안함
		healthRange = 1,	-- 1:항상 2:사정거리 안 3:사정거리 밖
		healthType = 0,	-- 1:손실생명력 2:손실생명력% 3:남은생명력 4:남은생명력% 0:표시안함
		nameEndl = false, shortLostHealth = false, healthRed = true, showAbsorbHealth = true,useAbsorbInClassic=false,AbsorbInClassictype=2,
		useCastingBar = true, useCastingBarIcon=true,castingBarColor = { 0.2, 0.8, 0.2 }, castingBarHeight = 10, castingBarFontSize = 10, castingBarPos = 2, -- 1:TOP 2:BOTTOM 3:LEFT 4:RIGHT
		usePowerBarAlt = true, powerBarAltHeight = 3, powerBarAltPos = 1, -- 1:TOP 2:BOTTOM 3:LEFT 4:RIGHT
		useResurrectionBar = true, resurrectionBarColor = { 0, 0.75, 1 },
		dispelSound = "None", dispelSoundDelay = 5, useHarm = true,
		outline = {
			type = 2,	-- 1:해제 가능한 디버프 2:대상 3:마우스 오버 4:체력 낮음 5:어그로 6:전술목표 아이콘 0:사용 안함
			glow =false,
			scale = 0.8, alpha = 1,
			lowHealth = 0.7, lowHealthColor = colorRed,
			lowHealth2 = 9999, lowHealthColor2 = colorRed,
			raidIcon = { true, true, true, true, true, true, true, true }, raidIconColor = colorWhite,
			targetColor = colorYellow, mouseoverColor = colorYellow, aggroColor = colorRed,
		},
		debuffIcon = 5, debuffIconSize = 10, debuffIconPos = "TOPRIGHT", debuffIconType = 1,	-- 1:Icon+Color 2:Icon 3:Color
		debuffIconFontSize=8,debuffIconTimerType=1,
		debuffIconFilter = { Magic = true, Curse = true, Disease = true, Poison = true, none = true },
		buffIconSize = 12, buffIconPos = "LEFT",
		useAggroArrow = true,useAggroNameColor=false, aggroType = 1, -- 1:사용 안함 2:항상 3:파티/공격대 4:공격대
		aggroDetailColor = true,
		aggroGain = "None", aggroLost = "None",
		useDispelColor = true,
		RaidCheck=false, flaskFlags=300, foodFlags=300, runeFlags=300, showRunes=false, annFood=true, annFlask=true, annRune=true, RaidCheckAnn=false,
		useLeaderIcon=false, leaderIconSize=12, leaderIconPos = "TOPLEFT" , looterIconPos="TOPLEFT", SpellTimerFontColor= colorWhite, SpellTimerOtherFontColor = colorWhite, SpellTimerCountColor =colorWhite,
		petframeautopos=false ,sortplayer=1, 

	},
	font = {
		file = L["default_font"], size = 12, attribute = "", shadow = true,
	},
	colors = {
		name = { 1, 1, 1 },
		help = colorGreen,
		harm = { 0.5, 0, 0 },
		vehicle = { 0, 0.4, 0 },
		pet = colorGreen,
		offline = { 0.25, 0.25, 0.25 },
		specialdebuff={0.20,0.68,0.60},
		WARRIOR = { RAID_CLASS_COLORS.WARRIOR.r, RAID_CLASS_COLORS.WARRIOR.g, RAID_CLASS_COLORS.WARRIOR.b },
		PRIEST = { RAID_CLASS_COLORS.PRIEST.r, RAID_CLASS_COLORS.PRIEST.g, RAID_CLASS_COLORS.PRIEST.b },
		ROGUE = { RAID_CLASS_COLORS.ROGUE.r, RAID_CLASS_COLORS.ROGUE.g, RAID_CLASS_COLORS.ROGUE.b },
		MAGE = { RAID_CLASS_COLORS.MAGE.r, RAID_CLASS_COLORS.MAGE.g, RAID_CLASS_COLORS.MAGE.b },
		WARLOCK = { RAID_CLASS_COLORS.WARLOCK.r, RAID_CLASS_COLORS.WARLOCK.g, RAID_CLASS_COLORS.WARLOCK.b },
		HUNTER = { RAID_CLASS_COLORS.HUNTER.r, RAID_CLASS_COLORS.HUNTER.g, RAID_CLASS_COLORS.HUNTER.b },
		DRUID = { RAID_CLASS_COLORS.DRUID.r, RAID_CLASS_COLORS.DRUID.g, RAID_CLASS_COLORS.DRUID.b },
		SHAMAN = { RAID_CLASS_COLORS.SHAMAN.r, RAID_CLASS_COLORS.SHAMAN.g, RAID_CLASS_COLORS.SHAMAN.b },
		PALADIN = { RAID_CLASS_COLORS.PALADIN.r, RAID_CLASS_COLORS.PALADIN.g, RAID_CLASS_COLORS.PALADIN.b },
		DEATHKNIGHT = { RAID_CLASS_COLORS.DEATHKNIGHT.r, RAID_CLASS_COLORS.DEATHKNIGHT.g, RAID_CLASS_COLORS.DEATHKNIGHT.b },
		--- Character Resources
		MANA = { PowerBarColor.MANA.r, PowerBarColor.MANA.g, PowerBarColor.MANA.b },
		RAGE = { PowerBarColor.RAGE.r, PowerBarColor.RAGE.g, PowerBarColor.RAGE.b },
		FOCUS = { PowerBarColor.FOCUS.r, PowerBarColor.FOCUS.g, PowerBarColor.FOCUS.b },
		ENERGY = { PowerBarColor.ENERGY.r, PowerBarColor.ENERGY.g, PowerBarColor.ENERGY.b },
		RUNIC_POWER = { PowerBarColor.RUNIC_POWER.r, PowerBarColor.RUNIC_POWER.g, PowerBarColor.RUNIC_POWER.b },
		--- added 7.0.3 legion resources.
		LUNAR_POWER = { PowerBarColor.LUNAR_POWER.r, PowerBarColor.LUNAR_POWER.g, PowerBarColor.LUNAR_POWER.b }, --- Balance Druid
		INSANITY = { PowerBarColor.INSANITY.r, PowerBarColor.INSANITY.g, PowerBarColor.INSANITY.b }, ---Shadow Priest
		FURY = { PowerBarColor.FURY.r, PowerBarColor.FURY.g, PowerBarColor.FURY.b }, --- Demon Hunter
		PAIN = { PowerBarColor.PAIN.r, PowerBarColor.PAIN.g, PowerBarColor.PAIN.b }, --- Demon Hunter
		MAELSTROM = { PowerBarColor.MAELSTROM.r, PowerBarColor.MAELSTROM.g, PowerBarColor.MAELSTROM.b }, --- Enhancement Shaman
		--- Debuff/buffs color
		Magic = { DebuffTypeColor.Magic.r, DebuffTypeColor.Magic.g, DebuffTypeColor.Magic.b },
		Curse = { DebuffTypeColor.Curse.r, DebuffTypeColor.Curse.g, DebuffTypeColor.Curse.b },
		Disease = { DebuffTypeColor.Disease.r, DebuffTypeColor.Disease.g, DebuffTypeColor.Disease.b },
		Poison = { DebuffTypeColor.Poison.r, DebuffTypeColor.Poison.g, DebuffTypeColor.Poison.b },
		none = { DebuffTypeColor.none.r, DebuffTypeColor.none.g, DebuffTypeColor.none.b },
	},
	ignoreAura = {}, userAura = {}, userAuraGlow = {}, useeachbossAura = {}, userAuraGlowColorR={},userAuraGlowColorG={},userAuraGlowColorB={},bossAuraAlertTimer={}, bossAuraSize1={}, bossAuraAlpha1={}
}

function IRF3:InitDB()
	self.InitDB = nil
	if not InvenRaidFrames3DB then
		InvenRaidFrames3DB = {
			profileKeys = {},
			profiles = {},
			minimapButton = { show = true, radius = 80, angle =  19, dragable = true, rounding = 10 },
		}
	end
	for name, key in pairs(InvenRaidFrames3DB.profileKeys) do
		if not(type(name) == "string" and type(key) == "string" and InvenRaidFrames3DB.profiles[key]) then
			InvenRaidFrames3DB.profileKeys[name] = nil
		end
	end
	local _
	for _, db in pairs(InvenRaidFrames3DB.profiles) do
		if db.usePet == false then
			db.usePet = 1
		elseif db.usePet == true then
			db.usePet = 3
		end
		if db.units then
			-- 중요 오라로 변경에 따른 DB 이전
			if db.units.useBossDebuff then
				db.units.useBossAura = db.units.useBossDebuff
				db.units.useBossDebuff = nil
			end
			if db.units.bossDebuffSize then
				db.units.bossAuraSize = db.units.bossDebuffSize
				db.units.bossDebuffSize = nil
			end
			if db.units.bossDebuffPos then
				db.units.bossAuraPos = db.units.bossDebuffPos
				db.units.bossDebuffPos = nil
			end
			if db.units.bossDebuffAlpha then
				db.units.bossAuraPos = db.units.bossDebuffAlpha
				db.units.bossDebuffAlpha = nil
			end
			if db.units.bossDebuffTimer then
				db.units.bossAuraTimer = db.units.bossDebuffTimer
				db.units.bossDebuffTimer = nil
			end
			if db.units.bossDebuffOpt then
				db.units.bossAuraOpt = db.units.bossDebuffOpt
				db.units.bossDebuffOpt = nil
			end

			--구버전 보정(profile자동변환 속성을 계정db->캐릭터 db로 변경)

			db.units.profile_1m =db.profile_1m
			db.units.profile_5m =db.profile_5m
			db.units.profile_10m =db.profile_10m
			db.units.profile_25m =db.profile_25m
			db.units.profile_40m =db.profile_40m
			db.units.profile_spec1 =db.profile_spec1
			db.units.profile_spec2 =db.profile_spec2

		end
		if db.ignoreDebuffs then
			db.ignoreAura = db.ignoreDebuffs
		end
		if db.userDebuffs then
			db.userAura = db.userDebuffs
		end
		LBDB:UnregisterDB(db, default)
		-- 중요 오라 체크
		if db.ignoreAura then
			for aura in pairs(self.ignoreAura) do
				if db.ignoreAura[aura] then
					db.ignoreAura[aura] = nil
				end
			end
			for aura, v in pairs(db.ignoreAura) do
				if v == false and not self.ignoreAura[aura] then
					db.ignoreAura[aura] = nil
				end
			end
		end
		if db.userAura then
			for aura in pairs(self.bossAura) do
				if db.userAura[aura] then
					db.userAura[aura] = nil
				end
			end
		end
	end
	self.profileName = UnitName("player").." - "..GetRealmName()

	self:SetProfile(InvenRaidFrames3DB.profileKeys[self.profileName])
	if InvenRaidFrames3CharDB and InvenRaidFrames3CharDB.class ~= self.playerClass then
		wipe(InvenRaidFrames3CharDB)
		InvenRaidFrames3CharDB = nil
	end
	if not InvenRaidFrames3CharDB then
		InvenRaidFrames3CharDB = { class = self.playerClass }
	end

	self:SetupClassBuff()
	self:SetupSpellTimer()
end

function IRF3:SetProfile(profile)

	profile = profile or defaultProfile
	if type(profile) == "string" and profile ~= self.dbName  then
		if self.dbName and InvenRaidFrames3DB.profiles[self.dbName] then
			LBDB:UnregisterDB(InvenRaidFrames3DB.profiles[self.dbName])
		end


			if profile == defaultProfile then
				InvenRaidFrames3DB.profileKeys[self.profileName] = nil
			else
				InvenRaidFrames3DB.profileKeys[self.profileName] = profile

			end


		if not InvenRaidFrames3DB.profiles[profile] then
			InvenRaidFrames3DB.profiles[profile] = {}
		end
		self.db = LBDB:RegisterDB(InvenRaidFrames3DB.profiles[profile], default, newTable)
		self.dbName = profile
	end
end

function IRF3:ApplyPorfile()
	if InCombatLockdown() then return end
	self:UpdateTooltipState()
	self:LoadPosition()
	self.nameWidth = self.db.width - 2
	self:SetAttribute("ready", nil)
	self:SetAttribute("startupdate", nil)
	self:SetAttribute("run", self.db.run)
	self:SetAttribute("use", self.db.use)
	self:SetAttribute("ready", true)
	self:UpdateGroupFilter()
	self:UpdateFont()
	self:BuildAuraList()
	self:BuildSpellTimerList()
	self:UpdateSpellTimerFont()

	if self.db.border then
		self.border:SetBackdropColor(unpack(self.db.borderBackdrop))
		self.border:SetBackdropBorderColor(unpack(self.db.borderBackdropBorder))

		self.border:Show()
		self.border.updater:Show()
		self.petHeader.border:SetBackdropColor(self.border:GetBackdropColor())
		self.petHeader.border:SetBackdropBorderColor(self.border:GetBackdropBorderColor())
		self.petHeader.border:Show()
	else
		self.border:Hide()
		self.petHeader.border:Hide()
	end
	self:ToggleManager()
	self:HideBlizzardPartyFrame(self.db.hideBlizzardParty)
end

local groupfilter

local function setPartyTag(header)
	header.partyTag:ClearAllPoints()
	if IRF3.db.dir == 1 then
		if IRF3.db.anchor:find("TOP") then
			header.partyTag:SetPoint("BOTTOMLEFT", header, "TOPLEFT", 0, 0)
			header.partyTag:SetPoint("BOTTOMRIGHT", header, "TOPRIGHT", 0, 0)
		else
			header.partyTag:SetPoint("TOPLEFT", header, "BOTTOMLEFT", 0, 0)
			header.partyTag:SetPoint("TOPRIGHT", header, "BOTTOMRIGHT", 0, 0)
		end
		header.partyTag:SetHeight(12)
		return true
	else
		if IRF3.db.anchor:find("LEFT") then
			header.partyTag:SetPoint("TOPRIGHT", header, "TOPLEFT", 0, 0)
			header.partyTag:SetPoint("BOTTOMRIGHT", header, "BOTTOMLEFT", 0, 0)
		else
			header.partyTag:SetPoint("TOPLEFT", header, "TOPRIGHT", 0, 0)
			header.partyTag:SetPoint("BOTTOMLEFT", header, "BOTTOMRIGHT", 0, 0)
		end
		header.partyTag:SetWidth(12)
		return nil
	end
end

local function setPet(header)
	if IRF3.db.usePet == 2 then
		if IRF3.db.anchor:find("TOP") then
			for _, member in pairs(header.members) do
				member.petButton:ClearAllPoints()
				member.petButton:SetPoint("TOPLEFT", member, "BOTTOMLEFT", 0, 0)
				member.petButton:SetPoint("TOPRIGHT", member, "BOTTOMRIGHT", 0, 0)
				member.petButton.powerBar:SetPoint("BOTTOMRIGHT", 0, 0)
				member.petButton.healthBar:SetPoint("TOPLEFT", 0, -1)
			end
		else
			for _, member in pairs(header.members) do
				member.petButton:ClearAllPoints()
				member.petButton:SetPoint("BOTTOMLEFT", member, "TOPLEFT", 0, 0)
				member.petButton:SetPoint("BOTTOMRIGHT", member, "TOPRIGHT", 0, 0)
				member.petButton.powerBar:SetPoint("BOTTOMRIGHT", 0, 1)
				member.petButton.healthBar:SetPoint("TOPLEFT", 0, 0)
			end
		end
	end
end

function IRF3:UpdateGroupFilter()
	self:SetAttribute("startupdate", nil)
	groupfilter = nil
	if self.db.partyTag and self.db.groupby == "GROUP" then

		self.headers[0].partyTag:Show()
		self.headers[0].partyTag.tex:SetColorTexture(unpack(self.db.partyTagParty))
		self.headers[0].partyTag.text:SetText(setPartyTag(self.headers[0]) and L["파티헤더"] or "P")


		self.tankheaders.partyTag:Show()
		self.tankheaders.partyTag.tex:SetColorTexture(unpack(self.db.partyTagParty))
		self.tankheaders.partyTag.text:SetText(setPartyTag(self.tankheaders) and L["방어전담헤더"])
	else
		self.headers[0].partyTag:Hide()
		self.tankheaders.partyTag:Hide()
	end
	setPet(self.headers[0])
	self:SetAttribute("grouporder0", 0)
 
	if self.db.groupby == "GROUP" then
		for i = 1, 8 do
			if self.db.partyTag then
				self.headers[i].partyTag:Show()
				self.headers[i].partyTag.tex:SetColorTexture(unpack(i == self.playerGroup and self.db.partyTagParty or self.db.partyTagRaid))
				self.headers[i].partyTag.text:SetFormattedText(  setPartyTag(self.headers[i])   and (L["파티"] .." %d") or "P%d", i)
				self.headers[i].partyTag.subgroup =i
				
				if i==1 then
				self.tankheaders.partyTag:Show()
				self.tankheaders.partyTag.tex:SetColorTexture(unpack(i == self.playerGroup and self.db.partyTagParty or self.db.partyTagRaid))
				self.tankheaders.partyTag.text:SetText(setPartyTag(self.tankheaders) and L["방어전담헤더"])
				end

			else
				self.headers[i].partyTag:Hide()
				if i==1 then self.tankheaders.partyTag:Hide() end
			end
			if self.db.groupshown[i] then
				groupfilter = (groupfilter and (groupfilter..",") or "")..i
			end
			self:SetAttribute("grouporder"..i, self.db.grouporder[i])
			setPet(self.headers[i])

			

		end
	else

		for i = 1, 8 do
			self.headers[i].partyTag:Hide()
			setPet(self.headers[i])
		end
		for i = 1, #self.db.classorder do
			if self.db.classshown[self.db.classorder[i]] then
				groupfilter = (groupfilter and (groupfilter..",") or "")..self.db.classorder[i]
			end
		end
	end

	self:SetAttribute("width", self.db.width)
	self:SetAttribute("height", self.db.height)
	self:SetAttribute("petwidth2", self.db.petwidth2)
	self:SetAttribute("petheight2", self.db.petheight2)

	self:SetAttribute("usepet", self.db.usePet == 2)
	self:SetAttribute("enableTankFrame", self.db.enableTankFrame)
	self:SetAttribute("usepetgroup", self.db.usePet == 3)
	self:SetAttribute("petheight", self.db.petHeight)
	self:SetAttribute("petanchor", self.db.petanchor)
	self:SetAttribute("petcolumn", self.db.petcolumn)
	self:SetAttribute("petdir", self.db.petdir)
	self:SetAttribute("offset", self.db.offset)
	self:SetAttribute("anchor", self.db.anchor)
	self:SetAttribute("sortname", self.db.sortName)
	self:SetAttribute("dir", self.db.dir)
	self:SetAttribute("column", self.db.column)
	self:SetAttribute("partytag", self.db.groupby == "GROUP" and self.db.partyTag and 12 or 0)
	self:SetAttribute("groupby", self.db.groupby)
	self:SetAttribute("groupfilter", groupfilter or "0")
	self:SetAttribute("startupdate", true)

	if self.optionFrame.preview then
		self.optionFrame:SetPreview(self.optionFrame.preview.show)
	end
	if self.optionFrame.group then
		self.optionFrame.group:Update()
	end
	if self.optionFrame.class then
		self.optionFrame.class:Update()
	end

	self:UpdateManagerGroupFilter()
	InvenRaidFrames3Member_Sort()
end