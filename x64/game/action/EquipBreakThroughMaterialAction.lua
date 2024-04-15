manager.net:Bind(35001, function (slot0)
	EquipBreakThroughMaterialData:InitData(slot0)
end)
manager.net:Bind(35003, function (slot0)
	EquipBreakThroughMaterialData:UpdateMapData(slot0)
end)

return {
	RequireEquipBTMaterialData = function (slot0, slot1)
		manager.net:SendWithLoadingNew(35100, {
			difficulty = slot0
		}, 35101, function (slot0)
			if isSuccess(slot0.result) then
				uv0(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ChooseBuff = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(35104, {
			id = slot0,
			buff_id = slot1
		}, 35105, function (slot0)
			if isSuccess(slot0.result) then
				uv0(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ChooseHeal = function (slot0, slot1)
		manager.net:SendWithLoadingNew(35106, {
			id = slot0
		}, 35107, function (slot0)
			if isSuccess(slot0.result) then
				uv0(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	ResetMap = function (slot0)
		manager.net:SendWithLoadingNew(35102, {}, 35103, function (slot0)
			if isSuccess(slot0.result) then
				uv0(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SendReceiveReward = function (slot0, slot1)
		manager.net:SendWithLoadingNew(35108, {
			id_list = slot0
		}, 35109, function (slot0)
			if isSuccess(slot0.result) then
				slot1 = {}

				getReward(mergeReward(slot0.reward_list))
				EquipBreakThroughMaterialData:ReceiveReward(uv0)
				uv1(slot0)
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	SaveComboSkillID = function (slot0, slot1)
		manager.net:SendWithLoadingNew(35110, {
			id = slot0
		}, 35111, function (slot0)
			if isSuccess(slot0.result) then
				EquipBreakThroughMaterialData:SetComboSkillID(uv0)
				uv1()
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	CheckTimeout = function ()
		if EquipBreakThroughMaterialData:GetSelectModeID() == 0 then
			uv0.EquipBTMaterialBackEntrace()
		end
	end,
	EquipBTMaterialBackEntrace = function ()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			title = GetTips("PROMPT"),
			content = GetTips("EQUIP_BREAK_THROUGH_REFRESH_DATA"),
			OkCallback = function ()
				gameContext:OverrideUrl("/equipBreakThroughMaterialMap", "/equipBreakThroughMaterialMode", nil, "home")
				gameContext:Go("/equipBreakThroughMaterialMode")
			end,
			MaskCallback = function ()
				gameContext:OverrideUrl("/equipBreakThroughMaterialMap", "/equipBreakThroughMaterialMode", nil, "home")
				gameContext:Go("/equipBreakThroughMaterialMode")
			end
		})
	end,
	EnterEquipBTMaterial = function ()
		if EquipBreakThroughMaterialData:GetSelectModeID() ~= 0 then
			gameContext:Go("/equipBreakThroughMaterialMap")
		else
			gameContext:Go("/equipBreakThroughMaterialMode")
		end
	end
}
