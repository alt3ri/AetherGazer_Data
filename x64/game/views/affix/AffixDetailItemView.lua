slot0 = class("AffixDetailItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.cfg_ = AffixTypeCfg[slot2[1]]
	slot0.level_ = slot2[2]
	slot0.type_ = slot2[3]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.icon_.sprite = getAffixSprite(slot0.data_)
	slot0.nameLabel_.text = getAffixName(slot0.data_)
	slot0.descLabel_.text = getAffixDesc(slot0.data_)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
