slot0 = class("SnowBallInfinityItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.rewardItem = CommonItem.New(slot0.CommonItemGo_)

	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.knockBtn_, nil, function ()
		if uv0.poolData.openBoxList[uv0.index] then
			return
		end

		slot0 = ActivityInfinityPoolCfg[uv0.poolID].cost_item

		if ItemTools.getItemNum(slot0[1]) < slot0[2] then
			ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_COST_FAILED02"), ItemTools.getItemName(slot0[1])))

			return
		end

		slot2 = uv0.poolData.isOpenCoreItem

		OsirisAction.OpenPoolBox(uv0.poolID, {
			uv0.index
		}, function (slot0)
			if isSuccess(slot0.result) then
				SetActive(uv0.maskGo_, true)
				SetActive(uv0.hammerGo_, true)
				manager.audio:PlayEffect("minigame_activity_2_6_snowball", "minigame_activity_2_6_snowball_icebreak", "")

				slot1 = uv0.hammerAnimator_:GetCurrentAnimatorClipInfo(0)[0].clip.length
				uv0.time = 0
				slot2 = 1
				uv0.iceImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00953")
				uv0.isGet = false
				uv0.captionTimer = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
					uv0.time = uv0.time + Time.deltaTime

					if uv0.time > uv1 * uv2 and uv2 <= uv3[2] then
						uv2 = uv2 + 1

						SetActive(uv0.hammerGo_, false)
						SetActive(uv0.hammerGo_, true)
					end

					if uv2 == uv3[2] + 1 then
						uv0.animator_.enabled = true

						if uv0.time > uv1 * uv3[2] + uv0.animator_:GetCurrentAnimatorClipInfo(0)[0].clip.length then
							slot1 = tonumber(GameSetting.activity_snowball_ice_action_delay.value[1])

							if uv0.isGet ~= true then
								uv0.isGet = true

								SetActive(uv0.maskGo_, false)
								getReward({
									{
										id = uv4.box_list[1].item.id,
										num = uv4.box_list[1].item.num
									}
								}, nil, , , true)
								uv0:UpdateView()
								uv0.register()

								if uv5 == false and uv0.poolData.isOpenCoreItem == true then
									ShowTips(string.format(GetTips("ACTIVITY_SNOWBALL_ICE_GETREAWARD"), GetI18NText(OsirisInfinityPoolData:GetOpenPhase(ActivityInfinityPoolCfg[uv0.poolID].activity_id))))
								end
							elseif uv0.time > uv1 * uv3[2] + slot0 + slot1 then
								manager.notify:Invoke(SNOWBALL_GAME_INFINITY_POOL_CLICK_ICE)
								uv0:RemoveCaptionTimer()
							end
						end
					end
				end, -1, true)

				return
			end

			ShowTips(slot0.result)
		end)
	end)
end

function slot0.RemoveCaptionTimer(slot0)
	if slot0.captionTimer then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.captionTimer)

		slot0.captionTimer = nil
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.poolID = slot1
	slot0.index = slot2
	slot0.phase = slot3
	slot0.poolData = OsirisInfinityPoolData:GetPoolData(slot0.poolID)
	slot0.register = slot4
	slot0.maskGo_ = slot5

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.poolData.openBoxList[slot0.index] then
		slot0.rewardItem:RefreshData({
			id = slot1[1],
			number = slot1[2]
		})
		slot0.rewardItem:RegistCallBack(function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.num
			})
		end)
	else
		slot0.animator_.enabled = true

		slot0.animator_:Play("IceUI_item", 0, 0)
		slot0.animator_:Update(0)

		slot0.animator_.enabled = false

		SetActive(slot0.hammerGo_, false)
	end

	slot0.iceImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionUI2_6_00952")

	slot0.stateController:SetSelectedState(slot1 and "Knocked" or "Knock")
end

function slot0.OnExit(slot0)
	slot0:RemoveCaptionTimer()
end

function slot0.Dispose(slot0)
	slot0.rewardItem:Dispose()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
