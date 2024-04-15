slot0 = class("CoreVerificationBossItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.bossType_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroHeadItem_ = {}

	for slot4 = 1, 6 do
		slot0.heroHeadItem_[slot4] = CoreVerificationRoleIcon.New(slot0["hero" .. slot4 .. "Go_"])
	end

	slot0.passController_ = slot0.mainControllerEx_:GetController("passState")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.mainBtn_, nil, function ()
		uv0:Go("/coreVerificationInfo", {
			bossType = uv0.bossType_
		})
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData({
		hero_id = slot0.lockHero_[slot1],
		skin_id = HeroTools.HeroUsingSkinInfo(slot0.lockHero_[slot1]).id
	})
end

function slot0.RefreshUI(slot0)
	slot0.lockHero_ = CoreVerificationData:GetLockHeroByBossType(slot0.bossType_)
	slot1, slot2, slot3 = CoreVerificationData:GetMaxPassByBossType(slot0.bossType_)

	if slot1 then
		slot0.passController_:SetSelectedState("complete")

		slot0.timeText_.text = manager.time:DescCdTime2(slot3)
	else
		slot0.passController_:SetSelectedState("empty")
	end

	for slot7 = 1, 6 do
		slot0.heroHeadItem_[slot7]:SetData(slot0.lockHero_[slot7])
	end

	slot0.diffText_.text = slot2
	slot0.bossImg_.sprite = getSpriteWithoutAtlas(string.format("%s%s", SpritePathCfg.BossAttribute.path, CoreVerificationData:GetBossUICfgByBossType(slot0.bossType_).icon))

	if CoreVerificationData:GetRecommendByBossType(slot0.bossType_)[1] then
		SetActive(slot0.recommend1Img_.gameObject, true)

		slot0.recommend1Img_.sprite = HeroTools.GetSkillAttributeIcon(slot5[1])
	else
		SetActive(slot0.recommend1Img_.gameObject, false)
	end

	if slot5[2] then
		SetActive(slot0.recommend2Img_.gameObject, true)

		slot0.recommend2Img_.sprite = HeroTools.GetSkillAttributeIcon(slot5[2])
	else
		SetActive(slot0.recommend2Img_.gameObject, false)
	end
end

function slot0.Dispose(slot0)
	for slot4 = 1, 6 do
		if slot0.heroHeadItem_[slot4] then
			slot0.heroHeadItem_[slot4]:Dispose()

			slot0.heroHeadItem_[slot4] = nil
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
