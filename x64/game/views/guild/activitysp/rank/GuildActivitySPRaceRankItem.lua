slot0 = class("GuildActivitySPRaceRankItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroCountController_ = ControllerUtil.GetController(slot0.transform_, "heroCount")
	slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.userID_ = slot1.user_id
	slot0.name_.text = slot1.nick
	slot0.icon_.sprite = ItemTools.getItemSprite(slot1.icon)
	slot0.frame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.icon_frame)
	slot0.rank_.text = slot1.rank
	slot0.score_.text = slot1.score
	slot3 = math.min(table.length(slot1.select_hero_id_list), 3)
	slot7 = slot3

	slot0.heroCountController_:SetSelectedState(slot7)

	for slot7 = 1, slot3 do
		slot0["m_heroIcon_" .. slot7].sprite = getSpriteViaConfig("HeroLittleIcon", slot2[slot7])
	end

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedState(slot1.rank)
	else
		slot0.rankController_:SetSelectedState(0)
	end
end

return slot0
