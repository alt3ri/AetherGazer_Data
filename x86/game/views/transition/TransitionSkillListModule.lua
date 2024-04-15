slot0 = class("TransitionSkillView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:BuildContext()
	slot0:AddUIListeners()
end

function slot0.BuildContext(slot0)
	slot0.context = {
		curTabIdx = 1,
		tabModule = TransitionSkillListTabModule.New(slot0.tabModuleObj_)
	}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListObj_, TransitionSkillItem)
end

function slot0.InitContext(slot0)
	slot0.data = {
		curGiftPt = 0,
		curSelectID = 0,
		index = 1,
		heroID = 0,
		leftPt = 0,
		type = HeroConst.HERO_DATA_TYPE.DEFAULT,
		heroDataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT),
		list = {},
		useList = {},
		curUseList = {}
	}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot3, slot0.data.curUseList[slot0.data.list[slot1]] or 1)
	slot2:SetUsed(slot0:IsUsed(slot3))
	slot2:SetSelect(slot0.data.curSelectID == slot3)
	slot2:RegistCallBack(function ()
		uv0:OnItemClick(uv1)
	end)
end

function slot0.AddUIListeners(slot0)
	slot0.context.tabModule:RegisterClickCallback(handler(slot0, slot0.OnTabClick))

	slot0.tryToImproveTransitionGiftPtHandler_ = handler(slot0, slot0.OnTryToImproveTransitionGiftPt)

	manager.notify:RegistListener(IMPROVE_TRANSITION_GIFT_PT, slot0.tryToImproveTransitionGiftPtHandler_)
end

function slot0.RenderView(slot0, slot1)
	slot0:InitContext()

	slot0.data.index = slot1.index or 1
	slot0.data.heroID = slot1.heroID
	slot0.data.type = slot1.type or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.data.heroDataProxy = HeroViewDataProxy.New(slot0.data.type)

	slot0.context.tabModule:OnTabClick(slot0.data.index)
end

function slot0.GetData(slot0)
	slot0:GetUseList()
	slot0:GetCurUseList()
end

function slot0.GetUseList(slot0)
	slot0.data.curGiftPt = 0

	for slot6, slot7 in ipairs(slot0:GetHeroTransition()) do
		if slot7.slot_id == slot0.data.index then
			slot0.data.curGiftPt = slot7.talent_points

			break
		end
	end

	slot0.data.useList = {
		[slot8] = deepClone(slot7.skill_list)
	}
end

function slot0.GetCurUseList(slot0)
	slot1 = {
		all = {},
		[slot7] = slot6.skill_level
	}

	for slot5, slot6 in ipairs(slot0.data.useList[slot0.data.index] or {}) do
		table.insert(slot1.all, slot6.skill_id)
	end

	slot0.data.curUseList = slot1
end

function slot0.RefreshUI(slot0)
	slot0:RefreshList()
	slot0:RefreshType()
end

function slot0.RefreshList(slot0)
	slot1 = HeroCfg[slot0.data.heroID].hero_equip_skill[slot0.data.index] or {}

	table.sort(slot1, function (slot0, slot1)
		if uv0:IsUsed(slot0) ~= uv0:IsUsed(slot1) then
			return uv0:IsUsed(slot0)
		end

		if uv0:IsUsed(slot0) and uv0:IsUsed(slot1) and uv0.data.curUseList[slot0] ~= uv0.data.curUseList[slot1] then
			return slot3 < slot2
		end

		return slot0 < slot1
	end)

	slot0.data.list = slot1
	slot0.data.curSelectID = slot0.data.list[1]

	slot0.scrollHelper_:StartScroll(#slot0.data.list)
	slot0:OnItemClick(slot0.data.curSelectID)
end

function slot0.RefreshType(slot0)
	slot0.data.leftPt = slot0.data.curGiftPt

	for slot4, slot5 in ipairs(slot0.data.curUseList.all) do
		slot0.data.leftPt = slot0.data.leftPt - slot0.data.curUseList[slot5]
	end

	slot0.restrictTxt_.text = table.concat({
		GetTips("JUMP_EQUIP_UPPER_DESC"),
		#slot0.data.curUseList.all,
		"/",
		GameSetting.exclusive_skill_use_num_max.value[1]
	})

	slot0:DispatchJumpElementChangeEmitter()
end

function slot0.IsUsed(slot0, slot1)
	return slot0.data.curUseList[slot1] ~= nil
end

function slot0.IsSelected(slot0, slot1)
	return slot1 == slot0.data.curSelectID
end

function slot0.SaveData(slot0, slot1)
	if manager.net ~= nil and manager.net.tcpConnection_ ~= nil and manager.net.tcpConnection_:GetMachineState() and (slot2 == "connected" or slot2 == "connecting") then
		slot3 = {}

		if not slot0.data.curUseList or not slot0.data.curUseList.all then
			return
		end

		for slot7, slot8 in ipairs(slot0.data.curUseList.all) do
			slot3[slot7] = {
				skill_id = slot8,
				skill_level = slot0.data.curUseList[slot8]
			}
		end

		HeroAction.TryToSaveTransitionSkill(slot0.data.heroID, slot0.data.index, slot3, slot1)
	end
end

function slot0.OnTryToImproveTransitionGiftPt(slot0)
	ShowTips("EXCLUSIVE_SKILL_POINT_UP")
	slot0:GetUseList()
	slot0.scrollHelper_:Refresh()
	slot0:RefreshType()
end

function slot0.OnExit(slot0)
	slot0:SaveData()
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(IMPROVE_TRANSITION_GIFT_PT, slot0.tryToImproveTransitionGiftPtHandler_)
	slot0:RemoveAllEventListener()
	slot0:RemoveAllListeners()

	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	slot0.context.tabModule:Dispose()

	slot0.context.tabModule = nil

	uv0.super.Dispose(slot0)
end

function slot0.RegisterTabListener(slot0, slot1)
	slot0.context.tabSwitchEmitter = slot1
end

function slot0.RegisterItemClickListener(slot0, slot1)
	slot0.context.itemClickEmitter = slot1
end

function slot0.RegisterRefreshJumpElement(slot0, slot1)
	slot0.context.jumpElementChangeEmitter = slot1
end

function slot0.RegisterRefreshJumpSlotView(slot0, slot1)
	slot0.context.jumpSlotRefreshEmitter = slot1
end

function slot0.OnTabClick(slot0, slot1)
	slot0:SaveData()

	slot0.data.index = slot1

	slot0:GetData()
	slot0:RefreshUI()
	slot0:DispatchTabSwitchEmitter(slot1)
end

function slot0.OnItemClick(slot0, slot1)
	slot0.data.curSelectID = slot1

	slot0.scrollHelper_:Refresh()
	slot0:DispatchItemClickEmitter(slot1)
end

function slot0.DispatchTabSwitchEmitter(slot0, slot1)
	if slot0.context.tabSwitchEmitter then
		slot2(slot1)
	end
end

function slot0.DispatchItemClickEmitter(slot0, slot1)
	if slot0.context.itemClickEmitter then
		slot2({
			skillID = slot1,
			level = slot0.data.curUseList[slot1] or 1,
			equipped = slot0:IsUsed(slot1)
		})
	end
end

function slot0.DispatchJumpElementChangeEmitter(slot0)
	if slot0.context.jumpElementChangeEmitter then
		slot1({
			totalElement = slot0.data.curGiftPt,
			leftElement = slot0.data.leftPt
		})
	end
end

function slot0.DispatchJumpSlotRefreshEmitter(slot0, slot1)
	if slot0.context.jumpSlotRefreshEmitter then
		slot2(slot0:GetSlotParam(slot1))
	end
end

function slot0.OnSkillEquip(slot0)
	if GameSetting.exclusive_skill_use_num_max.value[1] <= #slot0.data.curUseList.all then
		ShowTips("EXCLUSIVE_SKILL_MAX")

		return
	end

	if slot0.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = slot0.data.curGiftPt,
			heroID = slot0.data.heroID,
			index = slot0.data.index
		})

		return
	end

	slot0.data.curUseList[slot0.data.curSelectID] = 1

	table.insert(slot0.data.curUseList.all, slot0.data.curSelectID)
	slot0.scrollHelper_:Refresh()
	slot0:RefreshType()
	slot0:DispatchItemClickEmitter(slot0.data.curSelectID)
	slot0:DispatchJumpSlotRefreshEmitter(slot0.data.index)
	ShowTips("EXCLUSIVE_SKILL_LOAD")
end

function slot0.OnSkillExchange(slot0)
	slot1 = slot0.data.curUseList
	slot2 = slot0.data.curSelectID

	table.remove(slot1.all, table.indexof(slot1.all, slot2))

	slot1[slot2] = nil

	slot0.scrollHelper_:Refresh()
	slot0:RefreshType()
	slot0:DispatchItemClickEmitter(slot0.data.curSelectID)
	slot0:DispatchJumpSlotRefreshEmitter(slot0.data.index)
	ShowTips("EXCLUSIVE_SKILL_UNLOAD")
end

function slot0.OnSkillLevelUp(slot0)
	if slot0.data.leftPt <= 0 then
		JumpTools.OpenPageByJump("transitionGiftPt", {
			isEnter = true,
			giftPt = slot0.data.curGiftPt,
			heroID = slot0.data.heroID,
			index = slot0.data.index
		})

		return
	end

	slot1 = slot0.data.curUseList
	slot2 = slot0.data.curSelectID
	slot1[slot2] = slot1[slot2] + 1

	slot0.scrollHelper_:Refresh()
	slot0:RefreshType()
	slot0:DispatchItemClickEmitter(slot0.data.curSelectID)
	slot0:DispatchJumpSlotRefreshEmitter(slot0.data.index)
	ShowTips("EXCLUSIVE_SKILL_LEVEL_UP")
end

function slot0.ResetUseList(slot0)
	slot0.data.curUseList = {
		all = {}
	}

	slot0.scrollHelper_:Refresh()
	slot0:RefreshType()
	slot0:DispatchItemClickEmitter(slot0.data.curSelectID)
end

function slot0.GetCurGiftPoint(slot0)
	return slot0.data.curGiftPt
end

function slot0.GetSlotParam(slot0, slot1)
	slot2 = {
		slotIdx = slot1,
		heroId = slot0.data.heroID,
		skills = {}
	}

	for slot6, slot7 in ipairs(slot0.data.curUseList.all) do
		slot2.skills[slot6] = {
			skillId = slot7,
			level = slot0.data.curUseList[slot7]
		}
	end

	return slot2
end

function slot0.GetHeroData(slot0)
	return slot0.data.heroDataProxy:GetHeroData(slot0.data.heroID)
end

function slot0.GetHeroTransition(slot0)
	return slot0.data.heroDataProxy:GetHeroTransitionInfoList(slot0.data.heroID) or {}
end

function slot0.GetHeroEquip(slot0)
	return slot0.heroDataProxy:GetEquipInfoList(slot0.data.heroID)
end

return slot0
