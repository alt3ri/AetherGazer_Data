local var_0_0 = class("NewbieDrawHeroSelectView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Pool/NewbiePoolSelectPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()

	arg_5_0.btnController_ = arg_5_0.controller_:GetController("btn")
	arg_5_0.limitController_ = arg_5_0.controller_:GetController("tips")
	arg_5_0.uiList_ = LuaList.New(handler(arg_5_0, arg_5_0.indexItem), arg_5_0.uilistGo_, NewBieDrawHeroItem)
end

function var_0_0.indexItem(arg_6_0, arg_6_1, arg_6_2)
	arg_6_2:SetData(arg_6_1, arg_6_0.idList_[arg_6_1])
	arg_6_2:RegistClickFunc(function()
		arg_6_0:OnHeroClick(arg_6_0.idList_[arg_6_1])
	end)
	arg_6_2:RefreshSelect(arg_6_0.curHeroId_ == arg_6_0.idList_[arg_6_1])
end

function var_0_0.OnHeroClick(arg_8_0, arg_8_1)
	if arg_8_0.upHeroID == arg_8_1 then
		arg_8_0.btnController_:SetSelectedState("current")
	else
		arg_8_0.btnController_:SetSelectedState(arg_8_0.upID ~= arg_8_1 and "true" or "current")
	end

	arg_8_0.curHeroId_ = arg_8_1

	arg_8_0.uiList_:Refresh()
end

function var_0_0.AddUIListener(arg_9_0)
	arg_9_0:AddBtnListener(arg_9_0.btnrenewalBtn_, nil, function()
		if arg_9_0.curHeroId_ == nil or arg_9_0.curHeroId_ == 0 then
			return
		end

		if arg_9_0.curHeroId_ == arg_9_0.upHeroID then
			arg_9_0:Back()

			return
		end

		if arg_9_0.params_.isFirst then
			local var_10_0 = DrawPoolCfg[arg_9_0.params_.poolId]
			local var_10_1 = table.indexof(var_10_0.optional_detail, arg_9_0.curHeroId_)
			local var_10_2 = var_10_0.optional_lists_poolId[var_10_1]

			DrawAction.SetPollUpID(arg_9_0.params_.poolId, var_10_2)

			return
		end

		if arg_9_0.upHeroID == 0 then
			local var_10_3 = DrawPoolCfg[arg_9_0.params_.poolId]
			local var_10_4 = table.indexof(var_10_3.optional_detail, arg_9_0.curHeroId_)
			local var_10_5 = var_10_3.optional_lists_poolId[var_10_4]

			DrawAction.SetPollUpID(arg_9_0.params_.poolId, var_10_5)
		else
			ShowMessageBox({
				isTop = true,
				title = GetTips("PROMPT"),
				content = GetTips("DRAW_POOL_SCREEN_TYPE_4"),
				SecondTip = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), ""),
				SecondValue = DrawData:GetUpRemainTime(arg_9_0.params_.poolId),
				OkCallback = function()
					local var_11_0 = DrawPoolCfg[arg_9_0.params_.poolId]
					local var_11_1 = table.indexof(var_11_0.optional_detail, arg_9_0.curHeroId_)
					local var_11_2 = var_11_0.optional_lists_poolId[var_11_1]

					DrawAction.SetPollUpID(arg_9_0.params_.poolId, var_11_2)
				end,
				CancelCallback = function()
					return
				end
			})
		end
	end)
	arg_9_0:AddBtnListener(arg_9_0.btnLock_, nil, function()
		if arg_9_0.curHeroId_ == nil or arg_9_0.curHeroId_ == 0 then
			ShowTips("DRAW_NOT_SELECT_TIPS")

			return
		end
	end)
end

function var_0_0.OnSetPollUpID(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:Back()
end

function var_0_0.OnTop(arg_15_0)
	arg_15_0:UpdateBar()
end

function var_0_0.OnBehind(arg_16_0)
	manager.windowBar:HideBar()
end

function var_0_0.UpdateBar(arg_17_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_18_0)
	arg_18_0.upID = DrawData:GetPollUpID(arg_18_0.params_.poolId)
	arg_18_0.upHeroID = DrawData:ConvertUpId(arg_18_0.params_.poolId, arg_18_0.upID, 0)
	arg_18_0.curHeroId_ = arg_18_0.upHeroID

	if arg_18_0.curHeroId_ == 0 then
		arg_18_0.btnController_:SetSelectedState("false")
	else
		arg_18_0.btnController_:SetSelectedState("current")
	end

	arg_18_0:UpdateList()
end

function var_0_0.OnExit(arg_19_0)
	arg_19_0:RemoveAllEventListener()

	arg_19_0.params_.heroId = arg_19_0.curHeroId_
	arg_19_0.params_.poolId = arg_19_0.params_.poolId
	arg_19_0.params_.isFirst = arg_19_0.params_.isFirst

	manager.windowBar:HideBar()
end

function var_0_0.UpdateList(arg_20_0)
	arg_20_0.idList_ = arg_20_0.params_.heroIdList

	arg_20_0.uiList_:StartScroll(#arg_20_0.idList_)

	if DrawPoolCfg[arg_20_0.params_.poolId].pool_change == 0 or arg_20_0.params_.isFirst then
		arg_20_0.limitController_:SetSelectedState("false")
	else
		arg_20_0.limitController_:SetSelectedState("true")

		local var_20_0 = DrawData:GetPoolUpTimes(arg_20_0.params_.poolId)
		local var_20_1 = DrawPoolCfg[arg_20_0.params_.poolId].pool_change - var_20_0

		arg_20_0.timesText_.text = string.format(GetTips("DRAW_REMAIN_UP_TIMES"), tostring(var_20_1))
	end
end

function var_0_0.Dispose(arg_21_0)
	if arg_21_0.uiList_ then
		arg_21_0.uiList_:Dispose()

		arg_21_0.uiList_ = nil
	end

	var_0_0.super.Dispose(arg_21_0)
end

return var_0_0
