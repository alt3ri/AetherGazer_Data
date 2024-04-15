slot0 = class("IdolTraineeTrainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolTraineeTrainView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.infoPage_ = IdolTraineeTrainInfoPage.New(slot0.pageGo_)
	slot0.trainBtnItemList_ = {}

	for slot4 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		slot0.trainBtnItemList_[slot4] = TrainBtnItem.New(slot0["train" .. slot4 .. "Btn_"])

		slot0.trainBtnItemList_[slot4]:RegisterClickFunc(handler(slot0, slot0.UpdataSelectBtnState))
	end

	slot0.heroList_ = {}
	slot0.curHeroID_ = 0
	slot0.curHeroIndex_ = 0
	slot0.heroUIList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.heroUIList_, IdolTraineeHeadItem)
	slot0.trainAnimController_ = slot0.mainControllerEx_:GetController("trainAnimation")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.skipBtn_, nil, function ()
		manager.notify:Invoke(ON_FINISH_STORY)
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(IDOL_TRAINEE_TRAIN_HERO_PROPERTY_CALLBACK, function (slot0, slot1, slot2)
		uv0:UpdateView(uv0.curHeroID_)
		uv0:RefreshTitle()
		manager.windowBar:HideBar()

		uv0.trainAddIcon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.IdolDanceSkillIcon.path .. "IdolTrainee_icon_skill_00" .. slot1)
		uv0.trainAddName_.text = GetTips("IDOL_SKILL_ATTRIBUTE_" .. slot1)
		uv0.trainAddNum_.text = "+" .. slot2

		uv0.trainAnimController_:SetSelectedState("true")
	end)
	slot0:RegistEventListener(ON_FINISH_STORY, function ()
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
		uv0.trainAnimController_:SetSelectedState("false")
	end)
end

function slot0.OnEnter(slot0)
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", true)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	slot0:RegisterEvents()

	slot0.heroList_ = IdolTraineeData:GetIdolHeroList()
	slot0.curHeroIndex_ = slot0.params_.index or 1

	slot0:UpdateView(slot0.params_.heroID or slot0.heroList_[slot0.curHeroIndex_])
	slot0.heroUIList_:StartScroll(#slot0.heroList_)
	slot0:RefreshTitle()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	IdolTraineeCampBridge.SetVCamActive("CamShootAtTrainningPos", false)
	slot0:RegisterEvents()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.heroList_[slot1], slot0.curHeroID_, function ()
		if uv0.curHeroID_ ~= 0 and uv0.curHeroIndex_ ~= 0 and uv0.heroUIList_:GetItemByIndex(uv0.curHeroIndex_) then
			slot0:SelectOff()
		end

		uv0.curHeroIndex_ = uv1

		uv2:SelectOn()
		uv0:UpdateView(uv0.heroList_[uv1])
	end)
end

function slot0.RefreshTitle(slot0)
	slot1 = IdolTraineeTools:GetCurTrainMaxTimes()
	slot0.trainCountText_.text = slot1 - IdolTraineeData:GetCurTrainTimes() .. "/" .. slot1
	slot4 = {}

	for slot8, slot9 in pairs(IdolTraineeData:GetCurBuffCamp()) do
		table.insert(slot4, slot8)
	end

	if slot4[1] then
		SetActive(slot0.race1Img_.gameObject, true)

		slot0.race1Img_.sprite = HeroTools.GetRaceIcon(slot4[1])
	else
		SetActive(slot0.race1Img_.gameObject, false)
	end

	if slot4[2] then
		SetActive(slot0.race2Img_.gameObject, true)

		slot0.race2Img_.sprite = HeroTools.GetRaceIcon(slot4[2])
	else
		SetActive(slot0.race2Img_.gameObject, false)
	end
end

function slot0.UpdateView(slot0, slot1)
	slot0.curHeroID_ = slot1

	IdolTraineeCampBridge.SetTrainingCharacter(slot0.curHeroID_)
	slot0.infoPage_:RefreshUI(IdolTraineeTools:GetHeroBattleInfoTemplate(slot0.curHeroID_))

	for slot15 = 1, DormConst.IDOL_TRAINEE_PROPERTY_COUNT do
		slot0.trainBtnItemList_[slot15]:SetData(slot0.curHeroID_, slot15, IdolTraineeTools:GetHeroIdolMaxProperty(slot0.curHeroID_)[slot15] <= IdolTraineeData:GetIdolHeroData(slot0.curHeroID_)[slot15], GameSetting.dorm_idol_hero_exercise_cost.value[1] <= DormData:GetHeroTemplateInfo(slot1):GetFatigue(), IdolTraineeTools:CheckHeroRaceBuff(slot0.curHeroID_), IdolTraineeTools:GetCurTrainMaxTimes() <= IdolTraineeData:GetCurTrainTimes())
	end

	slot0.maxFText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.curFText_.text = slot5:GetFatigue()
	slot0.recFText_.text = string.format(GetTips("DORM_FATIGUE_PER_HOUR"), slot5:GetRecoverFatigueNum())

	slot0:UpdataSelectBtnState(0)
end

function slot0.UpdataSelectBtnState(slot0, slot1)
	slot5 = slot1

	slot0.infoPage_:SelectFlashBar(slot5)

	slot0.selIndex = slot1

	for slot5, slot6 in ipairs(slot0.trainBtnItemList_) do
		slot6:RefreshBtnState(slot0.selIndex)
	end
end

function slot0.Dispose(slot0)
	if slot0.heroUIList_ then
		slot0.heroUIList_:Dispose()

		slot0.heroUIList_ = nil
	end

	if slot0.infoPage_ then
		slot0.infoPage_:Dispose()

		slot0.infoPage_ = nil
	end

	for slot4, slot5 in pairs(slot0.trainBtnItemList_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
