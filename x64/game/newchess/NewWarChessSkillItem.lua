slot0 = class("NewWarChessSkillItem", ReduxView)

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
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. uv0.data_.skillID, 0)
			uv0.clickHandler_(uv0.data_.skillID)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1
	slot0.cfg_ = NewWarChessDiceSkillCfg[slot0.data_.skillID]
	slot0.leftUseLimit_ = slot0.data_.useLimit
	slot0.totalUseLimit_ = slot0.cfg_.use_limit
	slot0.name_ = slot0.cfg_.name

	slot0:RefreshUI()

	slot0.btn_.interactable = false
end

function slot0.RefreshUI(slot0)
	slot0.title_.text = slot0.name_
	slot0.iconImage_.sprite = getSprite("Atlas/NewWarChess", slot0.cfg_.icon)
	slot0.useText_.text = slot0.leftUseLimit_ .. "/" .. slot0.totalUseLimit_
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickHandler_ = slot1
	slot0.btn_.interactable = true
end

function slot0.BindSkillRedPoint(slot0)
	slot0.enableRed_ = true

	if slot0.data_ then
		manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. slot0.data_.skillID)
	end
end

function slot0.Dispose(slot0)
	slot0.clickHandler_ = nil

	if slot0.enableRed_ and slot0.data_ then
		manager.redPoint:unbindUIandKey(slot0.transform_, RedPointConst.NEW_WARCHESS_NEW_DICESKILL .. slot0.data_.skillID)
	end

	uv0.super.Dispose(slot0)
end

return slot0
