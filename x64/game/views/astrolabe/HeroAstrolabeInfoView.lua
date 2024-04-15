slot0 = class("HeroAstrolabeInfoView", HeroAstrolabeBaseInfoView)

function slot0.InitUI(slot0)
	slot0.super.InitUI(slot0)

	slot0.itemS_ = {}

	for slot4 = 1, 3 do
		slot0.itemS_[slot4] = {}

		for slot8 = 1, 3 do
			slot0.itemS_[slot4][slot8] = AstrolabeItem.New(slot0, Object.Instantiate(slot0.nodeitemGo_1, slot0[string.format("item%d_%dGo_", slot4, slot8)].transform), slot4)
		end
	end
end

function slot0.AddUIListener(slot0)
end

function slot0.ChangeStyle(slot0, slot1)
	slot0.styleController_:SetSelectedState(slot1)
end

function slot0.AddUIListener(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.heroInfo_ = slot1
	slot0.astrolabeInfo_ = slot2

	for slot6, slot7 in ipairs(slot0.itemS_ or {}) do
		for slot12, slot13 in ipairs(slot7) do
			slot13:SetNodeNameIsHide(slot0.isHideNodeName)
			slot13:SetProxy(slot0.heroViewProxy_)
			slot13:RefreshUI(slot0.astrolabeInfo_[slot6].astrolabe[slot12])
		end
	end
end

function slot0.RefreshRedPoint(slot0)
	for slot4, slot5 in ipairs(slot0.itemS_) do
		for slot9, slot10 in ipairs(slot5) do
			slot11 = slot10:GetItemInfo()

			if slot0.heroViewProxy_ and (slot0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW or slot0.heroViewProxy_.viewDataType == HeroConst.HERO_DATA_TYPE.POLYHEDRON) then
				slot10:SetRedPoint(false)
			else
				slot10:SetRedPoint(AstrolabeTools.GetIsCanUnlock(slot11.id, slot11.heroId))
			end
		end
	end
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.OnExit(slot0)
end

function slot0.GetFirstSelectItem(slot0)
	if slot0.heroInfo_ and slot0.astrolabeInfo_ and slot0.heroInfo_.using_astrolabe[#slot0.heroInfo_.using_astrolabe] then
		for slot5, slot6 in ipairs(slot0.itemS_ or {}) do
			for slot10, slot11 in ipairs(slot6) do
				if slot11:GetItemInfo().id == slot1 then
					return slot11
				end
			end
		end
	end

	return slot0:GetItem(1, 1)
end

function slot0.GetItem(slot0, slot1, slot2)
	return slot0.itemS_[slot1][slot2]
end

function slot0.RegistCallBack(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemS_ or {}) do
		for slot10, slot11 in ipairs(slot6) do
			slot11:RegistCallBack(slot1)
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.itemS_ then
		for slot4, slot5 in ipairs(slot0.itemS_) do
			for slot9, slot10 in ipairs(slot5) do
				slot10:Dispose()
			end
		end
	end

	slot0.itemSGo_ = nil
	slot0.itemS_ = nil
	slot0.astrolabeInfo_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetNodeNameIsHide(slot0, slot1)
	slot0.isHideNodeName = slot1
end

return slot0
