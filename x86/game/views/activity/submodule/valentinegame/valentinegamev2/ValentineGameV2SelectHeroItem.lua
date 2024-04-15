slot0 = class("ValentineGameV2SelectHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "mask")
	slot0.getController_ = ControllerUtil.GetController(slot0.transform_, "Invited")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ValentineGameData:SetNotNewOpen(uv0.activityID_)
			JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
				activityID = uv0.activityID_
			})
		elseif manager.time:GetServerTime() < ActivityData:GetActivityData(uv0.activityID_).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(uv0.activityID_).startTime)))
		else
			ShowTips(GetTips("TIME_OVER"))
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1
	slot0.cfg_ = ActivityValentineCfg[slot0.activityID_]
	slot0.nameText_.text = slot0.cfg_.name
	slot0.iconImage_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/Role/" .. slot0.cfg_.hero_id)

	slot0:RefreshStatus()
	manager.redPoint:bindUIandKey(slot0.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. slot0.activityID_)
	slot0:RegistEventListener(ACTIVITY_UPDATE, handler(slot0, slot0.OnActivityUpdate))
end

function slot0.RefreshStatus(slot0)
	if ActivityData:GetActivityIsOpen(slot0.activityID_) then
		slot0.lockController_:SetSelectedState("false")

		if ValentineGameData:GetData(slot0.activityID_) and ValentineGameData:GetData(slot0.activityID_).isClear then
			slot0.getController_:SetSelectedState("yes")
		else
			slot0.getController_:SetSelectedState("no")
		end
	else
		slot0.lockController_:SetSelectedState("true")
		slot0.getController_:SetSelectedState("no")

		if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.activityID_).startTime then
			slot0.lockText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot0.activityID_).startTime))
		else
			slot0.lockText_.text = GetTips("TIME_OVER")
		end
	end
end

function slot0.RefreshTimeText(slot0)
	if not ActivityData:GetActivityIsOpen(slot0.activityID_) and manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.activityID_).startTime then
		slot0.lockText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot0.activityID_).startTime))
	end
end

function slot0.OnActivityUpdate(slot0, slot1)
	if slot1 == slot0.activityID_ then
		slot0:RefreshStatus()
	end
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.redTrans_, RedPointConst.VALENTINE_GAME .. "_" .. slot0.activityID_)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
