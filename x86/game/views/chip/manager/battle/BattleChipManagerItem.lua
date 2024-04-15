slot1 = class("BattleChipManagerItem", import("game.views.chip.manager.ChipManagerItem"))

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		uv0:Go("/battleChipManager", {
			chipManagerID = uv0.chipManagerID_,
			stageID = uv0.chipManagerDataTemplate_.stageID_,
			stageType = uv0.chipManagerDataTemplate_.stageType_,
			sectionProxy = uv0.chipManagerDataTemplate_.sectionProxy_
		})
	end)
end

function slot1.SetTemplateData(slot0, slot1)
	slot0.chipManagerDataTemplate_ = slot1
end

return slot1
