---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

local myJourneyLocales = {
    ["Questie Options"] = {
        ["ptBR"] = "Opções do Questie",
        ["ruRU"] = "Настройки Questie",
        ["deDE"] = "Questie-Einstellungen",
        ["koKR"] = "Questie 설정",
        ["esMX"] = "Opciones de Questie",
        ["enUS"] = true,
        ["zhCN"] = "打开 Questie",
        ["zhTW"] = "設定選項",
        ["esES"] = "Opciones de Questie",
        ["frFR"] = "Options Questie",
    },
    ["My Journey"] = {
        ["ptBR"] = "Minha jornada",
        ["ruRU"] = "Путешествие",
        ["deDE"] = "Meine Reise",
        ["koKR"] = "나의 여정",
        ["esMX"] = "Mi Viaje",
        ["enUS"] = true,
        ["zhCN"] = "我的任务历程",
        ["zhTW"] = "我的冒險日記",
        ["esES"] = "Mi viaje",
        ["frFR"] = "Mon voyage",
    },
    ["%s's Journey"] = {
        ["ptBR"] = "A jornada de %s",
        ["ruRU"] = "Путешествие персонажа %s",
        ["deDE"] = "%s's Reise",
        ["koKR"] = "%s의 여정",
        ["esMX"] = "El Viaje de %s",
        ["enUS"] = true,
        ["zhCN"] = "%s的任务历程",
        ["zhTW"] = "%s的冒險日記",
        ["esES"] = "El viaje de %s",
        ["frFR"] = "Le voyage de %s",
    },
    ["Your Recent History"] = {
        ["ptBR"] = "Seu histórico recente",
        ["ruRU"] = "Недавняя история",
        ["deDE"] = "Deine aktuelle Historie",
        ["koKR"] = "최근 기록",
        ["esMX"] = "Tu Historial Reciente",
        ["enUS"] = true,
        ["zhCN"] = "近期纪录",
        ["zhTW"] = "最近的歷史記錄",
        ["esES"] = "Tu historial reciente",
        ["frFR"] = "Votre historique récent",
    },
    ["It's about time you embark on your first Journey!"] = {
        ["ptBR"] = "É hora de embarcar em sua primeira jornada!",
        ["ruRU"] = "Пора начинать свое первое путешествие!",
        ["deDE"] = "Es ist an der Zeit, dass du dich auf deine erste Reise begibst!",
        ["koKR"] = "당신은 이제 막 첫번째 여정을 시작했습니다!",
        ["esMX"] = "¡Es hora de que te embarques en tu primera aventura!",
        ["enUS"] = true,
        ["zhCN"] = "是时候踏上旅程了！",
        ["zhTW"] = "該是你踏上第一次旅程的時候了!",
        ["esES"] = "¡Es hora de que te embarques en tu primera aventura!",
        ["frFR"] = "Il est temps d'embarquer pour votre premier voyage !",
    },
    ["Congratulations! You reached %s !"] = {
        ["ptBR"] = "Parabéns! Você alcançou %s!",
        ["ruRU"] = "Поздравляем! Ваш уровень - %s!",
        ["deDE"] = "Herzlichen Glückwunsch! Du hast Level %s erreicht!",
        ["koKR"] = "축하합니다! %s 레벨을 달성했습니다!",
        ["esMX"] = "¡Felicidades, has alcanzado %s!",
        ["enUS"] = true,
        ["zhCN"] = "恭喜你达到了%s！",
        ["zhTW"] = "恭喜! 已達到 %s !",
        ["esES"] = "¡Felicidades! has alcanzado %s!",
        ["frFR"] = "Félicitations ! Vous avez atteint %s !",
    },
    ["You Accepted the quest %s"] = {
        ["ptBR"] = "Você aceitou a missão %s",
        ["ruRU"] = "Задание принято: %s",
        ["deDE"] = "Du hast die Quest '%s' angenommen",
        ["koKR"] = "%s 퀘스트를 수락했습니다",
        ["esMX"] = "Aceptaste la misión %s",
        ["enUS"] = true,
        ["zhCN"] = "你接受了任务：%s",
        ["zhTW"] = "已接受任務 %s",
        ["esES"] = "Aceptaste la misión %s",
        ["frFR"] = "Vous avez débuté la quête %s",
    },
    ["Quest %s: %s"] = {
        ["ptBR"] = "Missão %s: %s",
        ["ruRU"] = "Задание %s: %s",
        ["deDE"] = "Quest %s: %s",
        ["koKR"] = "퀘스트 %s: %s",
        ["esMX"] = "Misión %s: %s",
        ["enUS"] = true,
        ["zhCN"] = "任务%s：%s",
        ["zhTW"] = "任務 %s: %s",
        ["esES"] = "Misión %s: %s",
        ["frFR"] = "Quête %s : %s",
    },
    ["Level %s"] = {
        ["ptBR"] = "Nível %s",
        ["ruRU"] = "Уровень %s",
        ["deDE"] = "Level %s",
        ["koKR"] = "%s 레벨",
        ["esMX"] = "Nivel %s",
        ["enUS"] = true,
        ["zhCN"] = "等级%s",
        ["zhTW"] = "等級 %s",
        ["esES"] = "Nivel %s",
        ["frFR"] = "Niveau %s",
    },
    ["You Reached Level %s"] = {
        ["ptBR"] = "Você atingiu o nível %s",
        ["ruRU"] = "Достигнут уровень: %s",
        ["deDE"] = "Du hast Level %s erreicht",
        ["koKR"] = "%s 레벨을 달성했습니다",
        ["esMX"] = "Alcanzaste el nivel %s",
        ["enUS"] = true,
        ["zhCN"] = "你达到了等级 %s",
        ["zhTW"] = "你已達到 %s 級",
        ["esES"] = "Alcanzaste el nivel %s",
        ["frFR"] = "Vous avez atteint le niveau %s",
    },
    ["Year %s"] = {
        ["ptBR"] = "Ano %s",
        ["ruRU"] = "Год %s",
        ["deDE"] = "Jahr %s",
        ["koKR"] = "%s년",
        ["esMX"] = "Año %s",
        ["enUS"] = true,
        ["zhCN"] = "%s年",
        ["zhTW"] = "%s 年",
        ["esES"] = "Año %s",
        ["frFR"] = "Année %s",
    },
    ["Accepted"] = {
        ["ptBR"] = "Aceita",
        ["ruRU"] = "принято",
        ["deDE"] = "Angenommen",
        ["koKR"] = "수락",
        ["esMX"] = "Aceptada",
        ["enUS"] = true,
        ["zhCN"] = "接受",
        ["zhTW"] = "接受",
        ["esES"] = "Aceptada",
        ["frFR"] = "Acceptée",
    },
    ["You Abandoned the quest %s"] = {
        ["ptBR"] = "Você abandonou a missão %s",
        ["ruRU"] = "Задание отменено: %s",
        ["deDE"] = "Du hast die Quest '%s' abgebrochen",
        ["koKR"] = "%s 퀘스트를 포기했습니다",
        ["esMX"] = "Abandonaste la misión %s",
        ["enUS"] = true,
        ["zhCN"] = "你放弃了任务：%s",
        ["zhTW"] = "已放棄任務 %s",
        ["esES"] = "Abandonaste la misión %s",
        ["frFR"] = "Vous avez abandonné la quête %s",
    },
    ["Abandoned"] = {
        ["ptBR"] = "Abandonada",
        ["ruRU"] = "отменено",
        ["deDE"] = "Abgebrochen",
        ["koKR"] = "포기",
        ["esMX"] = "Abandonada",
        ["enUS"] = true,
        ["zhCN"] = "放弃",
        ["zhTW"] = "放棄",
        ["esES"] = "Abandonada",
        ["frFR"] = "Abandonnée",
    },
    ["Entry Title"] = {
        ["ptBR"] = "Título da entrada",
        ["ruRU"] = "Название",
        ["deDE"] = "Titel des Eintrags",
        ["koKR"] = "제목",
        ["esMX"] = "Título",
        ["enUS"] = true,
        ["zhCN"] = "输入标题",
        ["zhTW"] = "輸入標題",
        ["esES"] = "Título",
        ["frFR"] = "Titre :",
    },
    ["Journal Entry"] = {
        ["ptBR"] = "Entrada da jornada",
        ["ruRU"] = "Описание",
        ["deDE"] = "Tagebucheintrag",
        ["koKR"] = "내용",
        ["esMX"] = "Entrada de viaje",
        ["enUS"] = true,
        ["zhCN"] = "输入游记",
        ["zhTW"] = "冒險筆記內容",
        ["esES"] = "Entrada de viaje",
        ["frFR"] = "Message :",
    },
    ["You Completed the quest %s"] = {
        ["ptBR"] = "Você completou a missão %s",
        ["ruRU"] = "Задание выполнено: %s",
        ["deDE"] = "Du hast die Quest '%s' abgeschlossen",
        ["koKR"] = "%s 퀘스트를 완료했습니다",
        ["esMX"] = "Completaste la misión %s",
        ["enUS"] = true,
        ["zhCN"] = "你完成了任务：%s",
        ["zhTW"] = "已完成任務 %s",
        ["esES"] = "Completaste la misión %s",
        ["frFR"] = "Vous avez terminé la quête %s",
    },
    ["Add Entry"] = {
        ["ptBR"] = "Adicionar uma entrada",
        ["ruRU"] = "Добавить заметку",
        ["deDE"] = "Eintrag hinzufügen",
        ["koKR"] = "메모 추가",
        ["esMX"] = "Añadir entrada",
        ["enUS"] = true,
        ["zhCN"] = "添加条目",
        ["zhTW"] = "新增內容",
        ["esES"] = "Añadir entrada",
        ["frFR"] = "Enregistrer la note",
    },
    ["Note Created: %s"] = {
        ["ptBR"] = "Anotação criada: %s",
        ["ruRU"] = "Заметка добавлена: %s",
        ["deDE"] = "Notiz erstellt: %s",
        ["koKR"] = "메모 추가: %s",
        ["esMX"] = "Nota creada: %s",
        ["enUS"] = true,
        ["zhCN"] = "创建：%s",
        ["zhTW"] = "筆記建立於: %s",
        ["esES"] = "Nota creada: %s",
        ["frFR"] = "Note créée : %s",
    },
    ["No Note was entered. You must enter a note before submitting."] = {
        ["ptBR"] = "Nenhuma anotação foi inserida. Você deve inserir uma anotação antes de submeter.",
        ["ruRU"] = "Вы не ввели описание заметки. Введите описание для добавления заметки.",
        ["deDE"] = "Keine Notiz angegeben. Du musst eine Notiz angeben, bevor ein Eintrag angelegt werden kann.",
        ["koKR"] = "내용이 입력되지 않았습니다. 메모를 추가하려면 내용을 입력해주세요.",
        ["esMX"] = "No has introducido una nota. Tienes que introducir una antes de crear tu nota.",
        ["enUS"] = true,
        ["zhCN"] = "内容不可为空",
        ["zhTW"] = "沒有輸入筆記，送出前必須先輸入筆記內容。",
        ["esES"] = "No has introducido una nota. Tienes que introducir uno antes de crear tu nota.",
        ["frFR"] = "Aucun message n'a été trouvé. Vous devez entrer un message avant d'enregistrer.",
    },
    ["No Title was entered. You must enter a title before submitting your note."] = {
        ["ptBR"] = "Nenhum título foi inserido. Você deve inserir um título antes de submeter sua anotação.",
        ["ruRU"] = "Вы не ввели название заметки. Введите название для добавления заметки.",
        ["deDE"] = "Kein Titel angegeben. Du musst einen Titel angeben, bevor ein Eintrag angelegt werden kann.",
        ["koKR"] = "제목이 입력되지 않았습니다. 메모를 추가하려면 제목을 입력해주세요.",
        ["esMX"] = "No has introducido un título. Tienes que introducir uno antes de crear tu nota.",
        ["enUS"] = true,
        ["zhCN"] = "标题不可为空",
        ["zhTW"] = "沒有輸入標題，送出筆記前必須先輸入標題。",
        ["esES"] = "No has introducido un título. Tienes que introducir uno antes de crear tu nota.",
        ["frFR"] = "Aucun titre n'a été trouvé. Vous devez entrer un titre avant d'enregistrer.",
    },
    ["New Note For: %s"] = {
        ["ptBR"] = "Nova anotação para: %s",
        ["ruRU"] = "Новая заметка: %s",
        ["deDE"] = "Neue Notiz für: %s",
        ["koKR"] = "새로운 메모: %s",
        ["esMX"] = "Nueva Nota para: %s",
        ["enUS"] = true,
        ["zhCN"] = "新笔记：%s",
        ["zhTW"] = "新筆記: %s",
        ["esES"] = "Nueva nota para: %s",
        ["frFR"] = "Nouvelle note pour : %s",
    },
    ["Note: %s"] = {
        ["ptBR"] = "Anotação: %s",
        ["ruRU"] = "Заметка: %s",
        ["deDE"] = "Notiz: %s",
        ["koKR"] = "메모: %s",
        ["esMX"] = "Nota: %s",
        ["enUS"] = true,
        ["zhCN"] = "笔记：%s",
        ["zhTW"] = "筆記: %s",
        ["esES"] = "Nota: %s",
        ["frFR"] = "Note : %s",
    },
    ["Add New Adventure Note"] = {
        ["ptBR"] = "Adicione uma nova anotação de aventura",
        ["ruRU"] = "Новая заметка",
        ["deDE"] = "Neue Abenteuer-Notiz hinzufügen",
        ["koKR"] = "새 여행 메모 추가",
        ["esMX"] = "Añadir nueva nota de aventura",
        ["enUS"] = true,
        ["zhCN"] = "添加冒险笔记",
        ["zhTW"] = "新增冒險筆記",
        ["esES"] = "Añadir nueva nota de aventura",
        ["frFR"] = "Ajouter une note",
    },
    ["Create an entry in your journal to remember a specific moment. Simply supply a title and description and Questie will remember it for you!"] = {
        ["ptBR"] = "Crie uma entrada no seu diário para lembrá-lo de um momento específico. Basta fornecer um título e uma descrição e o Questie lembrará disso para você!",
        ["ruRU"] = "Создает заметку в журнале путешествия, чтобы запомнить определенный момент. Просто введите название и описание, и Questie запомнит это для вас!",
        ["deDE"] = "Erstelle einen Eintrag in deinem Reisetagebuch, um dich an einen bestimmten Moment zu erinnern. Gebe einfach einen Titel und eine Beschreibung an und Questie wird sich für dich erinnern!",
        ["koKR"] = "여정 내역에 메모를 남겨 특별한 순간을 기억해보세요. 간단하게 제목과 내용을 입력하면 Questie가 당신을 위해 기억해드립니다!",
        ["esMX"] = "Crea una nueva nota en tu viaje para recordar un momento especifico. Simplemente proporciona un titulo y una descripción y Questie lo recordará por ti",
        ["enUS"] = true,
        ["zhCN"] = "替你的魔兽升级之旅创建一个条目，纪录特别的时刻。只要输入标题和内容，Questie就会替你保存下来！",
        ["zhTW"] = "在你的冒險日記中建立新內容來記錄特別的時刻，只要簡單的輸入標題和內容描述，任務位置提示插件就會幫你保存起來!",
        ["esES"] = "Crea una nueva entrada en el tu viaje para recordar un momento especifico. Simplemente proporciona un titulo y una descripción y Questie lo recordará por ti",
        ["frFR"] = "Créez une note dans votre journal pour vous rappeler un moment précis. Indiquez simplement un titre et une description et Questie s'en souviendra pour vous !",
    },
}

for k, v in pairs(myJourneyLocales) do
    l10n.translations[k] = v
end