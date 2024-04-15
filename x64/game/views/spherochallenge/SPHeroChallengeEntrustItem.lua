slot0 = class("SPHeroChallengeEntrustItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.awardItem = CommonItemView.New(slot0.awarditemGo_1)
	slot0.needMaterialItem = CommonItemView.New(slot0.needitemGo_1)
	slot0.rankController = slot0.controller:GetController("rank")
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		if ActivityHeroChallengeTaskCfg[slot1.id] then
			slot0.id = slot1.id
			slot0.index = slot1.index
			slot0.timeText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_TIME") .. manager.time:DescCdTime3(slot2.time * 60)
			slot0.entrustnameText_.text = slot2.name
			slot0.entrustdescText_.text = slot2.desc

			slot0.awardItem:SetData({
				id = slot2.reward_list[1][1],
				number = slot2.reward_list[1][2],
				clickFun = function (slot0)
					ShowPopItem(POP_ITEM, {
						slot0.id,
						slot0.num
					})
				end
			})
			slot0.needMaterialItem:SetData({
				id = slot2.cost[1][1],
				number = slot2.cost[1][2],
				clickFun = function (slot0)
					ShowPopItem(POP_ITEM, {
						slot0.id,
						slot0.num
					})
				end
			})
			slot0.rankController:SetSelectedState(tostring(slot2.task_level))
		else
			Debug.LogError("委托item传入的id未获取到配置" .. slot1.id)
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if SPHeroChallengeData:GetCurActivityInfo():GetNextExtrustIndex() then
			slot2 = {
				index = slot1,
				entrustID = uv0.id
			}

			if ActivityHeroChallengeTaskCfg[uv0.id].task_level == SpHeroChallengeConst.entrustMaxLevel then
				ShowMessageBox({
					isTop = true,
					content = GetTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_CONFIRM"),
					OkCallback = function ()
						SPHeroChallengeAction:DispatchEntrust(uv0)
					end
				})
			else
				SPHeroChallengeAction:DispatchEntrust(slot2)
			end

			return
		end

		ShowTips("ACTIVITY_HERO_CHALLENGE_ENTRUST_FULL")
	end)
end

function slot0.Dispose(slot0)
	slot0.awardItem:Dispose()
	slot0.needMaterialItem:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
