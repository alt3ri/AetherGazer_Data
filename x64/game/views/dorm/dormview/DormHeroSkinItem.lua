slot0 = class("DormHeroSkinItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0.onClickCom_ = slot0:FindCom("OnClickDownListener")

	slot0.onClickCom_.onValueChanged:AddListener(function ()
		if uv0.hasFlag then
			if uv0.clickFunc then
				uv0.clickFunc(uv0.skinID)
			end
		else
			ShowTips(string.format(GetTips("DORM_HERO_SKIN_NULL"), SkinCfg[uv0.skinID].name))
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.skinID = slot1
	slot0.iconImg_.sprite = DormHeroTools.GetBackHomeHeroSkinIcon(slot1)
	slot0.skinName.text = SkinCfg[slot1].name

	slot0.selectController:SetSelectedState("normal")

	if DormHeroTools:isUnlock(slot0.skinID) then
		slot0.hasFlag = true

		if DormData:GetHeroTemplateInfo(slot2):GetHeroCurSkinID(slot2) == slot0.skinID then
			slot0.stateController:SetSelectedState("using")
		else
			slot0.stateController:SetSelectedState("normal")
		end

		if slot1 == slot3 then
			slot0.selectController:SetSelectedState("select")
		end
	else
		slot0.hasFlag = false

		slot0.stateController:SetSelectedState("lock")
	end
end

function slot0.RegisterClickCallBack(slot0, slot1)
	if slot1 then
		slot0.clickFunc = slot1
	end
end

function slot0.Dispose(slot0)
	slot0.onClickCom_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
