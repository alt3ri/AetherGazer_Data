slot0 = class("TransitionSkillSlotsModule", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lvupBtnTxt_.text = GetTips("TEXT_UPGRADE")

	slot0:BuildContext()
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		comps = slot0.controller_,
		btnState = {
			MaxLevel = "maxLevel",
			name = "btnState",
			Equip = "equip",
			Exchange = "exchange",
			comps = slot0.controller_:GetController("btnState")
		}
	}
	slot0.constVar = {}
	slot0.data = {
		level = 0,
		skillID = 0,
		equipped = false,
		heroID = 0
	}
end

function slot0.InitContext(slot0)
	slot0.data = {
		level = 0,
		skillID = 0,
		equipped = false,
		heroID = 0
	}
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.equipBtn_, nil, function ()
		uv0:OnEquipBtnClick()
	end)
	slot0:AddBtnListener(slot0.exchangeBtn_, nil, function ()
		uv0:OnExchangeBtnClick()
	end)
	slot0:AddBtnListener(slot0.levelUpBtn_, nil, function ()
		uv0:OnLevelUpBtnClick()
	end)
	TerminologyTools.AddTerminologyHandler(slot0, slot0.chipEffectTxt_, nil, )
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.RenderView(slot0, slot1)
	slot0:InitContext()

	slot0.data.heroID = slot1.heroID
	slot0.data.level = slot1.level
	slot0.data.skillID = slot1.skillID
	slot0.data.equipped = slot1.equipped
	slot2 = EquipSkillCfg[slot0.data.skillID]
	slot4 = 1
	slot0.skillNameTxt_.text = GetI18NText(slot2.name)
	slot0.skillIconImg_.sprite = getEquipSkillSprite(slot0.data.skillID)
	slot5 = slot0.controller.btnState

	if slot0.data.equipped then
		slot0.skillStatusTxt_.text = GetTips("LEVEL") .. slot0.data.level

		if slot0.data.level < slot2.lvmax then
			slot5.comps:SetSelectedState(slot5.Exchange)
		else
			slot5.comps:SetSelectedState(slot5.MaxLevel)
		end
	else
		slot0.skillStatusTxt_.text = GetTips("JUMP_EQUIP_NONE_STATUS")

		slot5.comps:SetSelectedState(slot5.Equip)
	end

	slot0.chipEffectTxt_.text = EquipTools.GetSkillDescWithoutNext(slot0.data.skillID, slot4, slot0.data.heroID)

	if slot4 < slot3 then
		SetActive(slot0.nextEffectObj_, true)

		slot0.nextEffectTxt_.text = EquipTools.GetSkillDescWithoutNext(slot0.data.skillID, slot4 + 1, slot0.data.heroID)
	else
		SetActive(slot0.nextEffectObj_, false)
	end
end

function slot0.RegisterEquipBtnClickEmitter(slot0, slot1)
	slot0.constVar.onEquipEmitter = slot1
end

function slot0.RegisterExchangeBtnClickEmitter(slot0, slot1)
	slot0.constVar.onExchangeEmitter = slot1
end

function slot0.RegisterLevelUpBtnClickEmitter(slot0, slot1)
	slot0.constVar.onLevelUpEmitter = slot1
end

function slot0.OnEquipBtnClick(slot0)
	if slot0.constVar.onEquipEmitter then
		slot1()
	end
end

function slot0.OnExchangeBtnClick(slot0)
	if slot0.constVar.onExchangeEmitter then
		slot1()
	end
end

function slot0.OnLevelUpBtnClick(slot0)
	if slot0.constVar.onLevelUpEmitter then
		slot1()
	end
end

return slot0
