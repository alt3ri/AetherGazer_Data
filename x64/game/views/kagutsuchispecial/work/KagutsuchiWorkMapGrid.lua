slot0 = class("KagutsuchiWorkMapGrid", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.playGrid = nil
	slot0.playGridDataIndex = -1
	slot0.createPlayGridGoHandler = slot2
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeController = nil
	slot0.clearController = nil
end

function slot0.AddUIListener(slot0)
end

function slot0.BindPlayGrid(slot0, slot1)
	slot3 = slot0.createPlayGridGoHandler(slot0.transform_, KagutsuchiWorkData:GetPlayGridData(slot1))
	slot4 = {
		gameObject_ = slot3,
		transform_ = slot3.transform
	}

	ComponentBinder.GetInstance():BindCfgUI(slot4, slot4.gameObject_)

	slot0.playGridDataIndex = slot1
	slot0.playGrid = slot4
	slot0.typeController = ControllerUtil.GetController(slot4.transform_, "type")
	slot0.clearController = ControllerUtil.GetController(slot4.transform_, "clear")
	slot0.selectController = ControllerUtil.GetController(slot4.transform_, "select")

	slot0:AddBtnListener(slot4.button_, nil, function ()
		uv0:OnClickPlayGrid()
	end)
	slot0:RefreshUI()
end

function slot0.SetClickHandler(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.OnClickPlayGrid(slot0)
	if not slot0.playGrid then
		return
	end

	slot1 = slot0.playGrid

	if slot0:GetPlayGridData():IsCleared() and slot2:IsEntrust() then
		-- Nothing
	end

	slot4 = {
		activityId = ActivityConst.KAGUTSUCHI_ACTIVITY,
		reward = slot2:GetReward(),
		gridId = slot2:GetId(),
		isBattle = true,
		isEntrust = false,
		stageId = slot2:GetBattleStageId(),
		activityId = ActivityConst.KAGUTSUCHI_ACTIVITY,
		battleName = slot2:GetName(),
		battleSummary = slot2:GetSummary(),
		battleLevel = slot2:GetLevel(),
		battleCost = slot2:GetCost(),
		battleReward = slot3
	}

	if slot2:IsBattle() then
		-- Nothing
	end

	if slot2:IsEntrust() then
		slot4.isBattle = false
		slot4.isEntrust = true
		slot4.entrustName = slot2:GetName()
		slot4.entrustSummary = slot2:GetSummary()
		slot4.entrustCompleteText = slot2:GetCompleteText()
		slot4.entrustReward = slot3
	end

	if slot0.clickHandler_ then
		slot0:clickHandler_(slot4)
	end

	slot0:SetSelected(true)
end

function slot0.GetPlayGridData(slot0)
	return KagutsuchiWorkData:GetPlayGridData(slot0.playGridDataIndex)
end

function slot0.GetPosition(slot0)
	return slot0.transform_.anchoredPosition
end

function slot0.SetSelected(slot0, slot1)
	if slot1 then
		slot0.selectController:SetSelectedState(slot0:GetPlayGridData():IsEntrust() and "entrustslelct" or "battleselect")
	else
		slot0.selectController:SetSelectedState("false")
	end
end

function slot0.RefreshUI(slot0)
	if slot0.playGrid then
		slot1 = slot0.playGrid

		if slot0:GetPlayGridData():IsBoss() then
			slot0.typeController:SetSelectedState("boss")
		elseif slot2:IsEntrust() then
			slot0.typeController:SetSelectedState("entrust")
		elseif slot2:IsBattle() then
			slot0.typeController:SetSelectedState("normal")
		end

		slot1.normalLevelText_.text = "Lv." .. slot2:GetLevel()
		slot1.bossLevelText_.text = "Lv." .. slot2:GetLevel()

		if slot2:IsCleared() then
			slot0.clearController:SetSelectedState("cleared")
		else
			slot0.clearController:SetSelectedState("unclear")
		end
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
