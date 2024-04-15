slot0 = class("NewWarChessHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "skilltype")
	slot0.skillClickHandler_ = handler(slot0, slot0.OnSkillItemClick)
	slot0.skillItem_ = NewWarChessSkillItem.New(slot0.skillGo_)
	slot0.buffItem_ = NewWarChessBuffItem.New(slot0.buffGo_)
end

function slot0.SetData(slot0, slot1)
	slot0.heroInfo_ = slot1
	slot0.cfg_ = NewWarChessHeroCfg[slot0.heroInfo_[1]]
	slot0.heroImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.cfg_.hero_id)
	slot0.heroNameText_.text = slot0.cfg_.description

	if slot0.cfg_.effect_type == NewChessConst.HERO_EFFECT_TYPE.BUFF then
		slot0.statusController_:SetSelectedState("buff")

		slot2 = manager.NewChessManager.buffManager_:GetBuffEntity(slot0.cfg_.effect_id)

		slot0.buffItem_:SetData(1, 0, slot2)

		slot3 = NewWarChessBuffPoolCfg[slot0.cfg_.effect_id]
		slot0.skillDesText_.text = NewChessTools.GetBuffDes(slot2)
	else
		slot0.statusController_:SetSelectedState("skill")
		slot0.skillItem_:SetData(NewWarChessData:GetSkillInfo(slot0.cfg_.effect_id))

		slot0.skillDesText_.text = NewWarChessDiceSkillCfg[slot0.cfg_.effect_id].simple_description
	end

	slot0.hpText_.text = math.ceil(slot0.heroInfo_[2] / NewChessConst.HERO_HP_RATE * 100) .. "%"
	slot0.hpImage_.fillAmount = slot0.heroInfo_[2] / NewChessConst.HERO_HP_RATE
end

function slot0.EnableSkillItemClick(slot0)
	slot0.skillItem_:SetClickCallBack(slot0.skillClickHandler_)
end

function slot0.BindSkillRedPoint(slot0)
	slot0.skillItem_:BindSkillRedPoint()
end

function slot0.OnSkillItemClick(slot0, slot1)
	JumpTools.OpenPageByJump("/newWarChessDiceSkillView", {
		skillID = slot1
	})
end

function slot0.Dispose(slot0)
	slot0.skillClickHandler_ = nil

	slot0.skillItem_:Dispose()
	slot0.buffItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
