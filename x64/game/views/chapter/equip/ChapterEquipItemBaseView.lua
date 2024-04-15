slot0 = class("ChapterEquipItemBaseView", import("..ChapterBaseItemView"))

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddRedPoint()
end

function slot0.OnExit(slot0)
	slot0:RemoveRedPoint()
	uv0.super.OnExit(slot0)
end

function slot0.AddRedPoint(slot0)
end

function slot0.RemoveRedPoint(slot0)
end

function slot0.RefreshCustomItem(slot0, slot1)
	if slot0.oldCfgID_ ~= slot1.id then
		slot0.nameText_.text = GetI18NText(slot1.name)

		SetSpriteWithoutAtlasAsync(slot0.icon_, slot1.drop_icon)

		slot0.oldCfgID_ = slot1.id
	end
end

function slot0.ClickItem(slot0, slot1)
	if slot0.isLock_ then
		ShowTips(slot0.lockTips_)

		return
	end

	if ChapterCfg[ChapterClientCfg[slot1].chapter_list[1]].type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_EQUIP then
		JumpTools.OpenPageByJump("/equipSection", {
			chapterID = slot2
		}, ViewConst.SYSTEM_ID.BATTLE_EQUIP_SECTION)

		return
	elseif slot3.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_ENCHANTMENT then
		JumpTools.OpenPageByJump("/enchantment")

		return
	elseif slot3.type == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_DAILY then
		JumpTools.OpenPageByJump("/daily", {
			chapterID = slot2
		})

		return
	elseif slot3.type == BattleConst.STAGE_TYPE_NEW.EQUIP_BREAK_THROUGH_MATERIAL then
		EquipBreakThroughMaterialAction.EnterEquipBTMaterial()

		return
	elseif slot3.type == BattleConst.STAGE_TYPE_NEW.EQUIP_SEIZURE then
		JumpTools.OpenPageByJump("/equipSeizure", {
			chapterID = slot2
		})

		return
	end
end

return slot0
