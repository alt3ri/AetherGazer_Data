slot0 = class("NewBieDrawHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.selectController_ = slot0.controller_:GetController("select")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.id_)
		end
	end)
	slot0:AddBtnListener(slot0.lookBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.id_
		})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.cfg_ = HeroCfg[slot0.id_]

	slot0:UpdateView()
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.UpdateView(slot0)
	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.id_)
	slot0.campImg_.sprite = HeroTools.GetHeroRaceIcon(slot0.id_)
	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.id_)
	slot0.nameText_.text = slot0.cfg_.name
	slot0.suffixText_.text = slot0.cfg_.suffix
end

function slot0.RefreshSelect(slot0, slot1)
	if slot1 then
		slot0.selectController_:SetSelectedState(tostring(slot0.id_))
	else
		slot0.selectController_:SetSelectedState("false")
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
