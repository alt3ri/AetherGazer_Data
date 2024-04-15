local var_0_0 = class("EnchantmentItemView", ReduxView)
local var_0_1 = {
	"icon_ee_boss_b",
	"icon_ee_boss_a",
	"icon_ee_boss_s"
}
local var_0_2 = {
	"bg_ee_boss_b",
	"bg_ee_boss_a",
	"bg_ee_boss_s"
}

function var_0_0.GetCfg(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.stageName_ = BattleEnchantmentStageCfg[arg_1_1].name
	arg_1_0.rareSprite_ = getSprite("Atlas/BattleStage", var_0_1[arg_1_2] .. SettingData:GetCurrentLanguageKey())
	arg_1_0.rareBack_ = getSpriteViaConfig("Stage", var_0_2[arg_1_2])
	arg_1_0.cost_ = BattleEnchantmentStageCfg[arg_1_1].cost
	arg_1_0.dropList_ = getRewardFromDropCfg(BattleEnchantmentStageCfg[arg_1_1].drop_lib_id, false)
	arg_1_0.heroAffix_ = getHeroAffixs(BattleEnchantmentStageCfg[arg_1_1].affix_type)
	arg_1_0.enemyAffix_ = BattleEnchantmentStageCfg[arg_1_1].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[arg_1_1].affix_type) or BattleEnchantmentStageCfg[arg_1_1].affix_type_in_map
	arg_1_0.stageImage_ = BattleEnchantmentStageCfg[arg_1_1].hd_image
end

function var_0_0.OnCtor(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.gameObject_ = arg_2_1
	arg_2_0.transform_ = arg_2_1.transform
	arg_2_0.itemTem_ = arg_2_2
	arg_2_0.func_ = arg_2_3
	arg_2_0.stageID_ = 0
	arg_2_0.itemS = {}

	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.starbtnBtn_, nil, function()
		JumpTools.OpenPopUp("enchantmentMultiPop", {
			stageID = arg_4_0.stageID_
		})
	end)
	arg_4_0:AddBtnListener(arg_4_0.heroaffixBtn_, nil, function()
		arg_4_0.func_(arg_4_0.heroaffixiconImg_.transform, arg_4_0.heroAffix_[1])
	end)
	arg_4_0:AddBtnListener(arg_4_0.enemyaffixBtn_, nil, function()
		arg_4_0.func_(arg_4_0.enemyaffixiconImg_.transform, arg_4_0.enemyAffix_[1])
	end)
end

function var_0_0.AddListener(arg_8_0, arg_8_1)
	arg_8_0:AddToggleListener(arg_8_0.toggle_, arg_8_1)
end

function var_0_0.RefreshUI(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.stageID_ = arg_9_1
	arg_9_0.rare_ = arg_9_2

	arg_9_0:GetCfg(arg_9_1, arg_9_2)

	arg_9_0.difficultImg_.sprite = arg_9_0.rareSprite_
	arg_9_0.sectionimageImg_.sprite = arg_9_0.rareBack_
	arg_9_0.nameText_.text = arg_9_0.stageName_
	arg_9_0.costText_.text = arg_9_0.cost_
	arg_9_0.bossImg_.sprite = getSpriteWithoutAtlas(string.format("TextureConfig/ChapterPaint/EquipEnchantment/%s", arg_9_0.stageImage_))

	if arg_9_0.heroAffix_ and arg_9_0.heroAffix_ ~= "" and arg_9_0.heroAffix_[1] then
		arg_9_0.heroaffixText_.text = GetI18NText(getAffixName(arg_9_0.heroAffix_[1]))
		arg_9_0.heroaffixiconImg_.sprite = getAffixSprite(arg_9_0.heroAffix_[1])
	else
		arg_9_0.heroaffixText_.text = ""
		arg_9_0.heroaffixiconImg_.sprite = nil
	end

	if arg_9_0.enemyAffix_ and arg_9_0.enemyAffix_ ~= "" and arg_9_0.enemyAffix_[1] then
		arg_9_0.enemyaffixText_.text = GetI18NText(getAffixName(arg_9_0.enemyAffix_[1]))
		arg_9_0.enemyaffixiconImg_.sprite = getAffixSprite(arg_9_0.enemyAffix_[1])
	else
		arg_9_0.enemyaffixText_.text = ""
		arg_9_0.enemyaffixiconImg_.sprite = nil
	end

	for iter_9_0, iter_9_1 in pairs(arg_9_0.dropList_) do
		local var_9_0 = rewardToItemTemplate(iter_9_1)

		if not arg_9_0.itemS[iter_9_0] then
			local var_9_1 = Object.Instantiate(arg_9_0.itemTem_, arg_9_0.contentTrs_)

			arg_9_0.itemS[iter_9_0] = CommonItem.New(var_9_1)

			arg_9_0.itemS[iter_9_0]:RegistCallBack(function(arg_10_0)
				ShowPopItem(POP_ITEM, arg_10_0)
			end)
			arg_9_0.itemS[iter_9_0]:RefreshData(var_9_0)
			arg_9_0.itemS[iter_9_0]:HideNum()
		else
			arg_9_0.itemS[iter_9_0]:RefreshData(var_9_0)
			arg_9_0.itemS[iter_9_0]:HideNum()
		end
	end
end

function var_0_0.Dispose(arg_11_0)
	arg_11_0:RemoveAllListeners()

	for iter_11_0 = 1, #arg_11_0.itemS do
		arg_11_0.itemS[iter_11_0]:Dispose()
	end

	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
