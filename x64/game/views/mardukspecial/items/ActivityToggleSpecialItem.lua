slot0 = class("ActivityToggleSpecialItem", ReduxView)

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

	slot0.activityOpenHandler_ = handler(slot0, slot0.ActivityOpen)
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.subActivityId_) then
			if ActivityData:GetActivityData(uv0.subActivityId_).stopTime < manager.time:GetServerTime() then
				ShowTips(GetTips("TIME_OVER"))
			else
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(uv0.subActivityId_).startTime)))
			end

			return
		end

		if uv0.itemSelectHandler_ ~= nil then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.transform_)
			uv0.itemSelectHandler_(uv0.index_, true)
		end

		MardukSpecialAction.ClickMardukSpecial(uv0.subActivityId_)
		uv0:UpdateRedPoint()
	end)
	slot0:AddBtnListener(slot0.readyBtn_, nil, function ()
		gameContext:Go("/sectionSelectHero", {
			section = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[uv0.subActivityId_].stage_id].id,
			sectionType = BattleConst.STAGE_TYPE_NEW.MARDUK_SPECIAL,
			activityID = uv0.subActivityId_
		})
	end)
end

function slot0.AddEventListeners(slot0)
	manager.notify:RegistListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 then
		slot0.statusController_:SetSelectedState("select")

		slot0.panelTrans_.sizeDelta = Vector2(slot0.panelTrans_.rect.width, 470)
	else
		slot0.statusController_:SetSelectedState("normal")

		slot0.panelTrans_.sizeDelta = Vector2(slot0.panelTrans_.rect.width, 140)
	end
end

function slot0.ActivityOpen(slot0, slot1)
	if slot1 == slot0.subActivityId_ then
		slot0:UpdateView()
	end
end

function slot0.SetItemSelectHandler(slot0, slot1)
	slot0.itemSelectHandler_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.activityId_ = slot2
	slot0.subActivityId_ = slot3
	slot0.battleCfg_ = BattleQuickTrainingCfg[ActivityQuickTrainingCfg[slot0.subActivityId_].stage_id]

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameLabel1_.text = slot0.battleCfg_.name
	slot0.descLabel_.text = slot0.battleCfg_.tips
	slot0.scoreLabel1_.text = MardukSpecialData:GetPoint(slot0.subActivityId_)
	slot2 = ActivityQuickTrainingCfg[slot0.subActivityId_]
	slot0.bgImage_.sprite = getSprite("Atlas/XuHeng3rdUI", slot2.bg_id)
	slot0.iconImage_.sprite = getSprite("Atlas/CampItemAtlas", slot2.icon_id)

	if ActivityData:GetActivityIsOpen(slot0.subActivityId_) then
		slot0.statusController_:SetSelectedState("normal")

		slot0.panelTrans_.sizeDelta = Vector2(slot0.panelTrans_.rect.width, 140)
	else
		slot0.statusController_:SetSelectedState("lock")

		slot0.panelTrans_.sizeDelta = Vector2(slot0.panelTrans_.rect.width, 140)
		slot3 = ActivityData:GetActivityData(slot0.subActivityId_)
		slot4 = slot3.stopTime

		if slot3.stopTime < manager.time:GetServerTime() then
			slot0.timeCntText_.text = GetTips("TIME_OVER")
		else
			slot0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot3.startTime))
		end
	end

	slot0:UpdateRedPoint()
end

function slot0.UpdateTime(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.subActivityId_) then
		if ActivityData:GetActivityData(slot0.subActivityId_).stopTime < manager.time:GetServerTime() then
			slot0.timeCntText_.text = GetTips("TIME_OVER")
		else
			slot0.timeCntText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot1.startTime))
		end
	end
end

function slot0.UpdateRedPoint(slot0)
	SetActive(slot0.redGo_, manager.redPoint:getTipValue(string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_NOT_FIGHT, slot0.subActivityId_)) > 0 and true or false)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.RemoveAllEventListener(slot0)
	manager.notify:RemoveListener(ACTIVITY_UPDATE, slot0.activityOpenHandler_)
	uv0.super.RemoveAllEventListener(slot0)
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil
	slot0.activityOpenHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
