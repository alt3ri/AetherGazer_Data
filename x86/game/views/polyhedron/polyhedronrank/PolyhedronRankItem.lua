slot0 = class("PolyhedronRankItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rankController_ = slot0.conExCollection_:GetController("rank")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.viewBtn_, nil, function ()
		JumpTools.OpenPageByJump("polyhedronRankSquads", {
			list = uv0.heroList_
		})
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.user_id = slot1.user_id
	slot0.rankText_.text = GetI18NText(slot1.rank)
	slot0.scoreText_.text = GetI18NText(slot1.score)
	slot0.layerText_.text = GetI18NText(slot1.difficulty)
	slot0.heroList_ = slot1:GetSingleSelectHeroList()

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedIndex(slot1.rank)
	else
		slot0.rankController_:SetSelectedIndex(0)
	end

	slot0.nickText_.text = GetI18NText(slot1.nick)
	slot0.headImg_.sprite = ItemTools.getItemSprite(slot1.portrait)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.frame)
end

return slot0
