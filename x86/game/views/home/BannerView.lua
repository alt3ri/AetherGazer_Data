local var_0_0 = class("BannerView", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.gameObject_ = arg_1_2
	arg_1_0.transform_ = arg_1_2.transform
	arg_1_0.info_ = arg_1_3

	arg_1_0:InitUI()
	arg_1_0:AddUIListener()
end

function var_0_0.RefreshData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.data_ = arg_2_1
	arg_2_0.info_ = arg_2_2

	arg_2_0:Render()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.judgeSize_ = arg_3_0.listTrs_.sizeDelta
	arg_3_0.calSliderWidth_ = 0
	arg_3_0.gridTrs_ = arg_3_0.grid_.transform
end

function var_0_0.AddUIListener(arg_4_0)
	arg_4_0:AddDragListener(arg_4_0.listGo_, function()
		arg_4_0.timer_:Stop()
	end, function(arg_6_0, arg_6_1)
		return
	end, function(arg_7_0, arg_7_1)
		OperationRecorder.Record("home", "activity_slide")

		if not arg_4_0.space_ then
			local var_7_0 = 0
		end

		local var_7_1 = arg_4_0.info_.vertical
		local var_7_2 = var_7_1 and arg_4_0.gridTrs_.localPosition.y or -arg_4_0.gridTrs_.localPosition.x
		local var_7_3 = (var_7_1 and arg_4_0.judgeSize_.y or arg_4_0.judgeSize_.x) / 2

		arg_4_0:RemoveTween2()

		if var_7_3 < var_7_2 then
			arg_4_0.tween2_ = LeanTween.moveLocal(arg_4_0.grid_, arg_4_0:GetDragVector(-1), 0.25):setOnComplete(LuaHelper.VoidAction(function()
				arg_4_0.index_ = arg_4_0:GetRealIndex(arg_4_0.index_ + 1)

				arg_4_0:RefreshBanner()
			end))
		elseif var_7_2 < -1 * var_7_3 then
			arg_4_0.tween2_ = LeanTween.moveLocal(arg_4_0.grid_, arg_4_0:GetDragVector(1), 0.25):setOnComplete(LuaHelper.VoidAction(function()
				arg_4_0.index_ = arg_4_0:GetRealIndex(arg_4_0.index_ - 1)

				arg_4_0:RefreshBanner()
			end))
		else
			arg_4_0.tween2_ = LeanTween.moveLocal(arg_4_0.grid_, Vector3(0, 0, 0), 0.25)
		end

		arg_4_0:StartTimer()
	end)
	arg_4_0:AddBtnListener(arg_4_0.itembtn_, nil, function()
		if arg_4_0.info_.onclick then
			arg_4_0.info_.onclick(arg_4_0.info_.data[arg_4_0.index_])
		end
	end)
end

function var_0_0.Render(arg_11_0)
	arg_11_0.index_ = 1
	arg_11_0.dataNum_ = #arg_11_0.info_.data

	arg_11_0:InitBannerBar()
	arg_11_0:RefreshBanner()
	arg_11_0:StartTimer()
end

function var_0_0.RefreshBanner(arg_12_0)
	arg_12_0.grid_.transform.localPosition = Vector3(0, 0, 0)
	arg_12_0.item2_.sprite = arg_12_0.info_.data[arg_12_0.index_].image

	local var_12_0 = arg_12_0:GetRealIndex(arg_12_0.index_ - 1)

	arg_12_0.item1_.sprite = arg_12_0.info_.data[var_12_0].image

	local var_12_1 = arg_12_0:GetRealIndex(arg_12_0.index_ + 1)

	arg_12_0.item3_.sprite = arg_12_0.info_.data[var_12_1].image

	arg_12_0:SetBarPosition(arg_12_0.index_ - 1)
end

function var_0_0.InitBannerBar(arg_13_0)
	arg_13_0.bar_.transform:SetSiblingIndex(0)

	local var_13_0 = arg_13_0.sliderBg_.transform.childCount

	for iter_13_0 = var_13_0, arg_13_0.dataNum_ + 1, -1 do
		local var_13_1 = arg_13_0.sliderBg_.transform:GetChild(iter_13_0 - 1)

		Object.Destroy(var_13_1.gameObject)
	end

	for iter_13_1 = var_13_0 + 1, arg_13_0.dataNum_ do
		local var_13_2 = Object.Instantiate(arg_13_0.barItem_, arg_13_0.sliderBg_.transform)

		SetActive(var_13_2, true)
	end
end

function var_0_0.StartTimer(arg_14_0)
	if arg_14_0.timer_ then
		arg_14_0.timer_:Stop()
	end

	arg_14_0.timer_ = Timer.New(function()
		arg_14_0:RemoveTween()

		arg_14_0.tween_ = LeanTween.moveLocal(arg_14_0.grid_, arg_14_0:GetDragVector(-1), 0.25):setOnComplete(LuaHelper.VoidAction(function()
			arg_14_0.index_ = arg_14_0:GetRealIndex(arg_14_0.index_ + 1)

			arg_14_0:RefreshBanner()
			arg_14_0:RemoveTween()
		end))
	end, 5, -1)

	arg_14_0.timer_:Start()
end

function var_0_0.RemoveTween(arg_17_0)
	if arg_17_0.tween_ then
		arg_17_0.tween_:setOnComplete(nil)
		LeanTween.cancel(arg_17_0.tween_.id)

		arg_17_0.tween_ = nil
	end
end

function var_0_0.RemoveTween2(arg_18_0)
	if arg_18_0.tween2_ then
		arg_18_0.tween2_:setOnComplete(nil)
		LeanTween.cancel(arg_18_0.tween2_.id)

		arg_18_0.tween2_ = nil
	end
end

function var_0_0.Init(arg_19_0)
	arg_19_0:Render()
end

function var_0_0.Dispose(arg_20_0)
	if arg_20_0.timer_ then
		arg_20_0.timer_:Stop()

		arg_20_0.timer_ = nil
	end

	arg_20_0:RemoveTween()
	arg_20_0:RemoveTween2()

	arg_20_0.info_ = nil

	var_0_0.super.Dispose(arg_20_0)
end

function var_0_0.GetRealIndex(arg_21_0, arg_21_1)
	if arg_21_1 > arg_21_0.dataNum_ then
		return 1
	elseif arg_21_1 < 1 then
		return arg_21_0.dataNum_
	else
		return arg_21_1
	end
end

function var_0_0.SetBarPosition(arg_22_0, arg_22_1)
	arg_22_0.bar_.transform:SetSiblingIndex(arg_22_1)
end

function var_0_0.GetDragVector(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0.space_ or 0

	if arg_23_0.info_.vertical then
		return Vector3(0, -1 * arg_23_1 * (var_23_0 + arg_23_0.judgeSize_.y), 0)
	else
		return Vector3(arg_23_1 * (var_23_0 + arg_23_0.judgeSize_.x), 0, 0)
	end
end

return var_0_0
