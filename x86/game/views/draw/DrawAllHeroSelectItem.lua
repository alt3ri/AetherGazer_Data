slot0 = class("DrawAllHeroSelectItem", ReduxView)

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

	slot0.selectCon_ = slot0.controller_:GetController("selected")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.clickFunc_ and uv0.heroCfg_ then
			uv0.clickFunc_(uv0.heroCfg_.id)
		end
	end)
	slot0:AddBtnListener(slot0.lookBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.heroID_
		})
	end)
end

function slot0.SetHeroID(slot0, slot1)
	slot0.heroID_ = slot1
	slot0.heroCfg_ = HeroCfg[slot1]
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot1)

	slot0.headIcon_:SetNativeSize()

	slot0.campLogo_.sprite = HeroTools.GetRaceIcon(slot0.heroCfg_.race)
	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroID_)
	slot0.rareImg_.sprite = HeroTools.GetRareSprite(slot0.heroCfg_.rare)
	slot0.name_.text = slot0.heroCfg_.name .. "·" .. slot0.heroCfg_.suffix
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectCon_:SetSelectedState(tostring(slot1))
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	slot0.clickListener_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
