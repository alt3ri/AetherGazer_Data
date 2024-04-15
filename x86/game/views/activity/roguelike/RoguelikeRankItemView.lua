slot0 = class("RoguelikeRankItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.gameObject_:InjectUI(slot0)
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.data = slot2
	slot0.isGuild = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.data:GetSingleSelectHeroList()[1].skin_id == 0 then
		slot2 = slot1[1].hero_id
	end

	slot0.ImgHead.sprite = ItemTools.getItemSprite(slot0.data.portrait)
	slot0.ImgFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.data.frame)
	slot0.ImgRole.sprite = ItemTools.getItemSprite(slot2)

	if slot0.data.rank < 4 then
		slot0.CtrlRank:SetSelectedIndex(slot0.data.rank)
	else
		slot0.CtrlRank:SetSelectedIndex(0)
	end

	slot0.TxtRank.text = slot0.data.rank
	slot0.TxtNick.text = slot0.data.nick
	slot0.TxtScore.text = slot0.data.score
	slot0.TxtDifficulty.text = slot0.data.difficulty
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data = nil

	uv0.super.Dispose(slot0)
end

return slot0
