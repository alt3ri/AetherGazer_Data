slot0 = class("HanafudaSelectFirstPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.enemyFirstBtn_, nil, function ()
		if uv0.type_ == 1 then
			HanafudaData:StartGame(HanafudaData.GAME_STATE.COMPUTER_TURN)
			uv0:Back()
		elseif uv0.type_ == 2 then
			HanafudaData:SetComputerDiffculty(1)
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_card_enemy", "")
			uv0:Back()
		end
	end)
	slot0:AddBtnListener(slot0.playerFirstBtn_, nil, function ()
		if uv0.type_ == 1 then
			HanafudaData:StartGame(HanafudaData.GAME_STATE.PLAYER_TURN)
			uv0:Back()
		elseif uv0.type_ == 2 then
			HanafudaData:SetComputerDiffculty(2)
			uv0:Back()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.callback = slot0.params_.callback
	slot0.type_ = slot0.params_.type

	slot0.typeController_:SetSelectedState(slot0.type_)
end

function slot0.OnExit(slot0)
	slot0.callback()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
