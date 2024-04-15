slot0 = class("ValentineGameV2ResultView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineResultUI"
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

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "isright")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		manager.story:StartStoryById(ActivityValentineWordCfg[uv0.curQID_].stroy_id_list[uv0.selectIndex_], function (slot0)
			JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
				activityID = uv0.activityID_
			})
		end, true)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.curQID_ = slot0.params_.qID
	slot0.selectIndex_ = slot0.params_.selectIndex

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.selectIndex_ == ActivityValentineWordCfg[slot0.curQID_].correct_answer then
		slot0.controller_:SetSelectedState("true")
	else
		slot0.controller_:SetSelectedState("false")
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
