slot0 = class("CultureGravureEquiptItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot4 = CultureGravureRecommendEquipItem
	slot0.equiptList_ = LuaList.New(handler(slot0, slot0.IndexEquiptItem), slot0.equiptListGo_, slot4)
	slot0.infoNumController_ = slot0.equipCon_:GetController("infonum")
	slot0.equipController_ = slot0.equipCon_:GetController("state")
	slot0.infoItemList_ = {}

	for slot4 = 1, 3 do
		table.insert(slot0.infoItemList_, CultureGravureEquiptInfoItem.New(slot0["infoGo" .. slot4 .. "_"]))
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot2
	slot0.rate_ = slot2.rate
	slot0.heroID_ = slot3
	slot0.recommendIdList_ = slot2.list

	table.sort(slot0.recommendIdList_, function (slot0, slot1)
		return EquipCfg[slot0].pos < EquipCfg[slot1].pos
	end)

	slot0.stateList_ = {}
	slot0.hasAllEquipt = true
	slot0.canAllEquipt = true

	slot0:RefreshUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.equipBtn_, nil, function ()
		if uv0.hasAllEquipt or not uv0.canAllEquipt then
			return
		end

		JumpTools.OpenPageByJump("cultureGravureEquipPopView", {
			index = 0,
			heroId = uv0.heroID_,
			recommendIdList = uv0.recommendIdList_,
			stateList = uv0.stateList_
		})
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.RefreshUI(slot0)
	slot0.rateText_.text = math.floor(slot0.rate_ / 100)

	slot0.equiptList_:StartScroll(#slot0.recommendIdList_)

	slot1 = {}

	for slot6, slot7 in ipairs(slot0.recommendIdList_) do
		if not slot1[EquipCfg[slot7].suit] then
			slot1[slot8.suit] = {}
			slot2 = 0 + 1
		end

		table.insert(slot1[slot8.suit], slot7)
	end

	slot0.infoNumController_:SetSelectedState(slot2)

	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		table.insert(slot3, slot8)
	end

	if #slot3 > 1 then
		table.sort(slot3, function (slot0, slot1)
			return EquipCfg[slot0[1]].pos < EquipCfg[slot1[1]].pos
		end)
	end

	for slot7 = 1, #slot3 do
		slot0.infoItemList_[slot7]:SetData(slot7, slot3[slot7])
	end
end

function slot0.IndexEquiptItem(slot0, slot1, slot2)
	slot3 = slot0.recommendIdList_[slot1]
	slot4 = CultureGravureData:GetHasEquipt(slot3)

	if not CultureGravureData:GetEquiptIsEquipped(slot0.heroID_, slot3) then
		slot0.hasAllEquipt = false
	end

	if not slot5 and not slot4 then
		slot0.canAllEquipt = false
	end

	slot6 = ""
	slot6 = slot5 and "had" or slot4 and "equip" or "get"
	slot0.stateList_[slot1] = slot6

	slot2:SetData(slot1, slot3, slot0.heroID_, slot6)

	if slot1 == #slot0.recommendIdList_ then
		SetActive(slot0.btnGroup_, slot0.canAllEquipt)
		slot0.equipController_:SetSelectedState(tostring(slot0.hasAllEquipt))
	end
end

function slot0.Dispose(slot0)
	if slot0.equiptList_ then
		slot0.equiptList_:Dispose()

		slot0.equiptList_ = nil
	end

	if slot0.infoItemList_ then
		for slot4 = 1, #slot0.infoItemList_ do
			slot0.infoItemList_[slot4]:Dispose()
		end

		slot0.infoItemList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
