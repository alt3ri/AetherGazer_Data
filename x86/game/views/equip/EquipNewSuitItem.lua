slot0 = class("EquipNewSuitItem", ReduxView)
slot1 = import("game.tools.EquipTools")

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:Init()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.heroData_ = slot1
	slot0.info_ = slot2

	slot0:Render()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.activeController_ = slot0.activeCon_:GetController("active")

	TerminologyTools.AddTerminologyHandler(slot0, slot0.desc_, nil, )
end

function slot0.Render(slot0)
	slot0:RefreshUI()
end

function slot0.Init(slot0)
end

function slot0.RefreshUI(slot0)
	if slot0.info_ then
		slot4 = EquipSuitCfg[slot0.info_.id]
		slot5 = slot4.need
		slot0.name_.text = GetI18NText(slot4.name)

		if slot0.info_.equipId == nil and true or HeroData:GetEquipMap()[slot0.info_.equipId] ~= nil then
			slot0.activeController_:SetSelectedState(uv0.GetSuitNeedNum(slot0.info_.id, HeroTools.GetIsSuitNumCut(slot0.heroData_)) <= slot0.info_.num and "active" or "inactive")
		else
			slot0.activeController_:SetSelectedState("normal")
		end

		slot0.num_.text = string.format(GetTips("EQUIP_SUIT_NUM"), slot5)
		slot0.desc_.text = GetI18NText(uv0.GetEffectDesc(slot4.suit_effect[1]))
	end
end

function slot0.ShowSelect(slot0, slot1)
	SetActive(slot0.select_, slot1)
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0.clickFunc(slot0.info_)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	slot0.clickFunc = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
