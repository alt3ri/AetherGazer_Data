slot0 = class("AdminCatExploreFinishView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExploreGetUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItemView)
	slot0.list2 = LuaList.New(handler(slot0, slot0.SetEventData), slot0.list2Go_, AdminCatExploreEventView)
end

function slot0.SetEventData(slot0, slot1, slot2)
	slot2:SetData(slot0.regionData.eventData[slot1], slot0.adminCatID, slot0.regionData.startTime)
end

function slot0.IndexItem(slot0, slot1, slot2)
	CommonTools.SetCommonData(slot2, {
		id = slot0.reward[slot1].id,
		number = slot0.reward[slot1].num,
		clickFun = function (slot0)
			ShowPopItem(POP_OTHER_ITEM, {
				slot0.id
			})
		end
	})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		if uv0.eventId ~= 0 and uv0.isClick == nil then
			uv0.controller:SetSelectedState("get")
			uv0.animator_:Play("Fx_getPanel_cx", -1, 0)

			uv0.isClick = true

			manager.audio:PlayEffect("ui_system_explore", "explore_finish", "")

			return
		end

		uv0:Back()
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.UpdateView(slot0)
	if slot0.eventId ~= 0 then
		slot0.controller:SetSelectedState("event")

		slot1 = ExploreEventCfg[slot0.eventId]
		slot0.eventNameTxt_.text = GetI18NText(slot1.event_name)
		slot0.eventDescTxt_.text = GetI18NText(slot1.description)
		slot0.eventTxt_.text = string.format(GetTips("EXPLORE_EVENT_GAIN"), GetI18NText(slot1.effect_description))

		manager.audio:PlayEffect("ui_system_explore", "explore_working", "")
	else
		slot0.controller:SetSelectedState("get")
		manager.audio:PlayEffect("ui_system_explore", "explore_finish", "")
	end

	slot0.skillData = AdminCatExploreData:GetDataByPara("skillData")
	slot0.regionData = AdminCatExploreData:GetDataByPara("regionData")[slot0.regionId]
	slot1 = ExploreMeowCfg[slot0.adminCatID]
	slot2 = slot1.skill
	slot9 = ExploreAreaCfg[slot0.regionId]

	SetActive(slot0.eventTxt_.gameObject, slot0.eventId ~= 0)
	SetActive(slot0.skillTxt_.gameObject, AdminCatExploreData:GetDataByPara("skillEffect"))
	SetActive(slot0.inbornTxt_.gameObject, AdminCatExploreData:GetDataByPara("inbornEffect"))

	slot0.skillTxt_.text = string.format(GetTips("EXPLORE_SKILL_GAIN"), string.format(GetI18NText(slot3.skill_description), ExploreMeowSkillCfg[slot2].skill_effect[slot0.skillData[slot2]]))
	slot0.inbornTxt_.text = string.format(GetTips("EXPLORE_INBORN_GAIN"), GetI18NText(ExploreMeowInbornCfg[slot1.inborn].inborn_description))

	slot0.list:StartScroll(#slot0.reward)

	slot0.nameTxt_.text = GetI18NText(slot9.area_name)
	slot0.regionImage_.sprite = getSpriteWithoutAtlas("TextureBg/ExploreUI/" .. slot9.icon)
	slot0.adminCatImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. slot1.meow_icon)

	slot0.list2:StartScroll(#slot0.regionData.eventData)
end

function slot0.OnEnter(slot0)
	slot0.regionId = slot0.params_.regionId
	slot0.reward = slot0.params_.reward
	slot0.eventId = slot0.params_.eventId
	slot0.adminCatID = slot0.params_.adminCatID

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	slot0.isClick = nil

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	if slot0.list2 then
		slot0.list2:Dispose()

		slot0.list2 = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
