slot0 = class("NewBattleStatisticsView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/BattleResult/Common/BattleResultStatisticsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.adaptComp = slot0:FindCom("AdaptImage", nil, slot0.commonBgMask_.transform)

	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.hasSnapshot_ = slot0.params_.hasSnapshot_
	slot0.statisticsHeroItem_ = {}
	slot1, slot2, slot3 = BattleTools.GetBattleStatisticsData()
	slot5 = LuaExchangeHelper.GetBattleStatisticsData() and slot4.dataForLua.currentHPHero or {}

	for slot11, slot12 in ipairs(slot0.stageData:GetHeroTeam()) do
		if slot12 ~= 0 then
			slot7 = 0 + 1
		end
	end

	if (slot5.Count or 0) ~= slot7 then
		for slot12 = 1, 3 do
			if slot12 <= slot8 then
				slot0.heroModule[slot12]:SetHeroData(slot12, slot0.stageData:GetHeroDataByPos(table.indexof(slot6, slot5[slot12 - 1])))
				slot0.heroModule[slot12]:SetStatisticsData(slot2, slot3, slot1[slot12])
			else
				slot0.heroModule[slot12]:SetHeroData(slot12, nil)
			end
		end
	else
		for slot12 = 1, 3 do
			slot0.heroModule[slot12]:SetHeroData(slot12, slot0.stageData:GetHeroDataByPos(slot12))
			slot0.heroModule[slot12]:SetStatisticsData(slot2, slot3, slot1[slot12])
		end
	end

	slot0:SetLevelTitle()
	slot0:RefreshTimeText()
	slot0:RenderMaskBg()

	if slot0.params_.battleResult ~= nil and slot0.params_.battleResult.errorCode ~= nil and slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				uv0:CloseFunc()
			end
		})
	end
end

function slot0.CloseFunc(slot0)
	BattleInstance.QuitBattle(slot0.stageData)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	for slot4 = 1, 3 do
		slot0.heroModule[slot4]:Dispose()
	end

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroModule = {
		NewBattleStatisticsHeroItem.New(slot0.hero1Obj_),
		NewBattleStatisticsHeroItem.New(slot0.hero2Obj_),
		NewBattleStatisticsHeroItem.New(slot0.hero3Obj_)
	}
end

function slot0.SetLevelTitle(slot0, slot1)
	slot2 = slot0.stageData:GetStageId()
	slot3 = slot0.stageData:GetType()
	slot5, slot6 = BattleStageTools.GetChapterSectionIndex(slot3, slot2)

	if slot5 ~= "" then
		slot0.titleTxt_.text = string.format("%s-%s ", GetI18NText(slot5), GetI18NText(slot6)) .. BattleStageTools.GetStageName(slot3, slot2)
	else
		slot0.titleTxt_.text = slot4
	end
end

function slot0.RefreshTimeText(slot0)
	SetActive(slot0.timeTxt_.gameObject, slot0.params_.battleTime ~= nil)

	if not slot0.params_.battleTime then
		return
	end

	slot0.timeTxt_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		slot0.params_.battleTime or "00"
	})
end

function slot0.RenderMaskBg(slot0)
	if not slot0.hasSnapshot_ then
		slot0.commonBgMask_.sprite = getSpriteWithoutAtlas("TextureBg/BattleResult/battleResult_bg_common")

		slot0.adaptComp:AdaptImg()
		SetActive(slot0.commonBgMask_.gameObject, true)
		SetActive(slot0.bgMask_.gameObject, false)
	else
		SetActive(slot0.commonBgMask_.gameObject, false)
		SetActive(slot0.bgMask_.gameObject, true)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.shareBtn_, nil, function ()
		manager.share:Share(function ()
			SetActive(uv0.shareBtn_.gameObject, false)
			SetActive(uv0.backBtn_.gameObject, false)
		end, function ()
			SetActive(uv0.shareBtn_.gameObject, true)
			SetActive(uv0.backBtn_.gameObject, true)
		end)
	end)
end

return slot0
