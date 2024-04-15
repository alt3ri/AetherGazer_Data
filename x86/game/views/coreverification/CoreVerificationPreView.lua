slot0 = class("CoreVerificationPreView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Core_Verification/CoreVerificationPreview"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = CoreVerificationData:GetPreviewInfo()
	slot4 = BossChallengeUICfg[CoreVerificationInfoCfg[slot1[1][1]].stage_id] or BossChallengeUICfg[3090009]
	slot5 = BossChallengeUICfg[CoreVerificationInfoCfg[slot1[2][1]].stage_id] or BossChallengeUICfg[3090009]
	slot0.mainImg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.CollectBoss.path, slot4.boss_id_list[1]))
	slot0.mainText_.text = GetI18NText(slot4.main_name)
	slot0.subImg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.CollectBoss.path, slot5.boss_id_list[1]))
	slot0.subText_.text = GetI18NText(slot5.main_name)
	slot0.title1Text_.text = GetTips("CORE_VERIFICATION_BOSS_1")
	slot0.title2Text_.text = GetTips("CORE_VERIFICATION_BOSS_2")

	if slot2.recommend[1] then
		SetActive(slot0.mainRe1Img_.gameObject, true)

		slot0.mainRe1Img_.sprite = HeroTools.GetSkillAttributeIcon(slot2.recommend[1])
	else
		SetActive(slot0.mainRe1Img_.gameObject, false)
	end

	if slot2.recommend[2] then
		SetActive(slot0.mainRe2Img_.gameObject, true)

		slot0.mainRe2Img_.sprite = HeroTools.GetSkillAttributeIcon(slot2.recommend[2])
	else
		SetActive(slot0.mainRe2Img_.gameObject, false)
	end

	if slot3.recommend[1] then
		SetActive(slot0.subRe1Img_.gameObject, true)

		slot0.subRe1Img_.sprite = HeroTools.GetSkillAttributeIcon(slot3.recommend[1])
	else
		SetActive(slot0.subRe1Img_.gameObject, false)
	end

	if slot3.recommend[2] then
		SetActive(slot0.subRe2Img_.gameObject, true)

		slot0.subRe2Img_.sprite = HeroTools.GetSkillAttributeIcon(slot3.recommend[2])
	else
		SetActive(slot0.subRe2Img_.gameObject, false)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
