slot0 = class("TransitionSkillSlotsModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isInSlotView = slot2 or false

	slot0:Init()

	if slot2 then
		slot0.slotRootObj_:GetComponent(typeof(Animator)).enabled = false
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
end

function slot0.BuildContext(slot0)
	slot0.constVar = {
		selectLocked = false,
		slotPrefix = "slot%dObj_",
		jumpDuration = 0.5,
		showLocked = true,
		animLocked = true
	}
	slot0.slots = {}

	for slot4 = 1, 6 do
		slot5 = TransitionSkilSlotItem.New(slot0[string.format(slot0.constVar.slotPrefix, slot4)], slot0.isInSlotView)
		slot0.slots[slot4] = {
			viewModule = slot5
		}

		slot5:RenderPosition(slot4)
		slot5:RegisterClickListener(handler(slot0, slot0.OnSlotClick))
	end

	slot0.data = {
		slotIdx = 1,
		heroID = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		slotContext = {
			slots = {}
		}
	}
end

function slot0.InitContext(slot0)
	slot0.data = {
		slotIdx = 1,
		heroID = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		slotContext = {
			slots = {}
		}
	}

	for slot4 = 1, 6 do
		slot0.slots[slot4].viewModule:InitAnim()
	end
end

function slot0.AddUIListeners(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0:RemoveTween()

	for slot4 = 1, 6 do
		slot0.slots[slot4].viewModule:Dispose()

		slot0.slots[slot4] = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.RenderView(slot0, slot1)
	if slot1.needRefresh then
		slot0:InitContext()

		if not slot0:GetJumpAnimLock() then
			slot0:JumpDirectly(5)
			slot0:JumpToSlot(slot1.index or 1)
		end

		slot0:SelectSlot(0)
	end

	slot0.data.heroID = slot1.heroID

	if slot1.proxy then
		slot0.data.heroDataProxy = slot1.proxy
		slot0.data.type = slot0.data.heroDataProxy:GetViewDataType()
	else
		slot0.data.type = slot1.type or HeroConst.HERO_DATA_TYPE.DEFAULT
		slot0.data.heroDataProxy = HeroViewDataProxy.New(slot0.data.type)
	end

	if slot1.slots then
		slot2 = {
			slots = slot1.slots
		}

		for slot6 = 1, 6 do
			if not slot2.slots[slot6] then
				slot2.slots[slot6] = {
					totalPoint = 0,
					isLock = true,
					skills = {},
					slotIdx = slot6
				}
			end
		end

		slot0.data.slotContext = slot2

		for slot6, slot7 in ipairs(slot1.slots) do
			slot0:RenderSlot(slot6, slot7)
		end
	else
		for slot7, slot8 in ipairs(slot0.data.heroDataProxy:GetHeroTransitionInfoList(slot1.heroID)) do
			slot9 = slot8.slot_id
			({
				slots = {}
			}).slots[slot9] = {
				skills = {},
				slotIdx = slot9,
				isLock = slot0:GetSlotLockStatus(slot9),
				totalPoint = slot8.talent_points or 0
			}

			for slot15, slot16 in ipairs(slot8.skill_list or {}) do
				table.insert(slot11.skills, {
					skillId = slot16.skill_id,
					level = slot16.skill_level
				})
			end
		end

		for slot7 = 1, 6 do
			if not slot2.slots[slot7] then
				slot2.slots[slot7] = {
					totalPoint = 0,
					skills = {},
					slotIdx = slot7,
					isLock = slot0:GetSlotLockStatus(slot7)
				}
			end
		end

		slot0.data.slotContext = slot2

		for slot7, slot8 in pairs(slot2.slots) do
			slot0:RenderSlot(slot7, slot8)
		end
	end

	if slot0:GetShowLocked() then
		slot0:RenderLock()
	else
		slot0:ClearLock()
	end
end

function slot0.ClearLock(slot0)
	for slot4 = 1, 6 do
		slot0.slots[slot4].viewModule:RenderLock(false)
	end
end

function slot0.RenderLock(slot0)
	for slot4 = 1, 6 do
		if slot0.data.slotContext.slots[slot4] then
			slot0.slots[slot4].viewModule:RenderLock(slot0.data.slotContext.slots[slot4].isLock or false)
		end
	end
end

function slot0.RenderSlot(slot0, slot1, slot2)
	slot0.slots[slot1].viewModule:RenderView(slot2)
end

function slot0.RefreshSlot(slot0, slot1)
	slot2 = slot0.data.slotContext
	slot1.heroId = slot0.data.heroID
	slot3 = slot1.slotIdx
	slot2.slots[slot3] = deepClone(slot1)

	slot0:RenderSlot(slot3, slot2.slots[slot3])
end

function slot0.ClearSlot(slot0, slot1)
	slot0.slots[slot1].viewModule:ClearSlot()
end

function slot0.LockJumpAnim(slot0, slot1)
	slot0.constVar.animLocked = slot1
end

function slot0.GetJumpAnimLock(slot0)
	return slot0.constVar.animLocked
end

function slot0.LockSelect(slot0, slot1)
	slot0.constVar.selectLocked = slot1

	if slot1 then
		slot0:SelectSlot(0)
	end
end

function slot0.SetShowLocked(slot0, slot1)
	slot0.constVar.showLocked = slot1
end

function slot0.GetShowLocked(slot0)
	return slot0.constVar.showLocked
end

function slot0.GetSelectLock(slot0)
	return slot0.constVar.selectLocked
end

function slot0.RegisterSlotClickCallback(slot0, slot1)
	slot0.constVar.slotClickCallback = slot1
end

function slot0.GetAllSlotMessage(slot0, slot1)
	return slot0.data.slotContext.slots
end

function slot0.GetCurEulerAngle(slot0)
	return slot0.slotRootObj_.transform.eulerAngles.z
end

function slot0.JumpDirectly(slot0, slot1)
	slot0.slotRootObj_.transform.rotation = Quaternion.Euler(Vector3.New(0, 0, (2 - (slot1 + 3) % 6) * 60))
	slot0.data.slotIdx = slot1
end

function slot0.JumpToSlot(slot0, slot1)
	if slot0.data.slotIdx ~= slot1 then
		slot0:StartTween(slot1)

		slot0.data.slotIdx = slot1
	end
end

function slot0.GetAngle(slot0, slot1)
	slot2 = slot0:GetCurEulerAngle()
	slot3 = (2 - (slot1 + 3) % 6) * 60

	if math.abs(slot2 - (slot3 + 360)) < math.abs(slot2 - slot3) then
		return slot4
	else
		return slot3
	end
end

function slot0.RemoveTween(slot0)
	if slot0.constVar.tweenRef then
		slot0.constVar.tweenRef:setOnComplete(nil)
		LeanTween.cancel(slot0.constVar.tweenRef.id)

		slot0.constVar.tweenRef = nil
	end
end

function slot0.StartTween(slot0, slot1)
	if slot0:GetJumpAnimLock() then
		return
	end

	slot0:RemoveTween()
	manager.audio:PlayEffect("ui_system_3_0", "ui_sight_listchange", "")

	slot0.constVar.tweenRef = LeanTween.rotateLocal(slot0.slotRootObj_, Vector3.New(0, 0, slot0:GetAngle(slot1)), slot0.constVar.jumpDuration):setEase(LeanTweenType.easeOutCubic):setOnComplete(System.Action(function ()
		uv0:OnTweenComplete()
		uv0:RemoveTween()
	end))
end

function slot0.OnTweenComplete(slot0)
end

function slot0.SelectSlot(slot0, slot1)
	for slot5 = 1, 6 do
		if slot5 == slot1 then
			slot0.slots[slot5].viewModule:RenderSelect(true)
		else
			slot0.slots[slot5].viewModule:RenderSelect(false)
		end
	end
end

function slot0.ClearSelect(slot0)
	slot0:SelectSlot(0)
end

function slot0.OnSlotClick(slot0, slot1)
	if slot0.constVar.slotClickCallback and slot0.data.slotContext.slots[slot1] then
		slot2(slot3)
	end

	if not slot0:GetSelectLock() then
		slot0:SelectSlot(slot1)
	end
end

function slot0.GetSlotLockStatus(slot0, slot1)
	slot3 = 0

	if slot0.data.heroDataProxy:GetEquipDataList(slot0.data.heroID)[slot1] and slot2[slot1].prefab_id and slot2[slot1].prefab_id ~= 0 then
		slot3 = slot2[slot1]:GetLevel()
	end

	return slot3 < GameSetting.exclusive_open_need.value[1]
end

return slot0
