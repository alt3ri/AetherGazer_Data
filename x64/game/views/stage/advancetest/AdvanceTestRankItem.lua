slot0 = class("AdvanceTestRankItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddListeners()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.rankController_ = slot0.conExCollection_:GetController("rank")
	slot0.heroCountController_ = slot0.conExCollection_:GetController("heroCount")
end

function slot0.AddListeners(slot0)
end

function slot0.Refresh(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.rankText_.text = slot1.rank
	slot0.scoreText_.text = slot1.score

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedIndex(slot1.rank)
	else
		slot0.rankController_:SetSelectedIndex(0)
	end

	slot0.name_ = slot1.nick
	slot0.nickText_.text = slot1.nick
	slot0.headImg_.sprite = ItemTools.getItemSprite(slot1.portrait)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.frame)
	slot3 = math.min(#slot1:GetSingleSelectHeroList(), 3)
	slot7 = slot3

	slot0.heroCountController_:SetSelectedIndex(slot7)

	for slot7 = 1, slot3 do
		if slot2[slot7].skin_id == 0 then
			slot8 = slot2[slot7].hero_id
		end

		slot0["heroImg_" .. slot7].sprite = getSpriteViaConfig("HeroLittleIcon", slot8)
	end
end

function firstLargeSize(slot0, slot1)
	if #slot0 <= 0 then
		return slot0
	end

	slot2, slot3, slot4, slot5 = string.find(slot0, "<(.-)>(.+)")
	slot7 = 0
	slot8 = nil
	slot12 = slot5 or slot0

	for slot12 = 1, slot5.getWCharCount(slot12) do
		if table.indexOf({
			"“",
			"《"
		}, slot5:getWChar(slot12)) == -1 then
			slot8 = string.format("%s<size=%d>%s</size>%s", string.sub(slot5, 1, slot7), slot1, slot13, string.sub(slot5, slot7 + string.len(slot13) + 1, -1))

			break
		else
			slot7 = slot7 + string.len(slot13)
		end
	end

	if not slot8 then
		return slot0
	end

	if slot4 then
		slot8 = string.format("<%s>%s", slot4, slot8)
	end

	return slot8
end

return slot0
