slot0 = class("CultureGravureRecommendAstroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.colorController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "color")
	slot0.lockController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "lockstate")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.heroID_ = slot3
	slot0.cfg_ = HeroAstrolabeCfg[slot0.id_]
	slot0.type_ = string.sub(tostring(slot0.id_), -2, -2)

	slot0:RefreshUI()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot0 = uv0.transform_.position

		uv0.callback(HeroAstrolabeCfg[uv0.id_].name, GetCfgDescription(AstrolabeEffectCfg[uv0.id_].desc[1], 1), Vector3(slot0.x, slot0.y, slot0.z))
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.RefreshUI(slot0)
	slot0.nameText_.text = slot0.cfg_.name

	slot0.colorController_:SetSelectedState(slot0.type_)

	slot0.isUnlock = CultureGravureData:GetHasUnlockAllAstro(slot0.heroID_, {
		slot0.id_
	})

	if slot0.isUnlock then
		slot0.lockController_:SetSelectedState("normal")
	else
		slot0.lockController_:SetSelectedState("lock")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
