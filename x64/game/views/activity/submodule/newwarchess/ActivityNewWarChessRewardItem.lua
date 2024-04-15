slot0 = class("ActivityNewWarChessRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, ActivityNewWarChessRewardItemItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.levelCfg_.id_level, slot0.activityId_, slot0.levelCfg_.explore[slot1])
end

function slot0.SetData(slot0, slot1)
	slot0.activityId_ = slot1
	slot0.levelCfg_ = NewWarChessLevelCfg[NewWarChessLevelCfg.get_id_list_by_activity[slot0.activityId_][1]]
	slot0.m_title.text = slot0.levelCfg_.name_level

	slot0.uiList_:StartScroll(#slot0.levelCfg_.explore)
end

function slot0.UpdateView(slot0)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
