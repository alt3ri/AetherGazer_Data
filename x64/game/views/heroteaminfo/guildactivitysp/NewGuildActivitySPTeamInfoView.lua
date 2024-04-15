slot1 = class("NewGuildActivitySPTeamInfoView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.energyItem_ = GuildActivitySPTeamInfoEnergyItemView.New(Object.Instantiate(Asset.Load("UI/GuildActivitySPUI/items/spenergy"), slot0.extensionContainer_))
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:SetEnergy(true, GuildActivitySPData:GetHeroFatigue(slot0.heroDataList_[slot1].id))
end

function slot1.RefreshInfoBtn(slot0)
	SetActive(slot0.infoBtn_.gameObject, false)
end

function slot1.GetHeroList(slot0)
	slot2 = HeroData:GetHeroList()
	slot5 = GuildActivitySPData
	slot7 = slot5

	for slot6, slot7 in ipairs(slot5.GetFightHeroList(slot7)) do
		if slot2[slot7.id] then
			-- Nothing
		end
	end

	return HeroTools.Sort({
		[slot7.id] = slot2[slot7.id]
	})
end

function slot1.UpdateHeroView(slot0)
	uv0.super.UpdateHeroView(slot0)
	slot0.energyItem_:SetCurrent(true)
	slot0.energyItem_:SetData(GameSetting.activity_club_sp_hero_fatigue_max.value[1], GuildActivitySPData:GetHeroFatigue(slot0.selectHeroData_.id))
end

function slot1.Dispose(slot0)
	if slot0.energyItem_ then
		slot0.energyItem_:Dispose()

		slot0.energyItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
