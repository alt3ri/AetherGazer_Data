slot0 = class("HanafudaCombineItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.cardList_, HanafudaCardView)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.cfg_ = slot2
	slot0.playerType_ = slot3

	if slot0.playerType_ then
		slot0.cardDataList_ = HanafudaData:GetCardsListByType(slot0.playerType_)
	end

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshItem()
end

function slot0.RefreshItem(slot0)
	slot1 = slot0.cfg_.card_list
	slot0.nameText_.text = slot0.cfg_.name
	slot0.scoreText_.text = string.format(GetTips("ACTIVITY_KAGUTSUCHI_CARD_SCORE_TIPS"), slot0.cfg_.score)
	slot0.hasCard_ = {}

	if slot0.clearGo_ then
		slot2 = true

		for slot6, slot7 in ipairs(slot1) do
			if not HanafudaData:GetHasCardByPlaceTypeAndCardId(slot0.playerType_, slot7) then
				slot2 = false
				slot0.hasCard_[slot6] = false
			else
				slot0.hasCard_[slot6] = true
			end
		end

		SetActive(slot0.clearGo_, slot2)
	end

	if slot0.collectGo_ then
		SetActive(slot0.collectGo_, HanafudaData:GetIsComplete(slot0.cfg_.id))
	end

	slot0.uiList_:StartScroll(#slot1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, HanafudaCardCfg[slot0.cfg_.card_list[slot1]], slot0.hasCard_[slot1])
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
