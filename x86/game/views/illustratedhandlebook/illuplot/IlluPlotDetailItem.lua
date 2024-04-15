local var_0_0 = class("IlluPlotDetailItem", ReduxView)

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

	arg_3_0.controller_ = ControllerUtil.GetController(arg_3_0.gameObject_.transform, "ButItem")
end

function var_0_0.RefreshUI(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.storyID_ = arg_4_1
	arg_4_0.type_ = arg_4_2
	arg_4_0.unlock_ = IllustratedData:GetPlotInfo()[arg_4_1]

	if arg_4_0.unlock_ then
		local var_4_0 = StoryCfg[arg_4_1]
		local var_4_1 = VideoTrackCfg[arg_4_1 .. ".usm"]

		if (var_4_0.videoPath ~= nil and var_4_0.videoPath ~= "" or var_4_1 ~= nil) and arg_4_0.unlock_ ~= nil then
			arg_4_0.controller_:SetSelectedState("video")
		else
			arg_4_0.controller_:SetSelectedState("normal")
		end
	else
		arg_4_0.controller_:SetSelectedState("empty")
	end

	arg_4_0.nameText_.text = GetI18NText(StoryCfg[arg_4_1].name)
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.itemBtn_, nil, function()
		if IllustratedData:GetPlotInfo()[arg_5_0.storyID_] then
			manager.story:StartStoryById(arg_5_0.storyID_, function(arg_7_0)
				IllustratedAction.ViewIllustration(arg_5_0.storyID_, CollectConst.PLOT)
				gameContext:Go("/blank")
				gameContext:Back()
			end)
		elseif arg_5_0.type_ == 1 then
			local var_6_0 = getStageViaStoryID(arg_5_0.storyID_)
			local var_6_1 = getChapterDifficulty(var_6_0)
			local var_6_2 = getChapterClientCfgByStageID(var_6_0).toggle
			local var_6_3, var_6_4 = BattleStageTools.GetChapterSectionIndex(var_6_2, var_6_0)
			local var_6_5 = string.format(GetTips("MISSION_PROGRESS_UNLOCK"), var_6_1, GetI18NText(var_6_3), GetI18NText(var_6_4))

			ShowTips(var_6_5)
		end
	end)
end

function var_0_0.Dispose(arg_8_0)
	var_0_0.super.Dispose(arg_8_0)
end

return var_0_0
