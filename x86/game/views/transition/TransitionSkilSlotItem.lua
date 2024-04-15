slot0 = class("TransitionSkillSlotItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.isInSlotView = slot2

	slot0:Init()
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
	slot0.controller = {
		comps = slot0.controller_,
		sel = {
			name = "sel",
			Select = "1",
			DeSelect = "0",
			comps = slot0.controller_:GetController("sel")
		},
		position = {
			Pos3 = "3",
			Pos5 = "5",
			Pos1 = "1",
			Pos2 = "2",
			Pos6 = "6",
			Pos4 = "4",
			name = "position",
			comps = slot0.controller_:GetController("position")
		},
		Activate = {
			Stage1 = "state1",
			Stage2 = "state2",
			Stage4 = "state4",
			name = "Activate",
			Stage6 = "state6",
			Stage3 = "state3",
			Stage5 = "state5",
			Stage0 = "state0",
			comps = slot0.controller_:GetController("Activate")
		},
		lock = {
			name = "lock",
			Lock = "lock",
			Unlock = "unlock",
			comps = slot0.controller_:GetController("lock")
		}
	}
	slot0.data = {
		isLock = false,
		position = 1
	}
	slot0.constVar = {
		chipObjPrefix = "chip%dObj_",
		firstRefreshDirty = true,
		chipImgPrefix = "chip%dImg_",
		position = 1,
		icon1Anim = slot0.chip1Obj_:GetComponent(typeof(Animator)),
		icon2Anim = slot0.chip2Obj_:GetComponent(typeof(Animator)),
		effect1Anim = slot0.effect1Obj_:GetComponent(typeof(Animator)),
		effect2Anim = slot0.effect2Obj_:GetComponent(typeof(Animator)),
		slotEmpty = {
			true,
			true
		}
	}
	slot0.constVar.icon1Anim.enabled = false
	slot0.constVar.icon2Anim.enabled = false
end

function slot0.InitAnim(slot0)
	SetActive(slot0.effect1Obj_, false)
	SetActive(slot0.effect2Obj_, false)

	slot0.constVar.firstRefreshDirty = true
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.JumpsBtn_, nil, function ()
		uv0:OnJumpsClick()
	end)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.RenderView(slot0, slot1)
	slot0.data.param = slot1
	slot0.constVar.firstRefreshDirty = false

	for slot7 = 1, 2 do
		if slot1.skills[slot7] then
			slot10 = slot8.skillId
			slot11 = EquipSkillCfg[slot10]
			slot2 = 0 + (slot8.level or 1)
			slot0[string.format(slot0.constVar.chipImgPrefix, slot7)].sprite = getEquipSkillSprite(slot10)

			if not slot0.constVar.firstRefreshDirty and slot0.isInSlotView then
				slot0.constVar[string.format("icon%dAnim", slot7)].enabled = true

				SetActive(slot0[string.format("effect%dObj_", slot7)], true)
			end

			SetActive(slot0[string.format(slot0.constVar.chipObjPrefix, slot7)], true)

			if not slot0.constVar.slotEmpty[slot7] then
				slot0.constVar.slotEmpty[slot7] = true

				slot0.constVar[string.format("icon%dAnim", slot7)]:Play("Fx_icon_cx")
				slot0.constVar[string.format("effect%dAnim", slot7)]:Play("Fx_icon_chuandai")
			end
		else
			slot0.constVar.slotEmpty[slot7] = false

			SetActive(slot0[string.format(slot0.constVar.chipObjPrefix, slot7)], false)
		end
	end

	slot0:RenderLevel(slot2)
end

function slot0.ClearSlot(slot0)
	for slot4 = 1, 2 do
		slot0.constVar.slotEmpty[slot4] = false

		SetActive(slot0[string.format(slot0.constVar.chipObjPrefix, slot4)], false)
	end

	slot0:RenderLevel(0)
end

function slot0.RenderPosition(slot0, slot1)
	slot0.constVar.position = slot1

	if slot0.controller.position[string.format("Pos%d", slot1)] then
		slot0.controller.position.comps:SetSelectedState(slot3)
	end
end

function slot0.RenderLevel(slot0, slot1)
	if slot0.controller.Activate[string.format("Stage%d", slot1)] then
		slot0.controller.Activate.comps:SetSelectedState(slot3)
	end
end

function slot0.RenderLock(slot0, slot1)
	slot0.data.isLock = slot1

	if slot1 then
		slot0.controller.lock.comps:SetSelectedState(slot0.controller.lock.Lock)
	else
		slot0.controller.lock.comps:SetSelectedState(slot0.controller.lock.Unlock)
	end
end

function slot0.RenderSelect(slot0, slot1)
	slot2 = slot0.controller.sel.Select

	if not slot1 then
		slot2 = slot0.controller.sel.DeSelect
	end

	slot0.controller.sel.comps:SetSelectedState(slot2)
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.constVar.clickCallback = slot1
end

function slot0.OnJumpsClick(slot0)
	if slot0.constVar.clickCallback then
		slot1(slot0.constVar.position)
	end
end

return slot0
