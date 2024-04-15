slot0 = class("DrawServantSelectItem", ReduxView)

function slot1(slot0)
	return DrawData:GetPollUpID(slot0)
end

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

	slot0.chooseController = slot0.controller_:GetController("choose")
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.id_ = slot2
	slot0.servantID_ = slot3
	slot0.nameText_.text = ""
	slot0.suffixText_.text = ItemTools.getItemName(slot3)
	slot0.campImg_.sprite = HeroTools.GetRaceIcon(WeaponServantCfg[slot0.servantID_].race)
	slot0.groupbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/ServantUpSelect/" .. slot0.id_ .. SettingData:GetCurrentLanguageKey())
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 == slot0.id_ then
		slot0.chooseController:SetSelectedState("true")
	else
		slot0.chooseController:SetSelectedState("false")
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.groupbgBtn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.id_)
		end
	end)
	slot0:AddBtnListener(slot0.lookBtn_, nil, function ()
		if uv0.servantID_ then
			uv0:Go("/showServantView", {
				state = "onlydetail",
				id = uv0.servantID_
			})
		end
	end)
end

function slot0.RegisterListener(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
