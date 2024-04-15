slot0 = class("MoonCakeMakeView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeMakeUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.failController_ = ControllerUtil.GetController(slot0.transform_, "fail")
	slot5 = MoonCakeItem
	slot0.fillingItemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.scrollView_, slot5)
	slot0.clickFillingHandler_ = handler(slot0, slot0.OnClickFilling)
	slot0.clickModelHandler_ = handler(slot0, slot0.OnClickModel)
	slot0.modelList_ = {}

	for slot5 = 1, slot0.modelContentTrans_.childCount do
		slot0.modelList_[slot5] = MoonCakeItem.New(slot0.modelContentTrans_:GetChild(slot5 - 1).gameObject)

		slot0.modelList_[slot5]:SetType(MoonCakeConst.ITEM_STYLE.NONE)
		slot0.modelList_[slot5]:SetData(nil, slot5, true)
		slot0.modelList_[slot5]:SetClickHandler(slot0.clickModelHandler_)
	end

	slot0.originCircleRotateion_ = slot0.circle_.localRotation
	slot0.originArrowRotatetion_ = slot0.arror_.localRotation
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		if uv0.startMake_ == true then
			return
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.makeBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		uv0.startMake_ = true

		uv0:SwitchToMake()
		uv0:StartQTE()
	end)
	slot0:AddBtnListener(slot0.qteConfirmBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		uv0.startMake_ = false

		uv0:EndQTE()
	end)
	slot0:AddBtnListener(slot0.resultConfirmBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if uv0.curFillingID_ then
			uv0:SwitchToChose()
		else
			uv0:SwitchToPrepare()
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.fillingItemList_:Dispose()

	slot0.fillingItemList_ = nil

	for slot4, slot5 in ipairs(slot0.modelList_) do
		slot5:Dispose()
	end

	slot0.modelList_ = nil
	slot0.clickFillingHandler_ = nil
	slot0.clickModelHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.startMake_ = false

	slot0:SwitchToPrepare()
end

function slot0.OnExit(slot0)
	slot0.status_ = nil

	AnimatorTools.Stop()
end

function slot0.SwitchToPrepare(slot0)
	slot0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.PREPARE)
	slot0:RefreshResource()

	slot0.curFillingID_ = nil
	slot0.curFillingItem_ = nil
	slot0.curModelID_ = nil
end

function slot0.SwitchToChose(slot0)
	slot0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.CHOSE)

	slot0.targetCakeID_ = MoonCakeTools.GetCakeRecipeDic(slot0.activityID_)[slot0.curFillingID_][slot0.curModelID_]
	slot0.cakeIcon_.sprite = ItemTools.getItemSprite(MoonCakeCfg[slot0.targetCakeID_].moon_cakes)
end

function slot0.SwitchToMake(slot0)
	slot0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.MAKE)
end

function slot0.SwitchToQTEResult(slot0)
	slot0.startMake_ = false

	if slot0.curQteResult_ == true then
		slot0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.SUCCESS)

		slot0.cakeIcon_.sprite = ItemTools.getItemSprite(slot0.resultItemID_)
	else
		slot0.statusController_:SetSelectedIndex(MoonCakeConst.FILLING_MAKE_STATUS.FAIL)

		if slot0.resultItemID_ == 0 then
			slot0.failController_:SetSelectedState("true")
		else
			slot0.failController_:SetSelectedState("false")

			slot0.cakeIcon_.sprite = ItemTools.getItemSprite(slot0.resultItemID_)
		end
	end

	SetActive(slot0.maskGo_, true)

	slot1 = nil

	if slot0.resultItemID_ ~= 0 then
		AnimatorTools.PlayAnimatorWithCallback(slot0.qteResultAnim_, slot0.curQteResult_ == true and "Fx_successPanel_cx" or "Fx_failPanel_cx", function ()
			showRewardUI({
				{
					uv0.resultItemID_,
					1
				}
			})
			SetActive(uv0.maskGo_, false)
		end, false)
	else
		slot0.qteResultAnim_:Play(slot1, -1, 0)
		slot0.qteResultAnim_:Update(0)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot3 = slot0.fillingIdList_[slot1]

	slot2:SetData(MoonCakeFillingCfg[slot3].patties, slot3)
	slot2:SetType(MoonCakeConst.ITEM_STYLE.NORMAL)
	slot2:SetClickHandler(slot0.clickFillingHandler_)
end

function slot0.RefreshResource(slot0)
	slot0.fillingIdList_ = MoonCakeFillingCfg.get_id_list_by_activity[slot0.activityID_]

	slot0.fillingItemList_:StartScroll(#slot0.fillingIdList_)

	for slot5, slot6 in ipairs(slot0.fillingItemList_:GetItemList()) do
		slot6:SetSelect(nil)
	end

	for slot5, slot6 in ipairs(slot0.modelList_) do
		slot6:SetSelect(nil)
	end
end

function slot0.RefreshTargetCake(slot0)
	if slot0.curFillingID_ ~= nil and slot0.curModelID_ ~= nil then
		slot0.targetCakeID_ = MoonCakeTools.GetCakeRecipeDic(slot0.activityID_)[slot0.curFillingID_][slot0.curModelID_]
		slot0.cakeIcon_.sprite = ItemTools.getItemSprite(MoonCakeCfg[slot0.targetCakeID_].moon_cakes)
	end
end

function slot0.OnClickFilling(slot0, slot1, slot2)
	if ItemTools.getItemNum(MoonCakeFillingCfg[slot1].patties) <= 0 then
		ShowTips("MID_AUTUMN_FESTIVAL_MOONCAKE_MAKING_INSUFFICIENT_RAW_MATERIALS")

		return
	end

	slot0.curFillingID_ = slot1
	slot0.curFillingItem_ = slot2

	for slot9, slot10 in ipairs(slot0.fillingItemList_:GetItemList()) do
		slot10:SetSelect(slot1)
	end

	if slot0.curFillingID_ ~= nil and slot0.curModelID_ ~= nil then
		slot0:SwitchToChose()
	end
end

function slot0.OnClickModel(slot0, slot1)
	slot0.curModelID_ = slot1

	for slot5, slot6 in ipairs(slot0.modelList_) do
		slot6:SetSelect(slot1)
	end

	if slot0.curFillingID_ ~= nil and slot0.curModelID_ ~= nil then
		slot0:SwitchToChose()
	end
end

function slot0.OnMakeCakeResult(slot0, slot1)
	slot0.resultItemID_ = slot1

	slot0.curFillingItem_:RefreshNum()

	if ItemTools.getItemNum(MoonCakeFillingCfg[slot0.curFillingID_].patties) <= 0 then
		slot0.curFillingItem_:SetSelect(nil)

		slot0.curFillingID_ = nil
		slot0.curFillingItem_ = nil
	end

	slot0:SwitchToQTEResult()
	slot0:ResetQTE()
end

function slot0.ResetQTE(slot0)
	slot0.circle_.localRotation = slot0.originCircleRotateion_
	slot0.arror_.localRotation = slot0.originArrowRotatetion_
	slot0.countDownProgress_.fillAmount = 1
end

function slot0.InitQTE(slot0)
	slot0.tagretAngle_ = slot0:RandomAngle()
	slot0.circle_.localRotation = Quaternion.Euler(0, 0, slot0.tagretAngle_)
	slot0.countDownProgress_.fillAmount = 1
end

function slot0.StartQTE(slot0)
	slot0:InitQTE()
	slot0:RemoveTween()
	slot0:DoTween(slot0.tagretAngle_)
end

function slot0.DoTween(slot0, slot1)
	slot0.tagretAngle_ = slot1
	slot0.circle_.localRotation = Quaternion.Euler(0, 0, slot0.tagretAngle_)
	slot0.countDownProgress_.transform.localRotation = Quaternion.Euler(0, 0, slot0.arror_.localEulerAngles.z)
	slot0.tween = LeanTween.rotateAroundLocal(slot0.arror_.gameObject, Vector3.New(0, 0, -1), 360, 2):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.countDownProgress_.fillAmount = (360 - slot0) / 360
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0:RemoveTween()
		uv0:GoToResult(false)
	end))
end

function slot0.EndQTE(slot0)
	if (slot0.tagretAngle_ + 360 - (slot0.arror_.localEulerAngles.z + 360) % 360) % 360 <= 35 or slot2 >= 325 then
		if slot2 <= 15 or slot2 >= 345 then
			slot0:RemoveTween()
			slot0:GoToResult(true)
		else
			slot0:RemoveTween()
			slot0:DoTween(slot0:RandomAngle())
		end
	else
		slot0:RemoveTween()
		slot0:GoToResult(false)
	end
end

function slot0.GoToResult(slot0, slot1)
	slot0.curQteResult_ = slot1

	MoonCakeAction.MoonCakeMakeResult(slot0.activityID_, slot0.targetCakeID_, slot0.curQteResult_)
end

function slot0.RemoveTween(slot0)
	if slot0.tween then
		slot0.tween:setOnComplete(nil)
		LeanTween.cancel(slot0.arror_.gameObject)

		slot0.tween = nil
	end
end

function slot0.RandomAngle(slot0)
	return -((-slot0.arror_.localEulerAngles.z + 360) % 360 + math.random(120, 300)) % 360
end

return slot0
