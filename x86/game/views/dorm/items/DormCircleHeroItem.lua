slot0 = class("DormCircleHeroItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.heroID)
		end
	end)
end

function slot0.SetClickCallBack(slot0, slot1)
	if slot1 then
		slot0.clickFunc = slot1
	end
end

function slot0.RefreshUI(slot0, slot1, slot2)
	if slot1 then
		slot0.heroID = slot1
		slot0.imageImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(slot1)
	end

	if HeroTools.GetHeroIsUnlock(slot1) then
		if slot0.heroID == slot2 then
			slot0.stateController:SetSelectedState("select")
		else
			slot0.stateController:SetSelectedState("normal")
		end
	else
		slot0.stateController:SetSelectedState("mask")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
