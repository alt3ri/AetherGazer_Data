slot0 = class("ActivityAttributeArenaRankItem", ReduxView)

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

	slot0.heroCountController_ = slot0.conExCollection_:GetController("heroCount")
	slot0.rankController_ = slot0.conExCollection_:GetController("rank")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.userID_ = slot1.user_id
	slot0.nickText_.text = slot1.nick
	slot0.headImg_.sprite = ItemTools.getItemSprite(slot1.portrait)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.frame)
	slot0.rankText_.text = slot1.rank
	slot0.scoreText_.text = slot1.score
	slot3 = math.min(table.length(slot1:GetSingleSelectHeroList()), 3)

	if slot0.heroCountController_ then
		slot0.heroCountController_:SetSelectedState(slot3)
	end

	for slot7 = 1, slot3 do
		if slot2[slot7].skin_id == 0 then
			slot9 = slot8.hero_id
		end

		slot0["heroImg_" .. slot7].sprite = getSpriteViaConfig("HeroLittleIcon", slot9)
	end

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedState(slot1.rank)
	else
		slot0.rankController_:SetSelectedState(0)
	end
end

return slot0
