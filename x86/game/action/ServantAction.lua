manager.net:Bind(46011, function (slot0)
	WeaponServantData:InitServant(slot0)
	uv0.CheckRedPoint()
end)
manager.notify:RegistListener(MATERIAL_MODIFY, function ()
	uv0.CheckRedPoint()
end)
manager.notify:RegistListener(MATERIAL_LIST_UPDATE, function ()
	uv0.CheckRedPoint()
end)
manager.notify:RegistListener(WEAPON_SERVANT_LIST_UPDATE, function ()
	uv0.CheckRedPoint()
end)

return {
	TouchRedPoint = function ()
		uv0.touched = true

		uv0.CheckRedPoint()
	end,
	CheckRedPoint = function ()
		return

		if uv0.touched == true then
			manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, 0)

			return
		end

		slot1 = false

		for slot5, slot6 in pairs(GameSetting.exclusive_weapon_servant_cost.value) do
			slot9 = 0

			if WeaponServantData:GetWeaponServantById(slot6[2][1][1]) then
				slot9 = #slot8
			end

			if slot7[2][2] <= ItemTools.getItemNum(slot7[2][1]) and slot7[1][2] <= slot9 then
				slot1 = true

				break
			end
		end

		manager.redPoint:setTip(RedPointConst.WEAPON_SERVANT_MERGE, slot1 and 1 or 0)
	end,
	ServantPromote = function (slot0, slot1, slot2, slot3)
		uv0.costMoney = slot3

		manager.net:SendWithLoadingNew(46012, {
			refined_type = slot0,
			uid = slot1,
			cost_uid = slot2
		}, 46013, uv0.OnServantPromote)
	end,
	OnServantPromote = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WeaponServantData:ServantPromote(slot1.uid, slot1.cost_uid)
			manager.notify:Invoke(SERVANT_PROMOTE, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantReplace = function (slot0, slot1)
		manager.net:SendWithLoadingNew(46020, {
			hero_id = slot0,
			servant_id = slot1
		}, 46021, uv0.OnServantReplace)
	end,
	OnServantReplace = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot5 = HeroData:GetHeroData(slot1.hero_id).servant_uid

			if ServantTools.GetServantMap()[slot1.servant_id] then
				HeroAction.ServantReplace(slot3, 0)
			end

			HeroAction.ServantReplace(slot1.hero_id, slot1.servant_id)
			manager.notify:CallUpdateFunc(SERVANT_REPLACE, slot0, slot1)
			manager.notify:Invoke(SERVANT_REPLACE, slot0, slot1, slot5)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantLock = function (slot0)
		manager.net:SendWithLoadingNew(46014, {
			uid = slot0,
			is_lock = WeaponServantData:GetServantDataByUID(slot0).locked == 1 and 0 or 1
		}, 46015, uv0.OnServantLock)
	end,
	OnServantLock = function (slot0, slot1)
		if isSuccess(slot0.result) then
			WeaponServantData:ServantLock(slot1.uid, slot1.is_lock)
			manager.notify:CallUpdateFunc(SERVANT_LOCK, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantMerge = function (slot0, slot1)
		slot2 = {
			servant_id = slot0,
			cost_uid_list = slot1
		}
		slot4 = slot2.cost_uid_list[1]
		slot5 = WeaponServantData:GetServantDataByUID(slot2.cost_uid_list[1]).locked
		slot6 = nil

		for slot11, slot12 in ipairs(slot2.cost_uid_list) do
			if ServantTools.GetServantMap()[slot12] then
				slot6 = slot13

				break
			end
		end

		manager.net:SendWithLoadingNew(46030, slot2, 46031, function (slot0)
			ServantAction.OnServantMerge(slot0, uv0, uv1, uv2, uv3)
		end)
	end,
	OnServantMerge = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = tonumber(slot0.servant_uid)

		if isSuccess(slot0.result) then
			slot7 = {}

			for slot11, slot12 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
				if slot12[1] == WeaponServantCfg[slot1.servant_id].race then
					slot7 = slot12[2]
				end
			end

			WeaponServantData:ServantLock(slot5, slot3)
			WeaponServantData:SetServantMergeMap(slot2, slot5)

			if slot4 then
				HeroData:ServantReplace(slot4, slot5)
			end

			IllustratedAction.ModifyServantInfo(slot1.servant_id)
			manager.notify:CallUpdateFunc(SERVANT_MERGE_RESULT, slot0, slot1)
		elseif TipsCfg[slot0.result] then
			ShowTips(TipsCfg[slot0.result].desc)
		else
			ShowTips(slot0.result)
		end
	end,
	ServantDecompose = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			table.insert(slot1, slot5)
		end

		manager.net:SendWithLoadingNew(46032, {
			servant_list = slot1
		}, 46033, uv0.OnServantDecompose)
	end,
	OnServantDecompose = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(SERVANT_DECOMPOSE_RESULT, slot0, slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	ModifyServantList = function (slot0)
		for slot4, slot5 in ipairs(slot0) do
			if slot5.item.num == 0 then
				WeaponServantData:RemoveServant(slot5)
			else
				uv0.AddNewServant(slot5)
			end
		end

		if #slot0 > 0 then
			manager.notify:Invoke(WEAPON_SERVANT_LIST_UPDATE)
		end
	end,
	AddNewServant = function (slot0)
		WeaponServantData:AddServant({
			uid = slot0.uid,
			id = slot0.item.id
		})
		IllustratedAction.ModifyServantInfo(slot0.item.id)
	end
}
