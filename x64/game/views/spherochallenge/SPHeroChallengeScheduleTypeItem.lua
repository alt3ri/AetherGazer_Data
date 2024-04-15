slot0 = class("SPHeroChallengeScheduleTypeItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.type = slot3
	slot0.gameObject_ = GameObject.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:InitItem()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.InitItem(slot0)
	slot0.typeName.text = SPHeroChallengeTools:GetScheduleTypeName(slot0.type)

	if ActivityHeroChallengeScheduleCfg.get_id_list_by_type[slot0.type] and not slot0.scheduleList then
		slot0.scheduleList = {}

		for slot5, slot6 in ipairs(slot1) do
			slot0.scheduleList[slot6] = SPHeroChallengeScheduleDailyItem.New(slot0.scheduleItem, slot0.contentTrs_, slot6)
		end
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
end

function slot0.RefreshUI(slot0)
	if slot0.scheduleList then
		for slot4, slot5 in pairs(slot0.scheduleList) do
			if slot5:RefreshUI() then
				slot5.transform_:SetAsLastSibling()
			end
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	end
end

function slot0.Dispose(slot0)
	if slot0.scheduleList then
		for slot4, slot5 in pairs(slot0.scheduleList) do
			slot5:Dispose()
		end
	end

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
