slot0 = class("DestroyBoxGameNormalView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.difficultController_ = ControllerUtil.GetController(slot0.transform_, "difficult")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.boxItemList_ = {}
	slot0.selectDifficult_ = 1
end

function slot0.OnEnter(slot0, slot1)
	slot0.mainActivityID_ = slot1
	slot0.selectID_ = DestroyBoxGameData:GetSelectID(slot1)
	slot0.selectDifficult_ = DestroyBoxGameData:GetSelectDifficult(slot1)

	for slot6, slot7 in ipairs(DestroyBoxGameData:GetDifficultList(slot1)[slot0.selectDifficult_]) do
		slot0.boxItemList_[slot6] = slot0.boxItemList_[slot6] or DestroyBoxGameNormalItemView.New(slot0.itemGo_, slot0.itemParent_)

		slot0.boxItemList_[slot6]:OnEnter(slot7)
	end

	slot0:RefreshDifficult()
	slot0:AddRedPoint()
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.boxItemList_) do
		slot5:OnExit()
	end

	slot0:RemoveRedPoint()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in ipairs(slot0.boxItemList_) do
		slot5:Dispose()
	end

	slot0.boxItemList_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.normalBtn_, nil, function ()
		uv0:SwitchDifficult(2)
	end)
	slot0:AddBtnListener(slot0.hardBtn_, nil, function ()
		uv0:SwitchDifficult(1)
	end)
end

function slot0.RefreshDifficult(slot0)
	if slot0.selectDifficult_ == 1 then
		slot0.difficultController_:SetSelectedState("normal")
	else
		slot0.difficultController_:SetSelectedState("hard")
	end
end

function slot0.SwitchDifficult(slot0, slot1)
	if slot0.selectDifficult_ ~= slot1 then
		slot0.selectDifficult_ = slot1
		slot0.selectID_ = DestroyBoxGameData:SwitchDifficult(slot0.selectID_, slot0.selectDifficult_)

		DestroyBoxGameData:SetSelectIDAndDifficult(DestroyBoxGameCfg[slot0.selectID_].main_activity_id, slot0.selectID_, slot0.selectDifficult_)
		slot0:RefreshItemList()
		slot0:RefreshScore()
		slot0:RefreshDifficult()
	end
end

function slot0.SwitchSelectItem(slot0, slot1)
	slot0.selectID_ = slot1

	for slot5, slot6 in ipairs(slot0.boxItemList_) do
		slot6:SwitchSelectItem(slot1)
	end

	slot0:RefreshScore()
end

function slot0.RefreshItemList(slot0)
	for slot4, slot5 in ipairs(slot0.boxItemList_) do
		slot5:SwitchDifficult()
	end
end

function slot0.RefreshScore(slot0)
	if DestroyBoxGameData:GetStageData(DestroyBoxGameData:GetLastSelectNormalID(slot0.mainActivityID_)) then
		slot0.scoreText_.text = slot2.maxScore
	else
		slot0.scoreText_.text = 0
	end

	slot0.numText_.text = string.format("%02d", table.keyof(DestroyBoxGameData:GetDifficultList(slot0.mainActivityID_)[slot0.selectDifficult_], slot1))

	if DestroyBoxGameData:IsFinishPreStage(slot1) then
		slot0.lockController_:SetSelectedState("false")
	else
		slot0.lockController_:SetSelectedState("true")

		if DestroyBoxGameCfg[DestroyBoxGameCfg[slot1].unlock_condition[1]].difficult == 1 then
			slot7 = GetTips("HARDLEVEL_EASY")
		elseif slot7 == 2 then
			slot7 = GetTips("HARDLEVEL_HARD")
		end

		slot0.lockText_.text = string.format(GetTips("DESTROY_BOX_GAME_UNLOCK_STAGE_1"), ActivityCfg[slot6.activity_id].remark, slot7, slot5[2])
	end
end

function slot0.AddRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.normalGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 1, slot0.mainActivityID_))
	manager.redPoint:bindUIandKey(slot0.hardGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 2, slot0.mainActivityID_))
end

function slot0.RemoveRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.normalGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 1, slot0.mainActivityID_))
	manager.redPoint:unbindUIandKey(slot0.hardGo_.transform, string.format("%s_%s_%s", RedPointConst.DESTROY_BOX_GAME_STAGE, 2, slot0.mainActivityID_))
end

return slot0
