slot0 = class("GameHelpMultiView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/InstructionspopUI03"
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

	slot0.infoItems_ = {}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.titleList or {}
	slot2 = slot0.params_.contentList or {}

	for slot6 = 1, #slot1 do
		if not slot0.infoItems_[slot6] then
			slot0.infoItems_[slot6] = GameHelpMultiItem.New(Object.Instantiate(slot0.infoItemGo_, slot0.infoItemRootTrs_))
		end

		slot0.infoItems_[slot6]:SetData(slot1[slot6], slot2[slot6])
		slot0.infoItems_[slot6]:Show(true)
	end

	for slot6 = #slot1 + 1, #slot0.infoItems_ do
		slot0.infoItems_[slot6]:Show(false)
	end

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
