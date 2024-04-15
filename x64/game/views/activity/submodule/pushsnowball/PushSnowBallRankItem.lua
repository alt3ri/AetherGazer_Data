slot0 = class("AdvanceTestRankItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.rankText_.text = slot1.rank

	if slot2 == 1 then
		slot0.scoreText_.text = slot1.score
		slot0.campText_.text = slot1.extraInfo[1] == 1 and "Boss" or GetTips("ACTIVITY_SNOWBALL_PUSH_RANK_TEAM")

		slot0.stateController_:SetSelectedState("boss")
	else
		slot0.campText_.text = ""
		slot0.killNumText_.text = slot1.score

		slot0.stateController_:SetSelectedState("neck")
	end

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedIndex(slot1.rank - 1)
	else
		slot0.rankController_:SetSelectedIndex(3)
	end

	slot0.nameText_.text = slot1.nick
	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot1.portrait)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.frame)
end

return slot0
