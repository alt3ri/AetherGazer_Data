slot0 = class("SelectOpponentListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
	slot0:InitAbilityItem()

	slot0.typeController_ = slot0.mainControllerEx_:GetController("strenthTier")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		slot0 = IdolTraineeData:GetCurPVPStage()

		if uv0.curUserID_ and uv0.friendType and slot0 then
			BackHomeCricketAction:AskPvPBattleData(uv0.curUserID_, uv0.friendType, slot0)
		end
	end)
	slot0:AddBtnListener(slot0.compareBtn_, nil, function ()
		JumpTools.OpenPageByJump("idolTraineeBattleComparePop", {
			userID = uv0.curUserID_,
			friendType = uv0.friendType
		})
	end)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		if uv0.curUserID_ then
			ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.curUserID_, true)
		end
	end)
end

function slot0.InitAbilityItem(slot0)
	slot0.abilityList = {}

	for slot4 = 1, IdolTraineeConst.AbilityNum do
		slot0.abilityList[slot4] = IdolTraineeAbilityItem.New(slot0["propitem" .. slot4 .. "Go_"])
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.curUserID_ = slot1
	slot0.friendType = slot2
	slot3 = IdolTraineeTools:GetOpponentData(slot1, slot2)
	slot0.playerName_.text = GetI18NText(slot3.nick)
	slot0.playerIcon_.sprite = ItemTools.getItemSprite(slot3.icon)
	slot0.heroIcon_.sprite = DormHeroTools.GetBackHomeHeadSprite(slot3.hero_id)
	slot0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(slot3.hero_id)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot3.icon_frame)

	for slot8 = 1, IdolTraineeConst.AbilityNum do
		slot0.abilityList[slot8]:SetData(slot3.property[slot8])

		slot4 = 0 + slot3.property[slot8]
	end

	slot6 = 0

	for slot10, slot11 in pairs(IdolTraineeData:GetCurAttackHeroInfo()) do
		for slot15 = 1, IdolTraineeConst.AbilityNum do
			slot6 = slot6 + slot11[slot15]
		end
	end

	if slot4 / slot6 < 0.8 then
		slot0.typeController_:SetSelectedState("strong")
	elseif slot4 / slot6 > 1.1 then
		slot0.typeController_:SetSelectedState("weak")
	else
		slot0.typeController_:SetSelectedState("middle")
	end
end

function slot0.Dispose(slot0)
	if slot0.abilityList then
		for slot4, slot5 in pairs(slot0.abilityList) do
			slot5:Dispose(slot0)
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
