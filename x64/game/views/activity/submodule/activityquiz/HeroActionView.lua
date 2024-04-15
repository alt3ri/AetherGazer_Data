slot0 = class("HeroActionView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroActList_ = {
		"happy",
		"sad",
		"angry"
	}
	slot0.punishActList_ = {
		"sheep_angry",
		"sheep_happy"
	}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, HeroActionItem)
	slot0.sizeCon_ = ControllerUtil.GetController(slot0.transform_, "size")
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.list_[slot1])
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
	slot0.list_ = slot0.heroActList_

	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshList(slot0, slot1)
	slot0.list_ = slot1 == 1 and slot0.heroActList_ or slot0.punishActList_

	slot0.sizeCon_:SetSelectedState(slot1 == 1 and "true" or "false")
	slot0.scrollHelper_:StartScroll(#slot0.list_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
