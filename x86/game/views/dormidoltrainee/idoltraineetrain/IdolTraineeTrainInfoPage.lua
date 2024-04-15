slot0 = class("IdolTraineeTrainInfoPage", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.override1_ = slot2
	slot0.override2_ = slot3

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.curHeroID_ = 0
	slot0.curContent_ = 0
	slot0.propertyItemList_ = {}

	for slot4 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		slot0.propertyItemList_[slot4] = TrainInfoPropertyItem.New(slot0["property" .. slot4 .. "Go_"])
	end

	slot0.skillItemList_ = {}

	for slot4 = 1, 3 do
		slot0.skillItemList_[slot4] = TrainInfoSkillItem.New(slot0["skill" .. slot4 .. "Go_"])
	end

	slot0.heroAllProperty_ = 0
	slot0.styleData_ = {}
	slot0.styleUIList_ = LuaList.New(handler(slot0, slot0.IndexStyleItem), slot0.styleList_, EnterBattleStyleListItem)
	slot0.contentController_ = slot0.mainControllerEx_:GetController("content")
	slot0.flashBarController_ = slot0.mainControllerEx_:GetController("flashBar")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.propertyBtn_, nil, function ()
		if uv0.override1_ then
			uv0.override1_()

			return
		end

		uv0:ChangeContent(1)
	end)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		if uv0.override2_ then
			uv0.override2_()

			return
		end

		uv0:ChangeContent(2)
	end)
end

function slot0.IndexStyleItem(slot0, slot1, slot2)
	slot2:SetData(slot0.styleData_[slot1])
end

function slot0.RefreshUI(slot0, slot1)
	slot0.curContent_ = nil

	if slot1 and slot1.heroID == 0 then
		dump("空状态")
	else
		slot0.template = slot1
		slot0.curHeroID_ = slot1.heroID
		slot0.heroAllProperty_ = 0

		for slot5, slot6 in ipairs(slot0.template.propertyData) do
			slot0.heroAllProperty_ = slot0.heroAllProperty_ + slot6
		end

		if HeroCfg[slot0.curHeroID_] then
			slot0.name_.text = HeroCfg[slot0.curHeroID_].suffix
			slot0.raceIcon_.sprite = HeroTools.GetHeroRaceIcon(slot0.curHeroID_)
		elseif IdolPveNpcCfg[slot0.curHeroID_] then
			slot0.name_.text = IdolPveNpcCfg[slot0.curHeroID_].name
			slot0.raceIcon_.sprite = HeroTools.GetRaceIcon(IdolPveNpcCfg[slot0.curHeroID_].race)
		end

		if BackHomeHeroCfg[slot0.curHeroID_] then
			slot0.styleData_ = BackHomeHeroCfg[slot0.curHeroID_].idol_style

			slot0.styleUIList_:StartScroll(#slot0.styleData_)
		end

		slot0.heroIcon_.sprite = slot1.heroIcon

		slot0:ChangeContent(2)
		slot0:ChangeContent(1)
	end
end

function slot0.ChangeContent(slot0, slot1)
	if slot0.curContent_ == slot1 then
		return
	end

	slot0.curContent_ = slot1

	if slot1 == 1 then
		slot0.contentController_:SetSelectedState("property")

		for slot7 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
			slot0.propertyItemList_[slot7]:SetData(slot0.template.propertyData[slot7], slot0.template.propertyMax[slot7])
		end
	else
		slot0.contentController_:SetSelectedState("skill")

		for slot6 = 1, #slot0.template.skill do
			slot0.skillItemList_[slot6]:SetData(slot2[slot6], slot0.heroAllProperty_)
			SetActive(slot0.skillItemList_[slot6].gameObject_, true)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillItemList_[slot6].transform_)
		end

		for slot6 = #slot2 + 1, #slot0.skillItemList_ do
			SetActive(slot0.skillItemList_[slot6].gameObject_, false)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.skillRootTrs_)
	end
end

function slot0.SelectFlashBar(slot0, slot1)
	slot0.flashBarController_:SetSelectedState(slot1)

	if slot1 == 0 then
		return
	end

	slot0.previewTrs_:SetAnchoredPositionY(slot0.propertyItemList_[slot1].transform_.anchoredPosition.y - 284)

	slot3 = DormData:GetHeroTemplateInfo(slot0.template.heroID):GetFatigue()
	slot6 = 10

	for slot10, slot11 in ipairs(GameSetting.dorm_idol_hero_exercise_default_value.value) do
		if slot11[1] <= slot0.template.propertyData[slot1] / slot0.template.propertyMax[slot1] * 100 then
			slot6 = slot11[2]
		end
	end

	slot7 = 0

	for slot11, slot12 in ipairs(GameSetting.dorm_idol_hero_exercise_fatigue_addition.value) do
		if slot12[1] <= slot3 then
			slot7 = slot12[2]
		end
	end

	slot8 = 0

	if IdolTraineeTools:CheckHeroRaceBuff(slot0.template.heroID) then
		slot8 = GameSetting.dorm_idol_hero_exercise_camp_addition.value[1]
	end

	if math.floor(slot6 * (100 + slot7 + slot8) / 10000 * GameSetting.dorm_idol_hero_exercise_random.value[2]) < math.floor(slot5 - slot4) then
		slot0.previewText_.text = "+" .. math.floor(slot6 * (100 + slot7 + slot8) / 10000 * GameSetting.dorm_idol_hero_exercise_random.value[1]) .. "~" .. slot10
	elseif slot9 < slot11 then
		slot0.previewText_.text = "+" .. slot9 .. "~" .. slot11
	else
		slot0.previewText_.text = "+" .. slot11
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.propertyItemList_) do
		slot5:Dispose()
	end

	for slot4, slot5 in pairs(slot0.skillItemList_) do
		slot5:Dispose()
	end

	slot0.styleUIList_:Dispose()

	slot0.styleUIList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
