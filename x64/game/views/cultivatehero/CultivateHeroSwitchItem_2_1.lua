slot1 = class("CultivateHeroSwitchItem_2_1", import("game.views.cultivateHero.CultivateHeroSwitchItem"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "Item")
end

function slot1.RefreshImage(slot0)
	slot0.icon_.sprite = getSpriteViaConfig("HeroIcon", CultivateHeroTaskCfg[CultivateHeroTaskCfg.get_id_list_by_group_id[slot0.groupID_][1]].hero)
end

function slot1.RefreshSelect(slot0, slot1)
	slot0.statusController_:SetSelectedIndex(slot0.groupID_ == slot1 and 1 or 0)
end

return slot1
