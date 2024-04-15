slot1 = class("HeroSkillPage", import("game.views.newHero.HeroPageBase"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillItemGo_ = {}
	slot0.skillItem_ = {}

	for slot4 = 1, 6 do
		slot0.skillItemGo_[slot4] = slot0["skillItem" .. slot4 .. "Go_"]
		slot0.skillItem_[slot4] = HeroSkillViewItem.New(slot0, slot0.skillItemGo_[slot4])

		if slot4 == 6 then
			slot0.skillItem_[slot4]:SetAniState(false)
		end
	end

	slot0.skillitem6Ani_.enabled = false
	slot0.comboskillAni_.enabled = false
end

function slot1.AddUIListener(slot0)
	for slot4 = 1, 6 do
		slot0.skillItem_[slot4]:RegistCallBack(function (slot0)
			uv0:Go("/skillView", {
				skillId = slot0.id,
				heroInfo = uv0.heroInfo_,
				proxy = uv0.heroViewProxy_,
				aniEndPos = uv0.skillTrs_.position
			})
		end)
	end

	slot0:AddBtnListener(slot0.buttonComboSkill_, nil, function ()
		JumpTools.OpenPageByJump("comboSkillInfo", {
			heroID = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.teachingBtn_, nil, function ()
		BattleTeachData:SetCacheTeachHeroID(uv0.heroInfo_.id)

		if HeroCfg[uv0.heroInfo_.id] and slot0.study_stage and slot0.study_stage[1] then
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				heroID = uv0.heroInfo_.id
			})
			JumpTools.OpenPageByJump("teachSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				section = slot0.study_stage[1]
			})
		end
	end)
end

function slot1.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1
end

function slot1.UpdateView(slot0)
	slot0:RefreshSkillItemS()
	slot0:RefreshTeachRedPoint()
	slot0:RefreshComboSkillBtn()
end

function slot1.RefreshSkillItemS(slot0)
	if not slot0.heroInfo_ then
		return
	end

	slot0.skillList_ = slot0.heroViewProxy_:GetHeroSkillInfo(slot0.heroInfo_.id)

	for slot4 = 1, 6 do
		slot0.skillItem_[slot4]:RefreshData(slot0.skillList_[slot4])
	end
end

function slot1.RefreshTeachRedPoint(slot0)
	manager.redPoint:setTip(RedPointConst.HERO_TEACH_ID, BattleTeachData:GetHeroTeachInfo(slot0.heroInfo_.id, HeroCfg[slot0.heroInfo_.id].study_stage[1]) <= 0 and not slot0.extra_ and 1 or 0)
end

function slot1.RefreshComboSkillBtn(slot0)
	if ComboSkillTools.GetHeroComboSkill(slot0.heroInfo_.id) and #slot1 > 0 then
		SetActive(slot0.buttonComboSkill_.gameObject, true)
	else
		SetActive(slot0.buttonComboSkill_.gameObject, false)
	end
end

function slot1.OnHeroSkillUpgrade(slot0, slot1, slot2)
	slot0:RefreshSkillItemS()
end

function slot1.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		2,
		0
	})
end

function slot1.OnEnter(slot0, slot1, slot2)
	slot0.heroViewProxy_ = slot1

	for slot6 = 1, 6 do
		slot0.skillItem_[slot6]:SetProxy(slot1)
	end

	slot0.isSkillReturn = slot2.isSkillReturn or false

	slot0:BindRedPointUI()
	slot0:AniUpdate()
end

function slot1.AniUpdate(slot0)
	if slot0.isSkillReturn then
		slot0.skillAni_.enabled = false

		for slot4 = 1, 5 do
			slot0.skillItem_[slot4]:SetAniState(false)
		end

		slot0.handler_.params_.isSkillReturn = false
		slot0.isSkillReturn = false
	else
		if slot0.skillCxTimer then
			slot0.skillCxTimer:Stop()

			slot0.skillCxTimer = nil
		end

		slot0.skillAni_:Update(0.5)
		slot0.skillAni_:Play("Fx_skill_cx", 0, 0)
	end
end

function slot1.Show(slot0)
	SetActive(slot0.gameObject_, true)

	slot0.skillitem6Ani_.enabled = false
	slot0.comboskillAni_.enabled = false

	if not slot0.isSkillReturn then
		slot0:AniUpdate()
	end

	slot0:RefreshSkillItemS()
end

function slot1.HideAni(slot0)
	slot0.skillAni_:Play("Fx_HeroSkillUI_change")

	slot0.skillAni_.enabled = true

	for slot4 = 1, 5 do
		slot0.skillItem_[slot4]:SetAniState(true)
	end
end

function slot1.Hide(slot0)
	slot0:HideAni()
	SetActive(slot0.gameObject_, false)
end

function slot1.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.teachingBtn_.transform, RedPointConst.HERO_TEACH_ID)
end

function slot1.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.teachingBtn_.transform, RedPointConst.HERO_TEACH_ID)
end

function slot1.Dispose(slot0)
	for slot4 = 1, 6 do
		slot0.skillItem_[slot4]:Dispose()
	end

	slot0.skillItem_ = nil

	if slot0.skillCxTimer then
		slot0.skillCxTimer:Stop()

		slot0.skillCxTimer = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
