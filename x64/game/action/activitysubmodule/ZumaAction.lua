manager.notify:RegistListener(TASK_LIST_CHANGE_NOTIFY, function ()
	uv0.CheckZumaRewardRedPoint()
end)
manager.notify:RegistListener(ACTIVITY_UPDATE, function (slot0)
	if ActivityTools.GetActivityType(slot0) == ActivityTemplateConst.ACTIVITY_ZUMA_ENTER or slot1 == ActivityTemplateConst.ACTIVITY_ZUMA then
		uv0.CheckZumaRedPoint()
		uv0.CheckZumaTalentRedPoint()
	end
end)
manager.net:Bind(79001, function (slot0)
	ZumaData:InitZumaData(slot0)
	uv0.CheckZumaRedPoint()
	ZumaAction.CheckZumaTalentRedPoint()
end)

return {
	CheckZumaRedPoint = function ()
		for slot4, slot5 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.ACTIVITY_ZUMA] or {}) do
			uv0.CheckZumaOpenRedPoint(slot5)
		end

		uv0.CheckZumaRewardRedPoint()
	end,
	CheckZumaOpenRedPoint = function (slot0)
		if not ActivityData:GetActivityIsOpen(slot0) or ZumaData:GetZumaRead(slot0) then
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot0), 0)

			return
		end

		if ActivityData:GetActivityIsOpen(slot0) then
			slot1 = ZumaData:GetZumaIdByActId(slot0)

			if ZumaData:GetZumaBeforeIsFinish(slot1) and not ZumaData:GetZumaStageScore(slot1) then
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot0), 1)
			else
				manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot0), 0)
			end
		else
			manager.redPoint:setTip(string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot0), 0)
		end
	end,
	CheckZumaRewardRedPoint = function ()
		if #TaskTools:GetCanGetActivityTaskList(ActivityConst.ACTIVITY_ZUMA) <= 0 then
			manager.redPoint:setTip(RedPointConst.ZUMA_REWARD, 0)
		else
			manager.redPoint:setTip(RedPointConst.ZUMA_REWARD, 1)
		end
	end,
	CheckZumaTalentRedPoint = function ()
		if not ActivityData:GetActivityIsOpen(ActivityConst.ACTIVITY_ZUMA) or ZumaData:GetZumaRead(ZumaConst.TalentViewID) then
			manager.redPoint:setTip(RedPointConst.ZUMA_TALENT, 0)

			return
		end

		slot2 = 0

		for slot6, slot7 in ipairs(ActivityZumaTalentCfg.all) do
			slot9 = false

			if not ZumaData:GetZumaTalentRead(slot7) and not ZumaData:GetZumaTalentIsOpen(slot7) then
				if ZumaData:GetZumaTalentIsCanOpen(slot7) and ActivityZumaTalentCfg[slot7].need <= ZumaData:GetZumaCoin() then
					slot9 = true
					slot2 = 1
				end

				ZumaData:SetTalentRedList(slot7, slot9)
			end
		end

		manager.redPoint:setTip(RedPointConst.ZUMA_TALENT, slot2)
	end,
	QueryZumaCompelet = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(79002, {
			activity_id = slot0,
			id = slot1,
			result = slot2 or 1,
			score = slot3,
			useseconds = slot4
		}, 79003, uv0.OnZumaCampeletCallBack)
	end,
	OnZumaCampeletCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ZumaData:UpdateZumaStageData(slot1)
			ZumaData:UpdateZumaCoin(slot0.value)
			uv0.CheckZumaRedPoint()
			ZumaAction.CheckZumaTalentRedPoint()
		end
	end,
	OpenZumaTalent = function (slot0, slot1)
		manager.net:SendWithLoadingNew(79004, {
			activity_id = slot1 or ZumaData:GetZumaActivityID(),
			talent_id = slot0
		}, 79005, uv0.OnOpenZumaTalentCallBack)
	end,
	OnOpenZumaTalentCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ZumaData:SetUseZumaTalent(slot1.talent_id)
			ZumaData:SetZumaCoin(slot0.value)
			manager.notify:CallUpdateFunc(ZUMA_TALENT_UPDATE, slot1.talent_id)
		end
	end,
	ResetZumaTalent = function (slot0)
		manager.net:SendWithLoadingNew(79006, {
			activity_id = slot0 or ZumaData:GetZumaActivityID()
		}, 79007, uv0.OnResetZumaTalentCallBack)
	end,
	OnResetZumaTalentCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ZumaData:ResetTalentList()
			ZumaData:UpdateZumaCoin(slot0.value)
			manager.notify:CallUpdateFunc(ZUMA_TALENT_UPDATE)
		end
	end,
	PlayZumaGame = function (slot0)
		if not ActivityZumaLevelCfg[slot0 or 1] then
			error("can not find mapCfg")

			return
		end

		if not ActivityData:GetActivityIsOpen(slot1.activity_id) then
			ShowTips("TIME_OVER")

			return
		end

		ZumaData:ResetZumaGameData()
		ZumaData:SetZumaBallCount(0)
		ZumaData:SetZumaGameId(slot0)
		DestroyLua()
		ZumaLuaBridge.Launcher(uv0.GetZumaEnterData(slot1))
	end,
	GetZumaEnterData = function (slot0)
		slot1 = GetZumaDataForExchange()
		slot1.mapName = slot0.map
		slot1.difficult = slot0.difficult
		slot2 = {}

		for slot7, slot8 in pairs(ZumaData:GetTalentList() or {}) do
			if ActivityZumaTalentCfg[slot7] then
				slot10 = ZumaTalentData.New()
				slot10.talentType = slot9.talent_type
				slot10.talentValue = slot9.talent_value

				table.insert(slot2, slot10)
			end
		end

		slot1.talentList = slot2

		return slot1
	end
}
