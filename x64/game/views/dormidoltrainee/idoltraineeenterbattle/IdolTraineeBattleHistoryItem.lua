slot0 = class("IdolTraineeBattleHistoryItem", ReduxView)

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

	slot0.firendController = slot0.controller:GetController("type")
	slot0.resultController = slot0.controller:GetController("result")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.battleID = slot1.battleID
	slot0.userID = slot1.userID
	slot0.friendType = FriendsData:IsFriend(slot0.userID) and 1 or 2
	slot0.name_.text = slot1.nick
	slot0.playerIcon_.sprite = ItemTools.getItemSprite(slot1.icon)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.icon_frame)

	if slot0.friendType == IdolTraineeConst.friendType.friend then
		slot0.firendController:SetSelectedState("friend")
	elseif slot0.friendType == IdolTraineeConst.friendType.stranger then
		slot0.firendController:SetSelectedState("stranger")
	end

	if slot1.battle_result == 1 then
		slot0.resultController:SetSelectedState("success")
	elseif slot1.battle_result == 2 then
		slot0.resultController:SetSelectedState("fail")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.replayBtn_, nil, function ()
		BackHomeCricketAction.AskBattleHistorySimpleData(uv0.battleID, function ()
		end)
	end)
	slot0:AddBtnListener(slot0.tryAgainBtn_, nil, function ()
		BackHomeCricketAction:AskPvPBattleData(uv0.userID, uv0.friendType, IdolTraineeData:GetCurPVPStage())
	end)
	slot0:AddBtnListener(slot0.playerBtn_, nil, function ()
		if uv0.userID then
			ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.userID)
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
