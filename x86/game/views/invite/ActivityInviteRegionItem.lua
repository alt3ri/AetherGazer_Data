slot0 = class("ActivityInviteRegionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.SetDelegate(slot0, slot1)
	slot0.delegate_ = slot1
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.regionBtn_, nil, function ()
		slot1 = InviteData:GetDataByPara("activityId")

		if not uv0.completePlotTable[uv0.plotId] then
			if InviteData:GetDataByPara("inviteTimes") == 0 then
				ShowTips("ACTIVITY_INVITE_TIME_NOT_ENOUGH")
			else
				InviteAction.CompletePlot(slot1, uv0.plotId)
			end
		else
			JumpTools.GoToSystem("ActivityInvitePlotView", {
				id = uv0.plotId
			})
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.plotId = slot1
	slot0.index = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = ActivityInviteCfg[slot0.plotId]
	slot0.heroId = slot1.hero_id
	slot0.completeHeroTable = InviteData:GetDataByPara("completeHeroTable")
	slot0.completePlotTable = InviteData:GetDataByPara("completePlotTable")
	slot0.inviteTimes = InviteData:GetDataByPara("inviteTimes")
	slot0.regionNameTxt_.text = GetTips("ACTIVITY_INVITE_REGION" .. slot1.region)
	slot0.regionImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. slot1.image_route)

	SetActive(slot0.gameObject_, slot0.index <= 3 or #slot0.completeHeroTable[slot0.heroId] >= 4)
	slot0.controller:SetSelectedState(slot0.completePlotTable[slot0.plotId] and "2" or "1")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
