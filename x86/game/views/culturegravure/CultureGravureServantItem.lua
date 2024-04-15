slot0 = class("CultureGravureServantItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.btnController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "statebtn")
	slot0.stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "statestar")
	slot0.nameController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "name")
	slot0.recommendController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.heroID_ = slot3
	slot0.cfg_ = WeaponServantCfg[slot0.id_]

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.id_,
			"servant"
		})
	end)
	slot0:AddBtnListener(slot0.roleBtn_, nil, function ()
		uv0:Go("/showServantView", {
			state = "onlydetail",
			id = uv0.id_
		})
	end)
	slot0:AddBtnListener(slot0.equipBtn_, nil, function ()
		CultureGravureAction.EquipByServantID(uv0.heroID_, uv0.id_)
	end)
end

function slot0.SetRecommendController(slot0, slot1)
	slot0.recommendController_:SetSelectedState(slot1)
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.RefreshUI(slot0)
	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon438x238/" .. slot0.id_)
	slot0.nameText_.text = ItemTools.getItemName(slot0.id_)

	slot0.stateController_:SetSelectedState(slot0.cfg_.starlevel)
	slot0.nameController_:SetSelectedState(slot0.cfg_.starlevel - 2 >= 1 and slot0.cfg_.starlevel - 2 or 1)

	slot1 = RaceEffectCfg[slot0.cfg_.race]
	slot0.raceImg_.sprite = getSprite("Atlas/SystemGroupAtlas", slot1.icon2)
	slot0.raceText_.text = string.format(GetTips("CULTUREGRAVURE_RACE_DESC"), slot1.name)

	slot0:RefreshState()
end

function slot0.RefreshState(slot0)
	slot1 = CultureGravureData:GetHasServant(slot0.id_)

	if CultureGravureData:GetServantIsEquipped(slot0.heroID_, slot0.id_) then
		slot0.btnController_:SetSelectedState("equip")
	elseif slot1 then
		slot0.btnController_:SetSelectedState("had")
	else
		slot0.btnController_:SetSelectedState("get")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
