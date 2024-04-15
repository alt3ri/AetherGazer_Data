slot0 = class("ActivityQuizHeroItem", ReduxView)

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

	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		ActivityQuizAction.ChangeHero(uv0.heroID_)
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.heroID_ = slot1
	slot0.icon_.sprite = getSpriteViaConfig("DormHeroHeadIcon", slot0.heroID_)
end

function slot0.RefreshSelect(slot0, slot1)
	slot0.selectCon_:SetSelectedState(slot1 and "on" or "off")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
