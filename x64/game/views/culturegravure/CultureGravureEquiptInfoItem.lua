slot0 = class("CultureGravureEquiptInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot4 = "num"
	slot0.posNumController_ = ControllerUtil.GetController(slot0.transform_, slot4)
	slot0.posController_ = {}

	for slot4 = 1, 3 do
		slot0.posController_[slot4] = ControllerUtil.GetController(slot0["posStateTrs" .. slot4 .. "_"], "pos")
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.equipIDList_ = slot2

	table.sort(slot0.equipIDList_, function (slot0, slot1)
		return EquipCfg[slot0].pos < EquipCfg[slot1].pos
	end)
	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = EquipSuitCfg[EquipCfg[slot0.equipIDList_[1]].suit].name
	slot4 = #slot0.equipIDList_

	slot0.posNumController_:SetSelectedState(slot4)

	for slot4 = 1, #slot0.equipIDList_ do
		slot0.posController_[slot4]:SetSelectedState(EquipCfg[slot0.equipIDList_[slot4]].pos)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
