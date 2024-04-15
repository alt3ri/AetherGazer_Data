slot0 = class("IndiaNianStageDescItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "selected")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not IndiaNianData:GetStageHasClearedByID(uv0.cfg_.id) then
			ShowTips("ACTIVITY_INDIA_NIAN_DESC_LOCK")
		end

		IndiaNianData:SetSelectedDescIndex(uv0.index_)

		if uv0.callBack then
			uv0.callBack(uv0.index_)
		end
	end)
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = slot0.cfg_.name
	slot0.iconImg_.sprite = getSprite("Atlas/IndiaUI_2_8", slot0.cfg_.icon)

	slot0:RefreshState()
end

function slot0.RefreshState(slot0)
	slot1 = getData("ActivityIndiaNian" .. IndiaNianData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "unlockNewStage" .. slot0.cfg_.id) == 1
	slot3 = IndiaNianData:GetStageHasClearedByID(slot0.cfg_.id)
	slot4 = slot0.index_ == IndiaNianData:GetSelectedDescIndex()

	if IndiaNianData:GetRound() < slot0.cfg_.round then
		slot0.controller_:SetSelectedState("lock")
	elseif slot3 then
		slot0.controller_:SetSelectedState("open")
	end

	slot0.selectController_:SetSelectedState(tostring(slot4))

	if slot3 then
		SetActive(slot0.effectGo_, not slot1)
	end
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callBack = slot1
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.cfg_ = slot2

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	if IndiaNianData:GetStageHasClearedByID(slot0.cfg_.id) then
		saveData("ActivityIndiaNian" .. IndiaNianData:GetActivityID() .. PlayerData:GetPlayerInfo().userID, "unlockNewStage" .. slot0.cfg_.id, 1)
	end
end

return slot0
