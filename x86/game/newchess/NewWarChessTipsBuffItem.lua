slot0 = class("NewWarChessTipsBuffItem")

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.buffEntity_ = slot3
	slot0.cfg_ = NewWarChessBuffPoolCfg[slot0.buffEntity_.buffPoolID]

	slot0:RefreshUI()

	if slot1 == slot2 then
		SetActive(slot0.arrowGo_, true)
	else
		SetActive(slot0.arrowGo_, false)
	end
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = slot0.cfg_.name
	slot0.icon_.sprite = getSprite("Atlas/NewWarChess", slot0.cfg_.icon)

	if slot0.buffEntity_.CurRemainRound and slot0.buffEntity_.CurRemainRound > 0 then
		SetActive(slot0.remainGo_, true)

		slot0.remainText_.text = slot0.buffEntity_.CurRemainRound
	else
		SetActive(slot0.remainGo_, false)
	end

	if slot0.buffEntity_.CurUpdateRound then
		SetActive(slot0.updateGo_, true)

		slot0.updateText_.text = slot0.buffEntity_.CurUpdateRound
		slot0.updateImage_.fillAmount = slot0.buffEntity_.CurUpdateRound / slot0.buffEntity_.UpdateRound
	else
		SetActive(slot0.updateGo_, false)
	end
end

function slot0.Dispose(slot0)
end

return slot0
