slot0 = class("HeroSurpassTurntableView", ReduxView)
slot1 = math.sqrt
slot2 = math.cos
slot3 = math.pi
slot4 = 180 / slot3
slot5 = slot3 / 180
slot6 = math.min
slot7 = math.max
slot8 = 30
slot9 = 612
slot10 = 30
slot11 = 4

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
	slot0:InitSurpassList()
end

function slot0.AddUIListener(slot0)
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.BeginDragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.OnDragFun)))
	slot0.eventTriggerListeners_:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(handler(slot0, slot0.EndDragFun)))
end

function slot0.BeginDragFun(slot0, slot1, slot2)
	if slot0.isCantMove then
		return
	end

	slot0.beginMousePos = Input.mousePosition
end

function slot0.OnDragFun(slot0, slot1, slot2)
	if slot0.isCantMove then
		return
	end

	slot4 = 0

	if uv0 < slot0.beginMousePos.y - Input.mousePosition.y then
		slot4 = -1
	elseif slot0.beginMousePos.y - slot3.y < -uv0 then
		slot4 = 1
	end

	if slot4 ~= 0 and slot0.moveIndex ~= slot4 then
		slot0:DragMove(slot4)
	end
end

function slot0.EndDragFun(slot0, slot1, slot2)
	slot0.moveIndex = nil
end

function slot0.DragMove(slot0, slot1)
	slot0.moveIndex = slot1

	slot0:AddMoveTween(slot0.selectStarStage + slot1)
end

function slot0.DelMoveTween(slot0)
	if slot0.moveTween then
		slot0.moveTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.moveTween.id)

		slot0.moveTween = nil
	end
end

function slot0.UpdateSurpassListShow(slot0, slot1, slot2, slot3, slot4)
	for slot8, slot9 in pairs(slot0.surpassList) do
		slot9:GetTransform().localRotation = Quaternion.Euler(0, 0, -slot1.z)
		slot10 = 1

		slot9:ChangeAlpha(Mathf.Lerp(slot4[slot8].alpha, slot0.surpassList[uv2(6, uv1(1, slot8 + uv0 - slot2))] and slot0.surpassList[slot12]:GetBeginAlpha() or 1, slot3))

		if slot2 ~= slot8 then
			slot15 = Vector3.one

			slot9:SetScale(Mathf.Lerp(slot4[slot8].scale, slot0.surpassList[slot12] and slot0.surpassList[slot12]:GetBeginScale() or 1, slot3))
		end
	end
end

function slot0.AddMoveTween(slot0, slot1, slot2)
	if slot1 > 6 or slot1 < slot0.beginStar then
		return
	end

	slot3 = Quaternion.Euler(slot0.surpassnodeTrs_.localEulerAngles)
	slot4 = Quaternion.Euler(0, 0, uv0 * slot1 - uv1 * uv2)
	slot5 = false
	slot6 = false
	slot7 = false

	slot0:DelMoveTween()

	if slot1 ~= slot0.selectStarStage then
		slot0.planNodeView:ShowView(false)
	elseif not slot2 then
		slot0.surpassList[slot1]:PlaySelectAni(true)
		slot0:SelectSurpassItem(slot1, slot2)

		slot6 = true
	end

	slot8 = {
		[slot12] = {}
	}

	for slot12, slot13 in pairs(slot0.surpassList) do
		slot8[slot12].alpha = slot13:GetAlpha()

		if slot13:GetScale() and slot14.x > 1 then
			slot14 = Vector3.one
		end

		slot8[slot12].scale = slot14
	end

	slot0.moveTween = LeanTween.value(0, 1, 0.6):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		if slot0 < 0.95 then
			uv0.isCantMove = true
		else
			uv0.isCantMove = false
		end

		if slot0 > 0.45 and not uv1 then
			for slot4, slot5 in pairs(uv0.surpassList) do
				if slot4 ~= uv2 then
					slot5:PlayScaleAni(false)
				end
			end

			uv1 = true
		end

		if slot0 > 0.7 and not uv3 then
			uv0:SelectSurpassItem(uv2, uv4)

			uv3 = true
		end

		if slot0 > 0.85 and not uv5 then
			uv0.surpassList[uv2]:PlayScaleAni(true)

			uv5 = true
		end

		uv0.surpassnodeTrs_.localRotation = Quaternion.Lerp(uv6, uv7, slot0)

		uv0:UpdateSurpassListShow(uv0.surpassnodeTrs_.localEulerAngles, uv2, slot0, uv8)

		uv0.selectStarStage = uv2
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0.isCantMove = false

		if uv0.moveTween then
			uv0.moveTween:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			uv0.moveTween = nil
		end

		if not uv1 and not uv0.planNodeView:GetSelectIndex() then
			uv0.surpassList[uv2]:PlaySelectAni(true)
		end

		uv0.surpassnodeTrs_.localRotation = uv3

		uv0:UpdateSurpassListShow(uv0.surpassnodeTrs_.localEulerAngles, uv2, 1, uv4)
	end)):setEase(LeanTweenType.easeOutQuad)
end

function slot0.SelectTargetStarStage(slot0, slot1, slot2)
	slot0:AddMoveTween(slot1, slot2)
end

function slot0.AgainPalyNowAni(slot0)
	if slot0.selectStarStage then
		slot0:AddMoveTween(slot0.selectStarStage)
	end
end

function slot0.GetOtherPos(slot0, slot1)
	return uv0(slot0.radius * slot0.radius - slot1 * slot1)
end

function slot0.GetTargetAnglePos(slot0, slot1)
	slot2 = slot0.radius * uv1(slot1 * uv0)

	return slot0:GetOtherPos(slot2), slot2
end

function slot0.InitSurpassList(slot0)
	slot0.radius = uv0
	slot0.surpassList = {}

	for slot4 = 1, 6 do
		slot6 = NewHeroSurpassItem.New(slot0, slot0["btnbigitem" .. slot4 .. "Go_"])

		slot6:SetClickCallBack(function ()
			if uv0.selectStarStage ~= uv1 or uv0.planNodeView:GetSelectIndex() then
				uv0:SelectTargetStarStage(uv1)
			end
		end)

		slot0.surpassList[slot4] = slot6
	end

	slot0.planNodeView = HeroSurpassPlanNode.New(slot0, slot0.plannodeGo_)

	slot0.planNodeView:SetClickCallBack(function (slot0)
		uv0.surpassList[uv0.selectStarStage]:PlaySelectAni(false)
		uv0:RefreshInfoView(slot0)
	end)
end

function slot0.GetTargetSelectPlanStarID(slot0)
	return HeroStarCfg.get_id_list_by_star[slot0.beginStar] and slot1[2] or nil
end

function slot0.SelectSurpassItem(slot0, slot1, slot2)
	slot0.planNodeView:RefreshUi(slot0.surpassList[slot1]:GetStarStage(), slot0.heroInfo)

	if slot1 == slot0.beginStar and not slot2 then
		slot0.planNodeView:ShowAndNotCancelSelect()

		if slot0.selectStarStage == slot1 then
			slot2 = slot0.planNodeView:GetSelectStar()
		end

		if not slot2 then
			slot2 = slot0:GetTargetSelectPlanStarID()
		end
	else
		slot0.planNodeView:ShowView(true)
	end

	if slot2 then
		slot0.planNodeView:ClickPlanItemByStarID(slot2)
		slot0:RefreshInfoView(slot2)
		slot0.surpassList[slot1]:PlaySelectAni(false)
	else
		slot0:RefreshInfoView(slot3:GetStarIdList() and slot4[1] or nil)
	end

	slot0.selectStarStage = slot1
end

function slot0.RefreshInfoView(slot0, slot1)
	if slot1 and slot0.infoViewRefreshCallback then
		slot0.infoViewRefreshCallback(slot1)
	end
end

function slot0.SetInfoShowCallBack(slot0, slot1)
	slot0.infoViewRefreshCallback = slot1
end

function slot0.SetHeroId(slot0, slot1)
	slot0.isCantMove = false
	slot0.heroID = slot1
	slot0.heroCfg = HeroCfg[slot1]

	slot0:InitSurpassListShow(HeroStarCfg[slot0.heroCfg.unlock_star].star)
	slot0:RefreshSurpassData()
end

function slot0.InitSurpassListShow(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in pairs(slot0.surpassList) do
		if slot6 < slot1 then
			slot7:SetActive(false)
		else
			slot7:SetActive(true)
			slot7:SetStarStage(slot6)

			slot2 = slot2 + 1
		end
	end

	slot0.showNum = slot2
	slot0.beginStar = slot1
end

function slot0.RefreshSurpassData(slot0)
	slot0.heroInfo = slot0.dataProxy:GetHeroData(slot0.heroID)
	slot1 = slot0.heroInfo.star

	for slot5, slot6 in pairs(slot0.surpassList) do
		slot6:RefreshUI(slot0.heroInfo)
	end

	slot3 = HeroStarCfg[SurpassTools.GetNextSurpassStarID(slot1)] or HeroStarCfg[slot1]

	slot0:SelectTargetStarStage(slot3.star, slot3.id)
end

function slot0.SetDataProxy(slot0, slot1)
	slot0.dataProxy = slot1
end

function slot0.OnGoldChange(slot0)
	if slot0.surpassList and slot0.surpassList[slot0.selectStarStage] and slot0.heroInfo then
		slot0.planNodeView:RefreshUi(slot0.surpassList[slot0.selectStarStage]:GetStarStage(), slot0.heroInfo)
	end

	if slot0.heroInfo then
		for slot4, slot5 in pairs(slot0.surpassList or {}) do
			slot5:RefreshUI(slot0.heroInfo)
		end
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.surpassList or {}) do
		if slot5 then
			slot5:Dispose()
		end
	end

	slot0.planNodeView:Dispose()
	slot0:DelMoveTween()
	uv0.super.Dispose(slot0)
end

return slot0
