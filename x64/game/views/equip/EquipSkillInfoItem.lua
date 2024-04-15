slot0 = class("EquipSkillInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.info_ = slot2

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0)
	slot0.infoCG_.alpha = slot0.info_.alpha
	slot0.lv_.text = slot0.info_.level
	slot0.desc_.text = slot0.info_.desc
end

function slot0.GetItemInfo(slot0)
	return slot0.info_
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
