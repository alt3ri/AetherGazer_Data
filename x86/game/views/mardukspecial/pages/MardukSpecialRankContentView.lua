slot0 = class("MardukSpecialRankContentView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.listGo_, MardukSpecialRankItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.data_.rankList[slot1])
end

function slot0.AddUIListener(slot0)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityId_ = activityId
	slot0.battleId_ = slot1
	slot0.battleCfg_ = BattleQuickTrainingCfg[slot1]
	slot0.data_ = RankData:GetActivityRank(slot2)

	slot0:UpdateView()
end

function slot0.SetMySelfData(slot0, slot1)
	slot2 = PlayerData:GetPlayerInfo()
	slot0.frame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)
	slot0.name_.text = GetI18NText(slot2.nick)
	slot0.icon_.sprite = ItemTools.getItemSprite(slot2 and slot2.portrait)
	slot0.battleId_ = slot1
	slot0.battleCfg_ = BattleQuickTrainingCfg[slot1]
	slot0.rankNameLabel_.text = slot0.battleCfg_.name
end

function slot0.UpdateView(slot0)
	if not slot0.data_ then
		return
	end

	slot0.uiList_:StartScroll(#slot0.data_.rankList)

	if slot0.data_.myRank and slot1.score > 0 then
		if slot1.rank >= 1 and slot3 <= 100 then
			slot0.rank_.text = slot3
			slot0.score_.text = slot1.score
		else
			slot0.rank_.text = string.format("%.2f", slot3 / (slot0.data_.total or 1) * 100) .. "%"
			slot0.score_.text = slot2
		end
	else
		slot0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
		slot0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
	end
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
	slot0.data_ = nil

	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
