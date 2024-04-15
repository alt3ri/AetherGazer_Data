slot0 = class("ActivityRaceRankItem", ReduxView)

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

	slot0.rankController_ = ControllerUtil.GetController(slot0.transform_, "rank")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.userID_ = slot1.user_id
	slot0.name_.text = slot1.nick
	slot0.icon_.sprite = ItemTools.getItemSprite(slot1.portrait)
	slot0.frame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.frame)
	slot0.rank_.text = slot1.rank
	slot0.score_.text = slot1.score

	if slot1.rank <= 3 then
		slot0.rankController_:SetSelectedState(slot1.rank)
	else
		slot0.rankController_:SetSelectedState(0)
	end
end

return slot0
