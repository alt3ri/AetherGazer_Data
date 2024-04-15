MatrixScoreExchangeView = import("game.views.matrix.matrixScoreExchange.MatrixScoreExchangeView")
slot0 = class("MatrixScoreExchangeMiniView", MatrixScoreExchangeView)

function slot0.UIBackCount(slot0)
	return 3
end

function slot0.UIName(slot0)
	return "UI/Matrix/ScoreExchange/MatrixScoreExchangeMiniUI"
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_MATRIX_COIN,
		CurrencyConst.CURRENCY_TYPE_MATRIX_PT,
		CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION
	})
	manager.windowBar:SetGameHelpKey({
		view = "gameHelpPro",
		type = "jump",
		params = {
			pages = MatrixConst.MATRIX_GAME_HELP_PAGES
		}
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_COIN, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_PT, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_MATRIX_CERTIFICATION, true)
	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.GoToSystem("/matrixBlank/matrixPrepare")
	end)
end

function slot0.OnMatrixSystemOverdue(slot0)
end

return slot0
