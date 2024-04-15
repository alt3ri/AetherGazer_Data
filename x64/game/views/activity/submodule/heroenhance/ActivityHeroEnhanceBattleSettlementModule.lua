local var_0_0 = class("ActivityHeroEnhanceBattleSettlementModule", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_0:InstView(arg_1_1)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform

	arg_1_0:Init()
end

function var_0_0.InstView(arg_2_0, arg_2_1)
	local var_2_0 = "Widget/Version/NorseUI_3_0/NorseUI_3_0_HeroEnhanceUI/NorseUI_3_0_HeroEnhanceBattleResultContent"

	return (Object.Instantiate(Asset.Load(var_2_0), arg_2_1))
end

function var_0_0.BuildContext(arg_3_0)
	arg_3_0.rewardItemList = {}
	arg_3_0.rewardList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexAwardItem), arg_3_0.rewardList_, CommonItemView)
	arg_3_0.talentList_ = LuaList.New(handler(arg_3_0, arg_3_0.IndexTalentItem), arg_3_0.talentListGo_, ActivityHeroEnhanceTalentItem)
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()
	arg_4_0:BuildContext()
end

function var_0_0.OnEnter(arg_5_0)
	return
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.RenderView(arg_7_0, arg_7_1)
	arg_7_0.talentIdList_ = arg_7_1.stageData:GetTalentIdList()

	arg_7_0.talentList_:StartScroll(4)
	arg_7_0:RenderRewards(arg_7_1.rewardList)
end

function var_0_0.RenderRewards(arg_8_0, arg_8_1)
	local var_8_0 = {}

	if arg_8_1 then
		for iter_8_0, iter_8_1 in pairs(arg_8_1[1]) do
			table.insert(var_8_0, iter_8_1)
		end

		var_8_0 = formatRewardCfgList(var_8_0)
		var_8_0 = mergeReward(var_8_0)
		var_8_0 = sortReward(var_8_0)
	end

	arg_8_0.rewardItemList = var_8_0

	arg_8_0.rewardList_:StartScroll(#var_8_0, 1)
end

function var_0_0.IndexAwardItem(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0.rewardItemList[arg_9_1]

	if ItemCfg[var_9_0.id] and ItemConst.ITEM_TYPE.EQUIP == ItemCfg[var_9_0.id].type then
		var_9_0.race = EquipCfg[var_9_0.id] and EquipCfg[var_9_0.id].race or 0
	end

	local var_9_1 = clone(ItemTemplateData)

	var_9_1.id = var_9_0.id
	var_9_1.number = var_9_0.num
	var_9_1.race = var_9_0.race

	function var_9_1.clickFun(arg_10_0)
		ShowPopItemOnly(POP_OTHER_ITEM, {
			arg_10_0.id,
			arg_10_0.number
		})
	end

	arg_9_2:SetData(var_9_1)
end

function var_0_0.IndexTalentItem(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.talentIdList_[arg_11_1]

	arg_11_2:SetData(arg_11_0.activityId_, var_11_0)
	arg_11_2:RefreshUI()
end

function var_0_0.Dispose(arg_12_0)
	arg_12_0.talentList_:Dispose()
	arg_12_0.rewardList_:Dispose()
	var_0_0.super.Dispose(arg_12_0)
end

return var_0_0
