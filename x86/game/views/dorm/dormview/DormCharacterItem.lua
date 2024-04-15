local var_0_0 = class("DormCharacterItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:InitUI()
end

function var_0_0.InitUI(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddUIListener()

	arg_2_0.characterStateController = ControllerUtil.GetController(arg_2_0.transform_, "name")
	arg_2_0.fatigueController = ControllerUtil.GetController(arg_2_0.transform_, "fatigue")
	arg_2_0.positionController = ControllerUtil.GetController(arg_2_0.transform_, "position")
	arg_2_0.curPisitionController = ControllerUtil.GetController(arg_2_0.transform_, "currentPosition")
	arg_2_0.maskController = ControllerUtil.GetController(arg_2_0.transform_, "mask")
	arg_2_0.sameNameController = ControllerUtil.GetController(arg_2_0.transform_, "sameName")
end

function var_0_0.AddUIListener(arg_3_0)
	arg_3_0.onClickCom_ = arg_3_0:FindCom("OnClickDownListener")

	arg_3_0.onClickCom_.onValueChanged:AddListener(function()
		if not arg_3_0.canClick and arg_3_0.dragFunc then
			arg_3_0.dragFunc(arg_3_0.heroID)
		end
	end)
	arg_3_0:AddBtnListener(arg_3_0.heroitemBtn_, nil, function()
		if not arg_3_0.canClick and arg_3_0.downFunc then
			arg_3_0.downFunc(arg_3_0.heroID)
		end
	end)
	arg_3_0:AddBtnListenerScale(arg_3_0.recallbtnBtn_, nil, function()
		if not arg_3_0.canClick and arg_3_0.recallHero then
			arg_3_0.recallHero(arg_3_0.heroID)
		end
	end)
end

function var_0_0.RefreshUI(arg_7_0, arg_7_1, arg_7_2)
	if DormNpcTools:CheckIDIsNpc(arg_7_1) then
		arg_7_0:RefreshNpcInfo(arg_7_1, arg_7_2)
	else
		arg_7_0:RefreshHeroInfo(arg_7_1, arg_7_2)
	end
end

function var_0_0.RefreshNpcInfo(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.heroID = arg_8_1
	arg_8_0.iconImg_.sprite = DormNpcTools:GetNpcHeadSprite(arg_8_1)

	if DormNpcTools:GetNpcFatigue(arg_8_1) < 0 then
		arg_8_0.fatigueController:SetSelectedState("infinitew")
	end
end

local var_0_1 = import("game.dorm.DormEnum")
local var_0_2 = {
	[var_0_1.DormHeroState.InCanteenJob] = "canteen",
	[var_0_1.DormHeroState.InCanteenEntrust] = "task",
	[var_0_1.DormHeroState.InPublicDorm] = "lobby",
	[var_0_1.DormHeroState.InIdolTraineeCamp] = "idolCamp"
}
local var_0_3 = {
	[var_0_1.DormHeroState.InCanteenJob] = true,
	[var_0_1.DormHeroState.InCanteenEntrust] = true,
	[var_0_1.DormHeroState.InPublicDorm] = true,
	[var_0_1.DormHeroState.InPrivateDorm] = true,
	[var_0_1.DormHeroState.InIdolTraineeCamp] = true
}

function var_0_0.EnableRecall(arg_9_0)
	local var_9_0 = DormData:GetCurrectSceneID()

	if nullable(BackHomeCfg, var_9_0, "type") == DormConst.BACKHOME_TYPE.PublicDorm and DormHeroTools:CheckHeroInRoom(var_9_0, arg_9_0.archiveID) then
		return true
	end

	return false
end

function var_0_0.RefreshHeroInfo(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 then
		arg_10_0.heroID = arg_10_1
		arg_10_0.archiveID = DormData:GetHeroArchiveID(arg_10_1)

		local var_10_0 = DormData:GetHeroTemplateInfo(arg_10_0.heroID)

		if var_10_0 then
			arg_10_0.iconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(arg_10_1)

			if not arg_10_0.showFatigue then
				arg_10_0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]

				local var_10_1 = var_10_0:GetFatigue()

				arg_10_0.curText_.text = var_10_1
				arg_10_0.progressImg_.fillAmount = 1 - math.min(var_10_1 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

				local var_10_2 = GameDisplayCfg.dorm_hero_fatigue_level.value

				if var_10_0:GetFatigue() <= var_10_2[1] then
					arg_10_0.fatigueController:SetSelectedState("low")
				elseif var_10_0:GetFatigue() > var_10_2[1] and var_10_0:GetFatigue() <= var_10_2[2] then
					arg_10_0.fatigueController:SetSelectedState("middle")
				else
					arg_10_0.fatigueController:SetSelectedState("suff")
				end
			else
				arg_10_0.fatigueController:SetSelectedState("none")
			end

			if not arg_10_0.showState then
				arg_10_0.state = var_10_0:GetHeroState()

				local var_10_3 = nullable(var_0_2, arg_10_0.state) or "dorm"

				arg_10_0.curPisitionController:SetSelectedState(var_10_3)

				local var_10_4 = nullable(var_0_3, arg_10_0.state) and "busy" or "normal"

				arg_10_0.positionController:SetSelectedState(var_10_4)
			end

			if not arg_10_0.canClick then
				if arg_10_0.selFunc then
					arg_10_0.selFunc(arg_10_0.heroID, arg_10_2, arg_10_0.characterStateController)
				else
					arg_10_0.characterStateController:SetSelectedState("normal")
					arg_10_0.sameNameController:SetSelectedState("false")

					local var_10_5 = DormData:GetHeroArchiveID(arg_10_2)

					if arg_10_0.archiveID == var_10_5 then
						if arg_10_2 == arg_10_0.heroID then
							if arg_10_0:EnableRecall() then
								arg_10_0.characterStateController:SetSelectedState("select_recall")
							else
								arg_10_0.characterStateController:SetSelectedState("select")
							end
						else
							arg_10_0.positionController:SetSelectedState("normal")
							arg_10_0.sameNameController:SetSelectedState("true")
						end
					end
				end
			end

			arg_10_0.maskController:SetSelectedState("false")

			if arg_10_0.maskFunc and arg_10_0.maskFunc(arg_10_0.heroID) then
				arg_10_0.maskController:SetSelectedState("true")
			end
		end
	end
end

function var_0_0.SetCanClickAndState(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0.showState = arg_11_1
	arg_11_0.canClick = arg_11_2
	arg_11_0.showFatigue = arg_11_3
end

function var_0_0.RecallHero(arg_12_0, arg_12_1)
	arg_12_0.recallHero = arg_12_1
end

function var_0_0.OnPointerDown(arg_13_0, arg_13_1)
	arg_13_0.downFunc = arg_13_1
end

function var_0_0.InDragFunc(arg_14_0, arg_14_1)
	arg_14_0.dragFunc = arg_14_1
end

function var_0_0.ShowMaskCallBack(arg_15_0, arg_15_1)
	if arg_15_1 then
		arg_15_0.maskFunc = arg_15_1
	end
end

function var_0_0.SelCallBack(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0.selFunc = arg_16_1
	end
end

function var_0_0.Dispose(arg_17_0)
	arg_17_0:RemoveAllListeners()

	if not arg_17_0.canClick and arg_17_0.onClickCom_ then
		arg_17_0.onClickCom_.onValueChanged:RemoveAllListeners()
	end

	var_0_0.super.Dispose(arg_17_0)
end

return var_0_0
