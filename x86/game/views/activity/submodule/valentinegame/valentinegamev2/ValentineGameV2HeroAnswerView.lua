slot0 = class("ValentineGameV2HeroAnswerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineGame1UI"
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

	for slot4 = 1, 3 do
		slot0["controller" .. slot4 .. "_"] = ControllerUtil.GetController(slot0["chooseBtn" .. slot4 .. "_"].transform, "get")
	end
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["chooseBtn" .. slot4 .. "_"], nil, function ()
			if ActivityData:GetActivityIsOpen(uv0.activityID_) then
				slot0 = uv0.cfg_.hero_qa_id[uv1]

				SDKTools.SendMessageToSDK("activity_valentine_opt", {
					answer_id = 0,
					question_id = slot0,
					activity_id = uv0.activityID_
				})
				ValentineGameData:CacheChooseQID(slot0)
				manager.story:StartStoryById(ActivityValentineWordCfg[slot0].stroy_id_list[1], function (slot0)
					JumpTools.OpenPageByJump("/valentineGameV2PlayerAnswerView", {
						activityID = uv0.activityID_
					})
				end, true)
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

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot4 = slot0.cfg_.hero_id
	slot0.heroImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot4 .. "_split_1")

	slot0.heroImage_:SetNativeSize()

	for slot4 = 1, 3 do
		slot5 = slot0.cfg_.hero_qa_id[slot4]
		slot0["chooseText" .. slot4 .. "_"].text = ActivityValentineWordCfg[slot5].question_desc

		if table.indexof(ValentineGameData:GetData(slot0.activityID_).selectQuestionID, slot5) then
			slot0["controller" .. slot4 .. "_"]:SetSelectedState("true")
		else
			slot0["controller" .. slot4 .. "_"]:SetSelectedState("false")
		end
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
