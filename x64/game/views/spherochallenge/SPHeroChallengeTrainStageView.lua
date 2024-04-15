slot0 = class("SPHeroChallengeTrainStageView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTrainStageUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.offsetController = slot0.controller:GetController("offset")
	slot4 = "state"
	slot0.stateController = slot0.controller:GetController(slot4)
	slot0.affixItem = {}

	for slot4 = 1, 3 do
		slot0.affixItem[slot4] = SPHeroChallengeAffixItem.New(slot0["progressdesc" .. slot4 .. "Go_"])
	end
end

function slot0.OnEnter(slot0)
	slot0.trainType = slot0.params_.trainType

	if slot0.params_.playAnimation then
		slot0.animator:Play("Fx_SPHeroChallengeTrainStageUI_cx", 0, 0)

		slot0.params_.playAnimation = nil
	end

	slot0.activityID = SPHeroChallengeData:GetActivityID()
	slot0.info = SPHeroChallengeData:GetCurActivityInfo()

	slot0:RefreshProficiency()
	slot0:RefreshTrainEffectDesc()
	slot0:RefreshStageInfo()
	slot0:RefreshBar()
	slot0:RefreshBackBtnState()
	slot0:RefreshTrainIconAndName()
end

function slot0.OnTop(slot0)
end

function slot0.OnBehind(slot0)
	slot0:RefreshBackBtnState()
end

function slot0.RefreshBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("/spHeroChallengeBattleToggleView", {
			groupIndex = SpHeroChallengeConst.ChapterType.train
		})
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		if uv0:IsOpenSectionView() then
			uv0:Back()
			uv0:RefreshBackBtnState()
		end
	end)
end

function slot0.RegisterEvents(slot0)
end

function slot0.Dispose(slot0)
	if slot0.stageInfoList then
		for slot4, slot5 in pairs(slot0.stageInfoList) do
			slot5:Dispose()
		end
	end

	if slot0.affixItem then
		for slot4, slot5 in ipairs(slot0.affixItem) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

function slot0.RefreshProficiency(slot0)
	if slot0.info then
		slot1, slot2 = slot0.info:GetTrainNumByType(slot0.trainType)
		slot0.sliderSlr_.value = string.format("%.2f", slot1 / slot2)
		slot0.curNumText_.text = slot1
	end
end

function slot0.RefreshTrainEffectDesc(slot0)
	if slot0.affixItem then
		for slot4, slot5 in ipairs(slot0.affixItem) do
			slot5:RefreshUI(slot0.trainType, slot4)
		end
	end
end

function slot0.RefreshStageInfo(slot0)
	slot1 = BattleVerthandiExclusiveCfg.get_id_list_by_sub_type[slot0.trainType]

	if not slot0.stageInfoList then
		slot0.stageInfoList = {}

		for slot5 = 1, #slot1 do
			slot0.stageInfoList[slot5] = SPHeroChallengeTrainStageItem.New(slot0["trainstageitem" .. slot5 .. "Go_"])
		end
	end

	for slot5 = 1, #slot1 do
		slot0.stageInfoList[slot5]:RefreshUI(slot1[slot5], slot0.stageID, slot5)
		slot0.stageInfoList[slot5]:RegisterClickCallBack(handler(slot0, slot0.ClickStageHandle))
	end
end

function slot0.ClickStageHandle(slot0, slot1, slot2)
	slot0.stageID = slot1
	slot0.selectIndex = slot2

	JumpTools.OpenPageByJump("spHeroChallengeSectionView", {
		section = slot0.stageID,
		sectionType = BattleConst.STAGE_TYPE_NEW.SP_HERO_CHALLENGE_BATTLE_3_1,
		activityId = slot0.params_.activityId,
		challengeType = SpHeroChallengeConst.ChapterType.train
	})
	slot0:RefreshBackBtnState(slot2)
	slot0:RefreshStageInfo()
end

function slot0.IsOpenSectionView(slot0)
	return slot0:IsOpenRoute("spHeroChallengeSectionView")
end

function slot0.RefreshBackBtnState(slot0)
	if slot0:IsOpenSectionView() then
		SetActive(slot0.backBtn_.gameObject, true)

		if slot0.selectIndex then
			slot0.offsetController:SetSelectedState(tostring(slot0.selectIndex))
		end
	else
		SetActive(slot0.backBtn_.gameObject, false)
		slot0.offsetController:SetSelectedState("ori")
	end
end

function slot0.RefreshTrainIconAndName(slot0)
	slot1, slot0.icon.sprite = SPHeroChallengeTools:GetTrainNameAndIcon(slot0.trainType)
	slot0.name.text = slot1
	slot0.descText_.text = slot1 .. GetTips("TIP_CLEARTIMES")

	slot0.stateController:SetSelectedState(tostring(slot0.trainType))
end

return slot0
