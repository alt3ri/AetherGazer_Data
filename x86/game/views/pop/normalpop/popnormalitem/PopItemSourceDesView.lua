slot0 = class("PopItemSourceDesView", import("game.views.pop.PopItemView"))
slot1 = import("game.tools.ItemTools")

function slot0.CustomInitUI(slot0)
	slot0.soureceDesControllerController:SetSelectedState("show")
	slot0.tabControllerController:SetSelectedState("descripe")
	slot0.btnShowControllerController:SetSelectedState("hide")
end

function slot0.RefreshContent(slot0)
	slot2 = ItemCfg[slot0.itemInfo_.id]
	slot0.nameText_.text = uv0.getItemName(slot2.id)
	slot0.countentText_.text = uv0.getItemDesc(slot2.id)

	if slot2.time == nil or slot2.time == "" then
		slot0.timeController:SetSelectedState("no")
	elseif uv0.GetItemExpiredTimeByInfo(slot1) <= manager.time:GetServerTime() then
		slot0.timeController:SetSelectedState("no")
	else
		slot0.timeController:SetSelectedState("yes")

		slot0.timeLabel_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(slot3, "!%Y/%m/%d %H:%M"))
	end

	if slot2.type == ItemConst.ITEM_TYPE.STICKER then
		if slot0.extraInfo_.isForeign then
			SetActive(slot0.isLockGo_, false)
		else
			SetActive(slot0.isLockGo_, PlayerData:GetSticker(slot2.id).unlock == 0)
		end
	else
		SetActive(slot0.isLockGo_, false)
	end

	slot0.sourceDesTxt_.text = GetI18NText(slot2.desc_source) or ""
end

return slot0
