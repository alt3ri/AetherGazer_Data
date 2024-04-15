slot0 = class("NorseSurpriseGiftReceiveItem", ReduxView)
slot1 = {
	"第一抽",
	"第二抽",
	"第三抽",
	"第四抽",
	"第五抽"
}

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

	slot0.stateCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("state")
	slot0.heartCtrl = slot0.transform_:GetComponent("ControllerExCollection"):GetController("heart")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_look, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.heroId
		})
	end)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.heroId)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0:UpdateView(slot1, slot2)
end

function slot0.UpdateView(slot0, slot1, slot2)
	slot0.heroId = slot1
	slot3 = HeroCfg[slot0.heroId]
	slot4 = slot3.ATK_attribute[1]
	slot0.icon.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.heroId)
	slot0.numTxt_.text = uv0[slot2]
	slot0.atkImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroId)
	slot0.raceImg_.sprite = HeroTools.GetHeroRaceIcon(slot0.heroId)
	slot0.suffixTxt_.text = GetI18NText(slot3.suffix)
	slot0.nameTxt_.text = GetI18NText(slot3.name)

	slot0.stateCtrl:SetSelectedIndex(0)
	slot0.heartCtrl:SetSelectedIndex(0)
end

function slot0.SetHeart(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0.heroId == slot6 then
			slot0.heartCtrl:SetSelectedIndex(1)

			break
		end
	end
end

function slot0.SetSelect(slot0, slot1)
	if slot1.id == slot0.heroId then
		slot0.stateCtrl:SetSelectedIndex(2)
	else
		slot0.stateCtrl:SetSelectedIndex(0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.clickFunc = nil
end

return slot0
