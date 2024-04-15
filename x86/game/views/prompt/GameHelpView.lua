slot0 = class("GameHelpView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/InstructionspopUI02"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMessage.transform
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_ or {}
	slot0.contentText_.text = slot1.content
	slot0.titleText_.text = slot1.title or GetTips("STAGE_DESCRIPE")
	slot0.scrollView_.normalizedPosition = Vector2(0, 1)
end

function slot0.OnExit(slot0)
	slot0:RecordStay(slot0.params_.key)
end

function slot0.RecordStay(slot0, slot1)
	slot2 = slot0:GetStayTime()
	slot3 = 0

	if slot1 == "EQUIP_STAGE_DESCRIPE" then
		slot3 = 50101
	elseif slot1 == "ENCHANTMENT_DESCRIPE" then
		slot3 = 50102
	elseif slot1 == "MATRIX_DESCRIPE" then
		slot3 = 50103
	elseif slot1 == "BOSS_CHALLENGE_DESC" then
		slot3 = 50104
	elseif slot1 == "MYTHIC_DESCRIPE" then
		slot3 = 50105
	elseif slot1 == "SPAWN_DESCRIPE" then
		slot3 = 50106
	elseif slot1 == "TEACH_STAGE_DESC" then
		slot3 = 50107
	end

	OperationRecorder.RecordStayView("STAY_VIEW_GAME_HELP", slot2, slot3)
end

return slot0
