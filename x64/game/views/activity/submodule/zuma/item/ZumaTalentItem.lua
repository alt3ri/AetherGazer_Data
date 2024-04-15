slot0 = class("ZumaTalentItem", ReduxView)
slot1 = {
	selectState = {
		onSelect = "state1",
		name = "sel",
		unSelect = "state0"
	},
	stateState = {
		name = "state",
		lock = "state0",
		normal = "state2"
	},
	lineState = {
		normalColor = Color(0.611764705882353, 0.7372549019607844, 0.788235294117647, 1),
		lockColor = Color(0.7137254901960784, 0.7764705882352941, 0.8, 0.4)
	}
}

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.talentID = slot3
	slot0.talentCfg = ActivityZumaTalentCfg[slot0.talentID]
	slot0.lineImage = slot2:GetComponent(typeof(Image))

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = slot0.controllerexcollection_:GetController(uv0.selectState.name)
	slot0.stateController = slot0.controllerexcollection_:GetController(uv0.stateState.name)

	slot0:AddBtnListener(slot0.stageBtn_, nil, function ()
		manager.notify:CallUpdateFunc(ZUMA_TALENT_INFO, uv0.talentID)
	end)

	slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/NorseUI_3_0/NorseUI_3_0_Zuma/" .. slot0.talentCfg.icon)
end

function slot0.GetTalentID(slot0)
	return slot0.talentID
end

function slot0.RefreshTalentState(slot0)
	slot0.stateController:SetSelectedState(ZumaData:GetZumaTalentIsOpen(slot0.talentID) and uv0.stateState.normal or uv0.stateState.lock)
	slot0:RefreshLineState(slot1)
end

function slot0.RefreshSelectState(slot0, slot1)
	slot0.selectController:SetSelectedState(slot1 and uv0.selectState.onSelect or uv0.selectState.unSelect)
end

function slot0.RefreshLineState(slot0, slot1)
	slot0.lineImage.color = slot1 and uv0.lineState.normalColor or uv0.lineState.lockColor
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
