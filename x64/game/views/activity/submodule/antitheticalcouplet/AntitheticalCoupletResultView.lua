slot0 = class("AntitheticalCoupletResultView", ReduxView)

function slot0.UIName(slot0)
	return AntitheticalCoupletTools.GetResultUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			JumpTools.OpenPageByJump("/antitheticalCouplet", {
				activityID = uv0.params_.activityID
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.couplet1_.sprite = getSpriteWithoutAtlas("TextureConfig/EmptyDream/couplets/" .. ActivitySpringFestivalCoupletsCfg[slot0.params_.id].start_picture)
	slot2 = nil

	if not slot0.params_.isComplet then
		AntitheticalCoupletAction:ChooseStoryID(slot0.params_.id, manager.story:GetStoryChoice()[1] or 1)
	else
		slot2 = AntitheticalCoupletData:GetData(slot0.params_.id) and slot3.chooseID or 1
	end

	slot0.couplet2_.sprite = getSpriteWithoutAtlas("TextureConfig/EmptyDream/couplets/" .. slot1.result_picture[slot2])

	if SDKTools.GetIsEnglish() then
		slot0.couplet1_text.text = GetI18NText(slot1.start_text)
		slot0.couplet2_text.text = GetI18NText(slot1.result_text[slot2])
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
