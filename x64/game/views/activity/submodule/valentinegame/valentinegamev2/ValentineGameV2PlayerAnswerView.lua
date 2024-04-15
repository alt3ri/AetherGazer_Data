slot0 = class("ValentineGameV2PlayerAnswerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineGame2UI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 2 do
		slot0:AddBtnListener(slot0["chooseBtn" .. slot4 .. "_"], nil, function ()
			if ActivityData:GetActivityIsOpen(uv0.activityID_) then
				ValentineGameData:CacheRandomQID(uv0.curQID_)
				ValentineGameAction:SetPoint(uv0.activityID_, 0, function ()
					SDKTools.SendMessageToSDK("activity_valentine_opt", {
						question_id = uv0.curQID_,
						answer_id = uv1,
						activity_id = uv0.activityID_
					})
					JumpTools.OpenPageByJump("/valentineGameV2ResultView", {
						activityID = uv0.activityID_,
						qID = uv0.curQID_,
						selectIndex = uv1
					})
				end)
			elseif manager.time:GetServerTime() < ActivityData:GetActivityData(uv0.activityID_).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(uv0.activityID_).startTime)))
			else
				ShowTips(GetTips("TIME_OVER"))
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.cfg_ = ActivityValentineCfg[slot0.activityID_]
	slot1 = nil

	if #slot0.cfg_.qa_id == #((not ValentineGameData:GetData(slot0.activityID_) or ValentineGameData:GetData(slot0.activityID_).answerQuestionID) and {}) then
		slot1 = {}

		ValentineGameData:ClearReadedQID(slot0.activityID_)
	end

	slot2 = {}

	for slot6, slot7 in pairs(slot0.cfg_.qa_id) do
		if table.indexof(slot1, slot7) == false then
			table.insert(slot2, slot7)
		end
	end

	slot0.curQID_ = slot2[math.random(#slot2)]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot4 = "TextureConfig/Character/Portrait/" .. slot0.cfg_.hero_id .. "_split_1"
	slot0.heroImage_.sprite = getSpriteWithoutAtlas(slot4)

	slot0.heroImage_:SetNativeSize()

	slot0.qustionText_.text = ActivityValentineWordCfg[slot0.curQID_].question_desc

	for slot4 = 1, 2 do
		slot0["chooseText" .. slot4 .. "_"].text = ActivityValentineWordCfg[slot0.curQID_].answer_desc[slot4]
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
			activityID = uv0.activityID_
		})
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

return slot0
