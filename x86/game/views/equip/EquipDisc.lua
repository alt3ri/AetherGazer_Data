local var_0_0 = class("EquipDisc", ReduxView)

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

	arg_3_0.equipItem_ = {}

	for iter_3_0 = 1, 6 do
		local var_3_0 = arg_3_0["equipItem_" .. iter_3_0]

		arg_3_0.equipItem_[iter_3_0] = EquipItem.New(var_3_0)
	end
end

function var_0_0.AddUIListener(arg_4_0)
	return
end

function var_0_0.OnEnter(arg_5_0, arg_5_1)
	if arg_5_1.oldIndex and arg_5_1.newIndex then
		arg_5_0:ResetAngle()

		if arg_5_1.oldIndex == arg_5_1.newIndex then
			local var_5_0 = -120 - (arg_5_1.newIndex - 1) * 60

			arg_5_0.rotateServant_.transform.localEulerAngles = Vector3.New(0, 0, var_5_0)

			arg_5_0:HideItems()
		else
			arg_5_0:RotateServant(arg_5_1.oldIndex, arg_5_1.newIndex)
		end
	end

	arg_5_0.isShowDetail_ = arg_5_1.isShowDetail
end

function var_0_0.RefreshItem(arg_6_0, arg_6_1)
	for iter_6_0 = 1, 6 do
		local var_6_0 = arg_6_1[iter_6_0]

		arg_6_0.equipItem_[iter_6_0]:RefreshData(var_6_0, arg_6_0.isShowDetail_)
		arg_6_0.equipItem_[iter_6_0]:RegistCallBack(function(arg_7_0, arg_7_1)
			if arg_6_0.itemClickCallBack then
				arg_6_0.itemClickCallBack(arg_7_0, iter_6_0)

				if arg_6_0.lastSelectItem_ then
					arg_6_0.lastSelectItem_:ShowSelect(false)
				end

				arg_7_1:ShowSelect(true)

				arg_6_0.lastSelectItem_ = arg_7_1
			end
		end)
	end
end

function var_0_0.Reset(arg_8_0)
	for iter_8_0 = 1, 6 do
		arg_8_0.equipItem_[iter_8_0]:ShowSelect(false)
	end
end

function var_0_0.PlayAnim(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.servantAnim_:Play("Fx_servant_change")
	else
		arg_9_0.servantAnim_:Play("Fx_servant_cx")
	end
end

function var_0_0.RotateServant(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0.index_ = arg_10_2

	local var_10_0 = arg_10_0:GetAngle(arg_10_1, arg_10_2)

	if var_10_0 ~= 0 then
		arg_10_0.rotateLeanTween_ = LeanTween.rotateAroundLocal(arg_10_0.rotateServant_, Vector3.New(0, 0, 1), var_10_0, 0.5):setEase(LeanTweenType.easeOutCubic)
	end
end

function var_0_0.GetAngle(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = (arg_11_1 - arg_11_2) * 60

	if math.abs(var_11_0) > 180 then
		var_11_0 = var_11_0 > 0 and var_11_0 - 360 or var_11_0 + 360
	end

	return var_11_0
end

function var_0_0.HideItems(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.equipItem_) do
		iter_12_1:Hide()
	end
end

function var_0_0.RegistItemButton(arg_13_0, arg_13_1)
	arg_13_0.itemClickCallBack = arg_13_1
end

function var_0_0.ShowAnim(arg_14_0, arg_14_1)
	arg_14_0.equipItem_[arg_14_1]:ShowAnim()
end

function var_0_0.RefreshItemByIndex(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.equipItem_[arg_15_1]:RefreshData(arg_15_2)
end

function var_0_0.ResetAngle(arg_16_0)
	arg_16_0.rotateServant_.transform.rotation = Vector3.zero
end

function var_0_0.OnExit(arg_17_0)
	return
end

function var_0_0.Dispose(arg_18_0)
	for iter_18_0, iter_18_1 in pairs(arg_18_0.equipItem_) do
		iter_18_1:Dispose()
	end

	arg_18_0.equipItem_ = nil

	var_0_0.super.Dispose(arg_18_0)
end

return var_0_0
