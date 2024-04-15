slot0 = class("GuildActivitySpAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "bp")

	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.showButton, nil, function ()
		if uv0.clickCallBack then
			uv0.clickCallBack()
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.affixInfo = slot1
	slot0.iconImg_.sprite = getAffixSprite(slot1)

	if slot2 then
		slot0.statusController_:SetSelectedState("true")
	else
		slot0.statusController_:SetSelectedState("false")
	end
end

function slot0.SetClickCallBack(slot0, slot1)
	if slot1 then
		slot0.clickCallBack = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
