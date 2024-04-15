slot0 = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.hander_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdRewardUI"), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:Refresh()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = StrongholdOperateRewardItem
	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, slot4)
	slot0.rewardController = ControllerUtil.GetController(slot0.transform_, "reward")
	slot0.specItems = {}

	for slot4 = 1, 3 do
		table.insert(slot0.specItems, StrongholdOperateRewardSpecItem.New(slot0["m_specReward" .. slot4]))
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_rewardBtn, function ()
		StrongholdAction.QueryReward(uv0.activity_id, uv0:GetAllRecevieRewardIdList())
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = true
	end

	slot0.activity_id = slot1
	slot0.rewardDataList = ActivityStrongholdRewardCfg.get_id_list_by_tag[0]

	table.sort(slot0.rewardDataList, function (slot0, slot1)
		if StrongholdData:GetRewardState(uv0, slot0) == StrongholdData:GetRewardState(uv0, slot1) then
			return slot0 < slot1
		else
			return slot2 < slot3
		end
	end)

	if slot2 then
		slot0.list:StartScroll(#slot0.rewardDataList)
	else
		slot0.list:StartScrollWithoutAnimator(#slot0.rewardDataList, slot0.list:GetScrolledPosition())
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.rewardController:SetSelectedIndex(#slot0:GetAllRecevieRewardIdList() > 0 and 1 or 0)

	for slot6, slot7 in ipairs(ActivityStrongholdRewardCfg.get_id_list_by_tag[1]) do
		if slot0.specItems[slot6] then
			slot0.specItems[slot6]:SetData(slot0.activity_id, slot7)
		end
	end
end

function slot0.GetAllRecevieRewardIdList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(ActivityStrongholdRewardCfg.all) do
		if StrongholdData:GetRewardState(slot0.activity_id, slot6) == 0 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()

	for slot4, slot5 in ipairs(slot0.specItems) do
		slot5:Dispose()
	end

	slot0.specItems = {}

	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.activity_id, slot0.rewardDataList[slot1])
end

function slot0.OnStrongholdUpdateReward(slot0)
	slot0:Refresh(slot0.activity_id, false)
end

return slot0
