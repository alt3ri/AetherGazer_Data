local var_0_0 = class("HeroClueItem", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.clueID_ = arg_1_2
	arg_1_0.activityID_ = arg_1_3
	arg_1_0.index_ = arg_1_4

	SetActive(arg_1_0.gameObject_, true)
	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.statusController_ = ControllerUtil.GetController(arg_3_0.transform_, "status")
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddBtnListener(arg_4_0.btn_, nil, function()
		if not ActivityTools.ActivityOpenCheck(arg_4_0.activityID_) then
			return
		end

		if not arg_4_0.curData_ then
			ShowTips("ACTIVITY_HERO_CLUE_NULL")

			return
		end

		if #HeroClueCfg[arg_4_0.clueID_].level > arg_4_0.curData_.level then
			ShowTips("ACTIVITY_HERO_CLUE_NOT_ENOUGH")

			return
		end

		HeroClueData:SetSelectedClue(arg_4_0.activityID_, arg_4_0.clueID_)
		JumpTools.OpenPageByJump("heroClueDetail", {
			activityID = arg_4_0.activityID_,
			clueID = arg_4_0.clueID_
		})
	end)
end

function var_0_0.SetActive(arg_6_0, arg_6_1)
	SetActive(arg_6_0.gameObject_, arg_6_1)
end

function var_0_0.Dispose(arg_7_0)
	var_0_0.super.Dispose(arg_7_0)
end

function var_0_0.RefreshUI(arg_8_0)
	arg_8_0.curData_ = HeroClueData:GetUnlockClueDataDic()[arg_8_0.clueID_]

	if arg_8_0.curData_ == nil then
		arg_8_0.nameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")

		arg_8_0.statusController_:SetSelectedState("lock")
	else
		local var_8_0 = HeroClueCfg[arg_8_0.clueID_]

		arg_8_0.clueIcon_.sprite = getSpriteWithoutAtlas(var_8_0.icon_path)

		if arg_8_0.curData_.level < 2 then
			arg_8_0.nameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		else
			arg_8_0.nameText_.text = var_8_0.name
		end

		local var_8_1 = #var_8_0.level

		arg_8_0.progressText_.text = string.format("%d/%d", arg_8_0.curData_.level, var_8_1)

		arg_8_0.statusController_:SetSelectedIndex(arg_8_0.curData_.level)
	end

	if arg_8_0.index_ < 10 then
		arg_8_0.indexText_.text = "0" .. arg_8_0.index_
	else
		arg_8_0.indexText_.text = arg_8_0.index_
	end
end

return var_0_0
