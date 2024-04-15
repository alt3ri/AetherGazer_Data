slot0 = class("AdminCatExploreEventView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data = slot1
	slot0.adminCatID = slot2
	slot0.startTime = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = ExploringEventCfg[slot0.data.content]
	slot0.timeTxt_.text = manager.time:DescCDTime(slot0.data.time)

	if slot1.event_type == 3 then
		slot8 = "EXPLORE_PROCESS_EVENT_REWARD"

		for slot8, slot9 in ipairs(slot1.reward) do
			slot4 = GetI18NText(ExploreMeowCfg[slot0.adminCatID].meow_name) .. GetI18NText(ExploringEventCfg[slot0.data.address].description) .. GetI18NText(slot1.description) .. "\n" .. GetTips(slot8) .. "<color=#CFB9FB>" .. ItemTools.getItemName(slot9[1]) .. " x " .. slot9[2] .. "</color>  "
		end
	end

	slot0.contentTxt_.text = slot4
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
