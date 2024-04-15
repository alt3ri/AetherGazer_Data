QuizGameManager = import("game.quiz.QuizGameManager")

print("===> QuizToLuaBridge Init")

slot0 = {}
slot1 = {}

function QuizSetGameStartArgs(slot0)
	uv0 = slot0
end

function LoadQuizScene()
	QuizSceneLoaded = 1

	DestroyLua()

	slot0 = P08.Quiz.QuizDataForExchange()
	slot0.sceneName = ActivityQuizTools.GetActivitySceneName(ActivityQuizTools.GetCurActivityID())

	P08.Quiz.QuizLuaBridge.Launcher(slot0)
	QuizGameManager:Init()
end

function QuitQuizScene()
	gameContext:SetSystemLayer("home")
	LuaExchangeHelper.GoToMain()
end

function OnEnterQuizScene()
	QuizSceneLoaded = 2

	QuizGameManager:StartGame(uv0, uv1)

	uv1 = {}

	manager.uiInit()

	whereami = "battle"

	gameContext:Go("/activityQuizSceneMain", {
		activityId = ActivityQuizTools.GetCurActivityID()
	})
end

function OnExitQuizScene()
	QuizSceneLoaded = 0

	QuizGameManager:Destroy()
	DestroyLua()
end

function QuizPendingAddPlayers(slot0)
	for slot4, slot5 in ipairs(slot0) do
		table.insert(uv0, slot5)
	end
end

function GetQuizSceneLoaded()
	return QuizSceneLoaded
end
