local var_0_0 = class("TransitionSkillView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:BuildContext()
	arg_2_0:AddUIListeners()
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.context = {
		curTabIdx = 1,
		tabModule = TransitionSkillListTabModule.New(arg_3_0.tabModuleObj_)
	}
	arg_3_0.scrollHelper_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexItem), arg_3_0.uiListObj_, TransitionSkillItem)
end

function var_0_0.InitContext(arg_4_0)
	arg_4_0.data = {
		curGiftPt = 0,
		curSelectID = 0,
		index = 1,
		heroID = 0,
		leftPt = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT),
		list = {},
		useList = {},
		curUseList = {}
	}
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.IndexItem(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0.data.list[arg_6_1]
	local var_6_1 = arg_6_0.data.curUseList[var_6_0] or 1

	arg_6_2:RefreshUI(var_6_0, var_6_1)
	arg_6_2:SetUsed(arg_6_0:IsUsed(var_6_0))
	arg_6_2:SetSelect(arg_6_0.data.curSelectID == var_6_0)
	arg_6_2:RegistCallBack(function()
		arg_6_0:OnItemClick(var_6_0)
	end)
end

function var_0_0.AddUIListeners(arg_8_0)
	arg_8_0.context.tabModule:RegisterClickCallback(handler(arg_8_0, arg_8_0.OnTabClick))

	arg_8_0.tryToImproveTransitionGiftPtHandler_ = handler(arg_8_0, arg_8_0.OnTryToImproveTransitionGiftPt)

	manager.notify:RegistListener(IMPROVE_TRANSITION_GIFT_PT, arg_8_0.tryToImproveTransitionGiftPtHandler_)
end

function var_0_0.RenderView(arg_9_0, arg_9_1)
	arg_9_0:InitContext()

	arg_9_0.data.index = arg_9_1.index or 1
	arg_9_0.data.heroID = arg_9_1.heroID
	arg_9_0.data.type = arg_9_1.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_9_0.data.heroDataProxy = HeroViewDataProxy.New(arg_9_0.data.type)

	arg_9_0.context.tabModule:OnTabClick(arg_9_0.data.index)
end

function var_0_0.GetData(arg_10_0)
	arg_10_0:GetUseList()
	arg_10_0:GetCurUseList()
end

function var_0_0.GetUseList(arg_11_0)
	local var_11_0 = {}
	local var_11_1 = arg_11_0:GetHeroTransition()

	arg_11_0.data.curGiftPt = 0

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_2 = iter_11_1.slot_id

		var_11_0[var_11_2] = deepClone(iter_11_1.skill_list)

		if var_11_2 == arg_11_0.data.index then
			arg_11_0.data.curGiftPt = iter_11_1.talent_points

			break
		end
	end

	arg_11_0.data.useList = var_11_0
end

function var_0_0.GetCurUseList(arg_12_0)
	local var_12_0 = {
		all = {}
	}

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.data.useList[arg_12_0.data.index] or {}) do
		local var_12_1 = iter_12_1.skill_id

		var_12_0[var_12_1] = iter_12_1.skill_level

		table.insert(var_12_0.all, var_12_1)
	end

	arg_12_0.data.curUseList = var_12_0
end

function var_0_0.RefreshUI(arg_13_0)
	arg_13_0:RefreshList()
	arg_13_0:RefreshType()
end

function var_0_0.RefreshList(arg_14_0)
	local var_14_0 = HeroCfg[arg_14_0.data.heroID].hero_equip_skill[arg_14_0.data.index] or {}

	table.sort(var_14_0, function(arg_15_0, arg_15_1)
		if arg_14_0:IsUsed(arg_15_0) ~= arg_14_0:IsUsed(arg_15_1) then
			return arg_14_0:IsUsed(arg_15_0)
		end

		if arg_14_0:IsUsed(arg_15_0) and arg_14_0:IsUsed(arg_15_1) then
			local var_15_0 = arg_14_0.data.curUseList[arg_15_0]
			local var_15_1 = arg_14_0.data.curUseList[arg_15_1]

			if var_15_0 ~= var_15_1 then
				return var_15_1 < var_15_0
			end
		end

		return arg_15_0 < arg_15_1
	end)

	arg_14_0.data.list = var_14_0
	arg_14_0.data.curSelectID = arg_14_0.data.list[1]

	arg_14_0.scrollHelper_:StartScroll(#arg_14_0.data.list)
	arg_14_0:OnItemClick(arg_14_0.data.curSelectID)
end

function var_0_0.RefreshType(arg_16_0)
	arg_16_0.data.leftPt = arg_16_0.data.curGiftPt

	for iter_16_0, iter_16_1 in ipairs(arg_16_0.data.curUseList.all) do
		arg_16_0.data.leftPt = arg_16_0.data.leftPt - arg_16_0.data.curUseList[iter_16_1]
	end

	local var_16_0 = #arg_16_0.data.curUseList.all

	arg_16_0.restrictTxt_.text = table.concat({
		GetTips("JUMP_EQUIP_UPPER_DESC"),
		var_16_0,
		"/",
		GameSetting.exclusive_skill_use_num_max.value[1]
	})

	arg_16_0:DispatchJumpElementChangeEmitter()
end

function var_0_0.IsUsed(arg_17_0, arg_17_1)
	return arg_17_0.data.curUseList[arg_17_1] ~= nil
end

function var_0_0.IsSelected(arg_18_0, arg_18_1)
	return arg_18_1 == arg_18_0.data.curSelectID
end

function var_0_0.SaveData(arg_19_0, arg_19_1)
	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil then
		local var_19_0 = manager.net.tcpConnection_:GetMachineState()

		if var_19_0 and (var_19_0 == "connected" or var_19_0 == "connecting") then
			local var_19_1 = {}

			if not arg_19_0.data.curUseList or not arg_19_0.data.curUseList.all then
				return
			end

			for iter_19_0, iter_19_1 in ipairs(arg_19_0.data.curUseList.all) do
				var_19_1[iter_19_0] = {
					skill_id = iter_19_1,
					skill_level = arg_19_0.data.curUseList[iter_19_1]
				}
			end

			HeroAction.TryToSaveTransitionSkill(arg_19_0.data.heroID, arg_19_0.data.index, var_19_1, arg_19_1)
		end
	end
end

function var_0_0.OnTryToImproveTransitionGiftPt(arg_20_0)
	ShowTips("EXCLUSIVE_SKILL_POINT_UP")
	arg_20_0:GetUseList()
	arg_20_0.scrollHelper_:Refresh()
	arg_20_0:RefreshType()
end

function var_0_0.OnExit(arg_21_0)
	arg_21_0:SaveData()
end

function var_0_0.Dispose(arg_22_0)
	manager.notify:RemoveListener(IMPROVE_TRANSITION_GIFT_PT, arg_22_0.tryToImproveTransitionGiftPtHandler_)
	arg_22_0:RemoveAllEventListener()
	arg_22_0:RemoveAllListeners()

	if arg_22_0.scrollHelper_ then
		arg_22_0.scrollHelper_:Dispose()

		arg_22_0.scrollHelper_ = nil
	end

	arg_22_0.context.tabModule:Dispose()

	arg_22_0.context.tabModule = nil

	var_0_0.super.Dispose(arg_22_0)
end

function var_0_0.RegisterTabListener(arg_23_0, arg_23_1)
	arg_23_0.context.tabSwitchEmitter = arg_23_1
end

function var_0_0.RegisterItemClickListener(arg_24_0, arg_24_1)
	arg_24_0.context.itemClickEmitter = arg_24_1
end

function var_0_0.RegisterRefreshJumpElement(arg_25_0, arg_25_1)
	arg_25_0.context.jumpElementChangeEmitter = arg_25_1
end

function var_0_0.RegisterRefreshJumpSlotView(arg_26_0, arg_26_1)
	arg_26_0.context.jumpSlotRefreshEmitter = arg_26_1
end

function var_0_0.OnTabClick(arg_27_0, arg_27_1)
	arg_27_0:SaveData()

	arg_27_0.data.index = arg_27_1

	arg_27_0:GetData()
	arg_27_0:RefreshUI()
	arg_27_0:DispatchTabSwitchEmitter(arg_27_1)
end

function var_0_0.OnItemClick(arg_28_0, arg_28_1)
	arg_28_0.data.curSelectID = arg_28_1

	arg_28_0.scrollHelper_:Refresh()
	arg_28_0:DispatchItemClickEmitter(arg_28_1)
end

function var_0_0.DispatchTabSwitchEmitter(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.context.tabSwitchEmitter

	if var_29_0 then
		var_29_0(arg_29_1)
	end
end

function var_0_0.DispatchItemClickEmitter(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.context.itemClickEmitter

	if var_30_0 then
		var_30_0({
			skillID = arg_30_1,
			level = arg_30_0.data.curUseList[arg_30_1] or 1,
			equipped = arg_30_0:IsUsed(arg_30_1)
		})
	end
end

function var_0_0.DispatchJumpElementChangeEmitter(arg_31_0)
	local var_31_0 = arg_31_0.context.jumpElementChangeEmitter

	if var_31_0 then
		var_31_0({
			totalElement = arg_31_0.data.curGiftPt,
			leftElement = arg_31_0.data.leftPt
		})
	end
end

function var_0_0.DispatchJumpSlotRefreshEmitter(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0.context.jumpSlotRefreshEmitter

	if var_32_0 then
		var_32_0(arg_32_0:GetSlotParam(arg_32_1))
	end
end

function var_0_0.OnSkillEquip(arg_33_0)
	if #arg_33_0.data.curUseList.all >= GameSetting.exclusive_skill_use_num_max.value[1] then
		ShowTips("EXCLUSIVE_SKILL_MAX")

		return
	end

	if arg_33_0.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = arg_33_0.data.curGiftPt,
			heroID = arg_33_0.data.heroID,
			index = arg_33_0.data.index
		})

		return
	end

	arg_33_0.data.curUseList[arg_33_0.data.curSelectID] = 1

	table.insert(arg_33_0.data.curUseList.all, arg_33_0.data.curSelectID)
	arg_33_0.scrollHelper_:Refresh()
	arg_33_0:RefreshType()
	arg_33_0:DispatchItemClickEmitter(arg_33_0.data.curSelectID)
	arg_33_0:DispatchJumpSlotRefreshEmitter(arg_33_0.data.index)
	ShowTips("EXCLUSIVE_SKILL_LOAD")
end

function var_0_0.OnSkillExchange(arg_34_0)
	local var_34_0 = arg_34_0.data.curUseList
	local var_34_1 = arg_34_0.data.curSelectID

	table.remove(var_34_0.all, table.indexof(var_34_0.all, var_34_1))

	var_34_0[var_34_1] = nil

	arg_34_0.scrollHelper_:Refresh()
	arg_34_0:RefreshType()
	arg_34_0:DispatchItemClickEmitter(arg_34_0.data.curSelectID)
	arg_34_0:DispatchJumpSlotRefreshEmitter(arg_34_0.data.index)
	ShowTips("EXCLUSIVE_SKILL_UNLOAD")
end

function var_0_0.OnSkillLevelUp(arg_35_0)
	if arg_35_0.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = arg_35_0.data.curGiftPt,
			heroID = arg_35_0.data.heroID,
			index = arg_35_0.data.index
		})

		return
	end

	local var_35_0 = arg_35_0.data.curUseList
	local var_35_1 = arg_35_0.data.curSelectID

	var_35_0[var_35_1] = var_35_0[var_35_1] + 1

	arg_35_0.scrollHelper_:Refresh()
	arg_35_0:RefreshType()
	arg_35_0:DispatchItemClickEmitter(arg_35_0.data.curSelectID)
	arg_35_0:DispatchJumpSlotRefreshEmitter(arg_35_0.data.index)
	ShowTips("EXCLUSIVE_SKILL_LEVEL_UP")
end

function var_0_0.ResetUseList(arg_36_0)
	arg_36_0.data.curUseList = {}
	arg_36_0.data.curUseList.all = {}

	arg_36_0.scrollHelper_:Refresh()
	arg_36_0:RefreshType()
	arg_36_0:DispatchItemClickEmitter(arg_36_0.data.curSelectID)
end

function var_0_0.GetCurGiftPoint(arg_37_0)
	return arg_37_0.data.curGiftPt
end

function var_0_0.GetSlotParam(arg_38_0, arg_38_1)
	local var_38_0 = {
		slotIdx = arg_38_1,
		heroId = arg_38_0.data.heroID,
		skills = {}
	}

	for iter_38_0, iter_38_1 in ipairs(arg_38_0.data.curUseList.all) do
		var_38_0.skills[iter_38_0] = {
			skillId = iter_38_1,
			level = arg_38_0.data.curUseList[iter_38_1]
		}
	end

	return var_38_0
end

function var_0_0.GetHeroData(arg_39_0)
	return arg_39_0.data.heroDataProxy:GetHeroData(arg_39_0.data.heroID)
end

function var_0_0.GetHeroTransition(arg_40_0)
	return arg_40_0.data.heroDataProxy:GetHeroTransitionInfoList(arg_40_0.data.heroID) or {}
end

function var_0_0.GetHeroEquip(arg_41_0)
	return arg_41_0.heroDataProxy:GetEquipInfoList(arg_41_0.data.heroID)
end

return var_0_0
