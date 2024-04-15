NewBattleSettlementView = import("game.views.battleResult.newBattleSettlement.NewBattleSettlementView")
slot0 = class("NewBattleMythicFinalResultView", NewBattleSettlementView)

function slot0.AddListener(slot0)
	uv0.super.AddListener(slot0)
	slot0:AddBtnListener(slot0.confirm2Btn_, nil, function ()
		BattleInstance.TryNextBattle(uv0.stageData)
	end)
	slot0:AddBtnListener(slot0.restartBtn_, nil, function ()
		uv0:RestartFunc()
	end)
	slot0:AddBtnListener(slot0.exitBtn_, nil, function ()
		BattleInstance.QuitBattle(uv0.stageData)
	end)
end

function slot0.RestartFunc(slot0)
	ShowMessageBox({
		content = GetTips("MYTHIC_FINAL_LEVEL_RETRY"),
		OkCallback = function ()
			BattleInstance.OnceMoreBattle(uv0.stageData)
		end
	})
end

function slot0.onRenderBlackRegionContent(slot0)
	if not slot0.blackRegionView then
		slot0.blackRegionView = BattleSettlementBlackRegionModule.New(slot0.contentContainer_)
	end

	slot0.blackRegionView:RenderView({
		stageData = slot0.stageData
	})
end

function slot0.ShowContent(slot0)
	slot0:onRenderBlackRegionContent()
end

function slot0.PostRenderView(slot0)
	if slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				BattleInstance.TryNextBattle(uv0.stageData)
			end
		})
	end

	slot0.btnController:SetSelectedState("blackzone")

	if #MythicData:GetCurLevelIdList() > 1 and slot0.stageData:GetDest() < #MythicData:GetCurLevelIdList() then
		SetActive(slot0.exitBtn_.gameObject, true)
	else
		SetActive(slot0.exitBtn_.gameObject, false)
	end
end

function slot0.RenderTitleView(slot0)
	SetActive(slot0.titleObj_, true)

	slot0.titleTxt_.text = string.format(GetTips("MYTHIC_FINAL_LEVEL"), MythicData:GetCurHotLevelId())
end

function slot0.Dispose(slot0)
	slot0.blackRegionView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
