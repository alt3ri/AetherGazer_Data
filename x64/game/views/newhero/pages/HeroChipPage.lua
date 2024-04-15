slot1 = class("HeroChipPage", import("game.views.newHero.HeroPageBase"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.chipCout_ = 4

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.isSelfController_ = slot0.controller_:GetController("isSelf")
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.chipItem_ = {}

	for slot4 = 1, slot0.chipCout_ do
		slot0.chipItem_[slot4] = NewHeroChipPageItem.New(Object.Instantiate(slot0.chipItemGo_, slot0.chipContent_, false))
	end
end

function slot1.AddUIListener(slot0)
end

function slot1.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot1.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		6,
		0
	})
end

function slot1.UpdateView(slot0)
	if ChipCfg.get_id_list_by_spec_char[slot0.heroInfo_.id] then
		slot1 = nil

		if not ChipData:GetEnableHeroChipIdByHeroId(slot0.heroInfo_.id) then
			return
		end

		slot2 = {
			[ChipCfg[slot7].role_type_id] = true
		}
		slot6 = slot0.heroInfo_.id

		for slot6, slot7 in pairs(ChipCfg.get_id_list_by_spec_char[slot6]) do
			-- Nothing
		end

		for slot6 = 1, 4 do
			slot0.chipItem_[slot6]:SetData(slot1[slot6], slot0.heroInfo_.id, slot6, slot0.extra_)
			slot0.chipItem_[slot6]:BindRedPoint()

			if slot2[slot6] then
				slot0.chipItem_[slot6]:SetIsShow(true)
			else
				slot0.chipItem_[slot6]:SetIsShow(false)
			end
		end

		LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
		slot0:CheckLocked()
	end
end

function slot1.CheckLocked(slot0)
	slot0.isSelfController_:SetSelectedState(slot0.heroViewProxy_.isSelf and "true" or "false")
end

function slot1.OnExit(slot0)
	for slot4 = 1, 4 do
		slot0.chipItem_[slot4]:UnBindRedPoint()
	end
end

function slot1.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1
end

function slot1.Show(slot0)
	uv0.super.Show(slot0)
	slot0:UpdateView()
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.chipItem_) do
		slot5:UnBindRedPoint()
		slot5:Dispose()
	end

	slot0.chipItem_ = nil
end

return slot1
