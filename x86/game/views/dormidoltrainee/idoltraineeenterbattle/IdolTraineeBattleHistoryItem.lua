local var_0_0 = class("IdolTraineeBattleHistoryItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.firendController = arg_3_0.controller:GetController("type")
	arg_3_0.resultController = arg_3_0.controller:GetController("result")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1)
	arg_4_0.battleID = arg_4_1.battleID
	arg_4_0.userID = arg_4_1.userID
	arg_4_0.friendType = FriendsData:IsFriend(arg_4_0.userID) and 1 or 2
	arg_4_0.name_.text = arg_4_1.nick
	arg_4_0.playerIcon_.sprite = ItemTools.getItemSprite(arg_4_1.icon)
	arg_4_0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. arg_4_1.icon_frame)

	if arg_4_0.friendType == IdolTraineeConst.friendType.friend then
		arg_4_0.firendController:SetSelectedState("friend")
	elseif arg_4_0.friendType == IdolTraineeConst.friendType.stranger then
		arg_4_0.firendController:SetSelectedState("stranger")
	end

	if arg_4_1.battle_result == 1 then
		arg_4_0.resultController:SetSelectedState("success")
	elseif arg_4_1.battle_result == 2 then
		arg_4_0.resultController:SetSelectedState("fail")
	end
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.replayBtn_, nil, function()
		BackHomeCricketAction.AskBattleHistorySimpleData(arg_5_0.battleID, function()
			return
		end)
	end)
	arg_5_0:AddBtnListener(arg_5_0.tryAgainBtn_, nil, function()
		local var_8_0 = IdolTraineeData:GetCurPVPStage()

		BackHomeCricketAction:AskPvPBattleData(arg_5_0.userID, arg_5_0.friendType, var_8_0)
	end)
	arg_5_0:AddBtnListener(arg_5_0.playerBtn_, nil, function()
		if arg_5_0.userID then
			ForeignInfoAction:TryToCheckForeignDetailInfo(arg_5_0.userID)
		end
	end)
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0.gameObject_ = nil
	arg_10_0.transform_ = nil

	var_0_0.super.Dispose(arg_10_0)
end

return var_0_0
