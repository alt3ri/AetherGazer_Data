slot0 = class("MoonPartyVisitItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.visitBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		MoonCakeData:SetTempVisitIndex(uv0.activityID_, uv0.type_, uv0.index_)

		slot1 = nil

		MoonCakeAction.VisitParty(uv0.activityID_, uv0.visitorData_.uid, (uv0.type_ ~= MoonCakeConst.VISIT_TYPE.ALL or MoonCakeConst.VISIT_WAY.ALL) and MoonCakeConst.VISIT_WAY.FRIEND)
	end)
	slot0:AddBtnListener(slot0.headBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		ForeignInfoAction:TryToCheckForeignDetailInfo(uv0.visitorData_.uid)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.type_ = slot1
	slot0.index_ = slot2
	slot0.visitorData_ = slot3
	slot0.activityID_ = slot4

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshPrincipal()
	slot0:RefreshStatus()
end

function slot0.RefreshPrincipal(slot0)
	slot0.userName_.text = slot0.visitorData_.nick
	slot0.userLevel_.text = "LV." .. slot0.visitorData_.level
	slot0.userIcon.sprite = ItemTools.getItemSprite(slot0.visitorData_.portrait)
	slot0.userFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot0.visitorData_.frame)
end

function slot0.RefreshStatus(slot0)
	slot0.statusController_:SetSelectedState(slot0.visitorData_.isVisited == true and "off" or "on")
end

return slot0
