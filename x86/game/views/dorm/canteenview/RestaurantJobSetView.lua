slot0 = class("RestaurantJobSetView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dining/RoleConfigurationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.sceneID = DormConst.CANTEEN_ID
	slot0.showHeroInfo = CanteenHeroItem.New(slot0.showHeroItem)

	slot0.showHeroInfo:ResetCharacterCallBack(function (slot0)
		uv0:ClickHeroItem(slot0)
	end)

	slot0.heroScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.heroUiList_, CanteenHeroItem)
	slot4 = CanteenSkillItem
	slot0.heroSkillScroll = LuaList.New(handler(slot0, slot0.heroSkillItem), slot0.uiSkillListGo_, slot4)
	slot0.switchBtnController = ControllerUtil.GetController(slot0.transform_, "btnState")
	slot0.fatigueBtnController = ControllerUtil.GetController(slot0.transform_, "fatigue")
	slot0.pageStateController = ControllerUtil.GetController(slot0.transform_, "empty")
	slot0.curWorkController = ControllerUtil.GetController(slot0.roleTrs_, "state")
	slot0.staffController = ControllerUtil.GetController(slot0.transform_, "staff")
	slot0.jobStateController = {}

	for slot4, slot5 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		slot0.jobStateController[slot4] = ControllerUtil.GetController(slot0["job" .. slot4 .. "Tgl_"].gameObject.transform, "state")
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.OnEnter(slot0)
	slot0.jobType = slot0.params_.jobType or slot0.jobType or 1

	slot0:RegisterEvent()
	slot0:SelJob(slot0.jobType)
end

function slot0.OnExit(slot0)
	slot0.params_.jobType = slot0.jobType
	slot0.selHero = nil

	slot0:RemoveAllEventListener()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(CANTEEN_SET_JOG_SUCCESS, function ()
		ShowTips(GetTips("DORM_CANTEEN_HERO_CHANGE_SUCCESS"))
		uv0:RefreshView()
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.confirmBtn_, nil, function ()
		CanteenAction:SetCharacterJob(uv0.jobType, {
			uv0.selHero
		})
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)

	slot4 = nil

	function slot5()
		CanteenAction:SetCharacterJob(DormData:GetCharacterInfo(uv0.selHero).jobType, {
			0
		})
	end

	slot0:AddBtnListenerScale(slot0.removeBtn_, slot4, slot5)

	for slot4, slot5 in ipairs(DormEnum.RestaurantJobToClientMap) do
		slot0:AddToggleListener(slot0["job" .. slot4 .. "Tgl_"], function (slot0)
			if slot0 then
				uv0:SelJob(uv1)
			end
		end)
	end
end

function slot0.SelJob(slot0, slot1)
	slot0.jobType = slot1
	slot0.selHero = nil

	slot0:RefreshView()
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.heroList[slot1], slot0.selHero, slot0.jobType)
	slot2:ResetCharacterCallBack(function (slot0)
		uv0:ClickHeroItem(slot0)
	end)
end

function slot0.ClickHeroItem(slot0, slot1)
	if not DormNpcTools:CheckIDIsNpc(slot1) and CanteenEntrustData:CheckHasChooseEntrustCharacter(slot1) == true then
		ShowTips("CANTEEN_TASK_CANT_CHOOSE")

		return
	end

	slot0.selHero = slot1

	slot0.heroScroll:Refresh()
	slot0:RefreshCurWorkInfo()
	slot0:RefreshHeroInfo()
end

function slot0.heroSkillItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.skillItemList[slot1], slot0.heroLevel, slot1)
end

function slot0.RefreshView(slot0)
	slot0.jobText_.text = string.format(GetTips("CANTEEN_JOB_SET"), GetI18NText(CanteenTools:GetJobName(slot0.jobType)))

	slot0:RefreshJobButtonState()
	slot0:RefreshCanUseHeroList()
	slot0:RefreshHeroInfo()
end

function slot0.RefreshJobButtonState(slot0)
	for slot4, slot5 in ipairs(DormConst.DORM_RESTAURANT_SET_JOB_TYPE) do
		if CanteenHeroTools:HasJobAssignedToHero(slot5) then
			slot0.jobStateController[slot4]:SetSelectedState("on")
		else
			slot0.jobStateController[slot4]:SetSelectedState("off")
		end
	end
end

function slot0.RefreshCurWorkInfo(slot0)
	slot2 = nil

	if DormNpcTools:CheckIDIsNpc(CanteenHeroTools:GetCurWorkIDListByJobType(slot0.jobType)[1]) then
		slot2 = slot1
	elseif slot1 then
		slot2 = DormData:GetHeroInfo(slot1):GetHeroId()
	end

	if not slot0.selHero then
		slot0.selHero = slot2
	end

	if slot2 then
		slot0.showHeroInfo:RefreshUI(slot2, slot0.selHero, slot0.jobType)
	end

	return slot2
end

function slot0.RefreshCanUseHeroList(slot0)
	slot1 = DormHeroTools:GetUnLockBackHomeHeroIDList()
	slot2 = DormNpcTools:GetNpcInfoListByConstJobType(slot0.jobType)
	slot0.heroList = {}

	if slot0:RefreshCurWorkInfo() then
		for slot7, slot8 in ipairs(slot1) do
			if slot8 ~= slot3 then
				table.insert(slot0.heroList, slot8)
			end
		end

		for slot7, slot8 in ipairs(slot2) do
			if slot8 ~= slot3 then
				table.insert(slot0.heroList, slot8)
			end
		end

		slot0.curWorkController:SetSelectedState("full")
	else
		slot0.heroList = slot1

		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot0.heroList, slot8)
		end

		slot0.curWorkController:SetSelectedState("null")
	end

	CommonTools.UniversalSortEx(slot0.heroList, {
		ascend = true,
		map = function (slot0)
			if not DormNpcTools:CheckIDIsNpc(slot0) then
				if not DormData:GetCharacterInfo(slot0).jobType and not CanteenEntrustData:CheckHasChooseEntrustCharacter(slot0) then
					return 1
				end

				if slot2 then
					return 3
				else
					return 4
				end
			else
				return 2
			end
		end
	}, {
		map = function (slot0)
			if not DormNpcTools:CheckIDIsNpc(slot0) then
				slot3 = false

				for slot7, slot8 in ipairs(DormHeroTools:GetAllCanUseHeroIDInDorm(DormData:GetHeroArchiveID(slot0))) do
					if #DormSkillData:CheckSkillCanOpen(uv0.jobType, slot8) > 0 then
						slot3 = true

						break
					end
				end

				if slot3 then
					return 2
				else
					return 1
				end
			end
		end
	}, {
		map = function (slot0)
			if not DormNpcTools:CheckIDIsNpc(slot0) then
				return DormData:GetHeroFatigue(slot0)
			end
		end
	}, {
		map = function (slot0)
			return DormData:GetHeroArchiveID(slot0)
		end
	}, {
		map = function (slot0)
			return slot0
		end
	})
	slot0.heroScroll:StartScroll(#slot0.heroList)
end

function slot0.RefreshHeroInfo(slot0)
	if not slot0.selHero then
		slot0.pageStateController:SetSelectedState("true")

		slot0.lackJobText.text = string.format(GetTips("DORM_SELECT"), CanteenTools:GetJobName(slot0.jobType))

		return
	end

	if DormNpcTools:CheckIDIsNpc(slot0.selHero) then
		slot0:RefreshNpcInfoPage()
	else
		slot0:RefreshHeroInfoPage()
	end
end

function slot0.RefreshNpcInfoPage(slot0)
	slot0.pageStateController:SetSelectedState("false")
	slot0.staffController:SetSelectedState("noviciate_1")

	slot0.heroLevel = nil
	slot1 = BackHomeNpcData:GetNpcInfoById(slot0.selHero)
	slot0.nameText_.text = BackHomeNpcCfg[slot0.selHero].npc_name
	slot0.npcDescTex.text = BackHomeNpcCfg[slot0.selHero].npc_desc

	if DormNpcTools:GetNpcFatigue(slot0.selHero) < 0 then
		slot0.fatigueBtnController:SetSelectedState("infinite")
	end

	slot0.switchBtnController:SetSelectedState("true")

	if slot1.jobType then
		slot0.switchBtnController:SetSelectedState("remove")
	end

	if slot0.jobType == 1 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_COOK_DO")
	elseif slot0.jobType == 2 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_WAITER_DO")
	elseif slot0.jobType == 3 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_CASHIER_DO")
	end

	slot0:RefreshHeroSkillInfo(slot0.selHero)
end

function slot0.RefreshHeroInfoPage(slot0)
	slot0.pageStateController:SetSelectedState("false")
	slot0.staffController:SetSelectedState("xzz")

	slot1 = DormData:GetHeroTemplateInfo(slot0.selHero)
	slot2 = HeroData:GetHeroData(slot0.selHero)
	slot0.heroLevel = slot2.level
	slot0.nameText_.text = GetI18NText(HeroCfg[slot0.selHero].suffix)
	slot0.selHeroLevel = string.format(GetTips("DORM_LEVEL_TIPS"), slot0.heroLevel)
	slot3 = DormData:GetHeroFatigue(slot0.selHero)

	if slot2 then
		slot0.lvText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), slot2.level)
		slot0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
		slot0.curText_.text = slot3
		slot0.progressImg_.fillAmount = 1 - math.min(slot3 / GameSetting.canteen_hero_fatigue_max.value[1], 1)
	end

	slot0.fatigueRe_.text = string.format(GetTips("DORM_CANTEEN_FATIGUE_COST"), slot0:CalFatigurReduce())

	if slot3 <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
		slot0.fatigueBtnController:SetSelectedState("false")
	elseif slot5[1] < slot3 and slot3 <= slot5[2] then
		slot0.fatigueBtnController:SetSelectedState("middle")
	else
		slot0.fatigueBtnController:SetSelectedState("true")
	end

	if slot3 < GameSetting.dorm_canteen_work_fatigue.value[1] / 100 then
		slot0.switchBtnController:SetSelectedState("false")
	else
		slot0.switchBtnController:SetSelectedState("true")
	end

	if slot0.jobType == 1 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_COOK_DO")
	elseif slot0.jobType == 2 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_WAITER_DO")
	elseif slot0.jobType == 3 then
		slot0.btnText_.text = GetTips("DORM_CANTEEN_CASHIER_DO")
	end

	if slot1.jobType then
		slot0.switchBtnController:SetSelectedState("remove")
	end

	slot0:RefreshHeroSkillInfo(slot0.selHero)
end

function slot0.CalFatigurReduce(slot0)
	slot2 = GameSetting.canteen_popular_cost_time.value
	slot3 = slot2[#slot2][2]

	for slot7, slot8 in ipairs(slot2) do
		if CanteenData:GetPopularityNum() < slot8[1] then
			slot3 = slot8[2]
		end
	end

	slot4 = math.ceil(3600 / slot3)
	slot5 = GameSetting.dorm_canteen_fatigue_cost.value[1] / 100

	for slot11, slot12 in ipairs(DormSkillData:CheckSkillCanOpen(slot0.jobType, slot0.selHero)) do
		if BackHomeHeroSkillCfg[slot12].type == CanteenConst.HeroSkillType.FatigueRecuse then
			slot7 = 0 + BackHomeHeroSkillCfg[slot12].param[1]
		end
	end

	return slot4 * slot5 * (100 - slot7) / 100
end

function slot0.RefreshHeroSkillInfo(slot0, slot1)
	if DormNpcTools:CheckIDIsNpc(slot1) then
		slot0.skillItemList = BackHomeNpcCfg[slot1].skill_list
	else
		slot0.skillItemList = BackHomeHeroCfg[slot1].skill_list
	end

	slot0.heroSkillScroll:StartScroll(#slot0.skillItemList)
end

function slot0.Dispose(slot0)
	if slot0.heroScroll then
		slot0.heroScroll:Dispose()

		slot0.heroScroll = nil
	end

	if slot0.heroSkillScroll then
		slot0.heroSkillScroll:Dispose()
	end

	slot0.showHeroInfo:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
