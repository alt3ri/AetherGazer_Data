slot1 = class("NewHeroTeamInfoPolyhedronView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.UIName(slot0)
	return "Widget/System/Polyhedron/HeroPolyhedronTeamInfoUI"
end

function slot1.Init(slot0)
	slot1 = slot0.gameObject_

	slot0:InitProxy()

	slot0.gameObject_ = slot0.realGo_
	slot0.transform_ = slot0.realGo_.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.autoClearFilter_ = false
end

function slot1.InitProxy(slot0)
	slot0:BindCfgUI()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_infoBtn, nil, function ()
		PolyhedronData:SetCacheSelectHero(uv0.selectHeroData_.id)

		if not table.keyof(uv0:GetCustomHeroList(), uv0.selectHeroData_.trialID) then
			slot0 = uv0.trialHeroList_
		end

		uv0:Go("/polyhedronHero", {
			isEnter = true,
			type = HeroConst.HERO_DATA_TYPE.POLYHEDRON,
			hid = uv0.selectHeroData_.id,
			tempHeroList = slot0
		})
	end)
	slot0:AddBtnListener(slot0.m_okBtn, nil, function ()
		if not uv0.selectHeroData_ then
			return
		end

		PolyhedronData:SetCacheSelectHero(uv0.selectHeroData_.id)
		JumpTools.OpenPageByJump("/polyhedronBeacon", {})
	end)
	slot0:AddBtnListener(slot0.m_backBtn, nil, function ()
		uv0:Back()
	end)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:SetLocking(false)

	slot2.levelText_.text = HeroStandardSystemCfg[PolyhedronHeroCfg[slot0.heroDataList_[slot1].id].standard_id].hero_lv
end

function slot1.UpdateHeroView(slot0)
	slot1 = slot0.selectHeroData_.id
	slot2 = HeroCfg[slot1]
	slot0.m_heroName.text = GetI18NText(slot2.name)
	slot0.m_heroSuffix.text = GetI18NText(slot2.suffix)
	slot4 = PolyhedronHeroCfg[slot1].standard_id

	slot0.heroAvatarView_:SetSkinId(PolyhedronData:GetHeroUsingSkinInfo(slot1).id)

	slot0.fightPowerText_.text = slot0.heroViewProxy_:GetBattlePower(slot1)
end

function slot1.IsInTeam(slot0, slot1, slot2)
	return false, false, -1
end

function slot1.GetHeroTeam(slot0)
	slot0.heroTeam_ = slot0.params_.heroTeam
	slot0.lockStateList_ = {}
	slot0.lockHeroList_ = {}
	slot0.heroTrialList_ = {
		0
	}
end

function slot1.GetDefaultHeroData(slot0)
	if PolyhedronData:GetCacheSelectHero() ~= 0 then
		return {
			trialID = 0,
			id = slot1,
			type = slot0.heroDataType_,
			heroViewProxy = slot0:GetHeroViewProxy(slot0.heroDataType_)
		}
	end

	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot6, slot7 in pairs(slot0.heroDataList_) do
			if not slot0:IsInTeam(slot7.id) and not table.keyof(slot0.lockHeroList_, slot8) then
				return {
					trialID = 0,
					id = slot8,
					type = slot0.heroDataType_,
					heroViewProxy = slot0:GetHeroViewProxy(slot0.heroDataType_)
				}
			end
		end
	end

	if slot2 == 0 then
		for slot6, slot7 in pairs(slot0.heroDataList_) do
			return {
				trialID = 0,
				id = slot7.id,
				type = slot0.heroDataType_,
				heroViewProxy = slot0:GetHeroViewProxy(slot0.heroDataType_)
			}
		end
	end

	return {
		trialID = 0,
		id = slot2,
		type = slot0.heroDataType_,
		heroViewProxy = slot0:GetHeroViewProxy(slot0.heroDataType_)
	}
end

function slot1.GetHeroList(slot0)
	return PolyhedronData:GetUnlockHeroList()
end

return slot1
