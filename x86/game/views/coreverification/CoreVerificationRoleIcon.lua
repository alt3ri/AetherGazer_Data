slot0 = class("CoreVerificationRoleIcon", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.emptyController_ = slot0.mainControllerEx_:GetController("empty")
end

function slot0.SetData(slot0, slot1)
	if slot1 then
		slot0.emptyController_:SetSelectedState("false")

		if HeroTools.HeroUsingSkinInfo(slot1).id == 0 then
			slot2 = slot1
		end

		slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. slot2)
	else
		slot0.emptyController_:SetSelectedState("true")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
