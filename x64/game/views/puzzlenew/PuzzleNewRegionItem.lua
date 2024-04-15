slot0 = class("PuzzleNewRegionItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.regionCfg_ = slot2
	slot0.regionID_ = slot2[1]
	slot0.puzzleDic_ = {}

	for slot8, slot9 in ipairs(slot2[2]) do
		slot0.puzzleDic_[slot9] = slot3[slot9]
	end

	slot0.rewardCfg_ = slot4
	slot0.statusConst_ = {
		UNFINISH = 0,
		RECEIVED = 1
	}

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListener(slot0)
end

function slot0.Dispose(slot0)
	slot0.receiveCallback_ = nil
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReward()
	slot0:RefreshStatus()
end

function slot0.RefreshReward(slot0)
	if slot0.commonItem_ == nil then
		slot0.commonItem_ = CommonItem.New(slot0.rewardItemGo_)
	end

	slot0.commonItem_:RefreshData(formatReward(slot0.rewardCfg_[1]))
	slot0.commonItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.rewardCfg_[1])
	end)
	slot0.commonItem_:Show(true)
end

function slot0.RefreshStatus(slot0)
	if PuzzleNewData:GetRegionReceivedList(slot0.activityID_)[slot0.regionID_] == true then
		slot0.status_ = slot0.statusConst_.RECEIVED
	else
		slot0.status_ = slot0.statusConst_.UNFINISH
		slot2 = PuzzleNewData:GetCurPuzzleList(slot0.activityID_)

		for slot7, slot8 in pairs(slot0.puzzleDic_) do
			if slot2[slot8] and slot2[slot8] == slot7 then
				slot3 = 0 + 1
			end
		end

		slot0.curText_.text = slot3
		slot0.needText_.text = string.format("/%d", #slot0.regionCfg_[2])
	end

	slot0.statusController_:SetSelectedIndex(slot0.status_)
end

function slot0.RegisterReceiveCallback(slot0, slot1)
	slot0.receiveCallback_ = slot1
end

return slot0
