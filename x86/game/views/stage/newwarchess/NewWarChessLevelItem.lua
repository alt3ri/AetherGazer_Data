slot0 = class("NewWarChessLevelItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.isOpen_ = false
	slot0.activityIsOpen_ = false

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "isopen")

	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not uv0.activityIsOpen_ then
			if manager.time:GetServerTime() < ActivityData:GetActivityData(uv0.cfg_.activity).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(uv0.cfg_.activity).startTime)))
			else
				ShowTips(GetTips("TIME_OVER"))
			end

			return
		end

		if not uv0.isOpen_ then
			ShowTips(string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[uv0.cfg_.front_level_id].name_level))

			return
		end

		if uv0.isOpen_ and uv0.activityIsOpen_ then
			if NewWarChessData:GetExploreValue(uv0.chapterID_) >= 100 then
				ShowMessageBox({
					title = GetTips("PROMPT"),
					content = GetTips("ACTIVITY_NEW_WARCHESS_LEVEL_EXPLORE_MAX"),
					OkCallback = function ()
						NewChessTools.EnterChessMap(uv0.chapterID_)
					end
				})
			else
				NewChessTools.EnterChessMap(uv0.chapterID_)
			end
		end
	end)
end

function slot0.SetEventListener(slot0)
	slot0:RegistEventListener(ACTIVITY_UPDATE, handler(slot0, slot0.OnActivityUpdate))
end

function slot0.RemoveEventListener(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.SetData(slot0, slot1)
	slot0.chapterID_ = slot1
	slot0.cfg_ = NewWarChessLevelCfg[slot1]

	slot0:RefreshUI()
	slot0:RefreshStatus()
end

function slot0.RefreshUI(slot0)
	slot0.nametext_.text = slot0.cfg_.name_level
	slot0.bgImage_.sprite = getSpriteWithoutAtlas("TextureConfig/NewWarChess/" .. slot0.cfg_.background_level)
	slot0.movePointText_.text = NewChessTools.GetMovePointText(NewWarChessData:GetMovePoint(slot0.chapterID_))
	slot0.progressText_.text = NewWarChessData:GetExploreValue(slot0.chapterID_) .. "<size=16>%</size>"
	slot0.progressImage_.fillAmount = NewWarChessData:GetExploreValue(slot0.chapterID_) / 100
end

function slot0.RefreshStatus(slot0)
	if slot0.cfg_.activity ~= 0 then
		if ActivityData:GetActivityIsOpen(slot0.cfg_.activity) then
			slot0.activityIsOpen_ = true

			if slot0.cfg_.front_level_id ~= 0 then
				if NewWarChessData:GetLevelIsFinish(slot1) == 1 then
					slot0.controller_:SetSelectedState("true")

					slot0.isOpen_ = true
				else
					slot0.controller_:SetSelectedState("false")

					slot0.lockText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[slot1].name_level)
					slot0.isOpen_ = false
				end
			else
				slot0.controller_:SetSelectedState("true")

				slot0.isOpen_ = true
			end
		else
			slot0.activityIsOpen_ = false

			slot0.controller_:SetSelectedState("false")

			if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.cfg_.activity).startTime then
				slot0.lockText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot0.cfg_.activity).startTime))

				if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.cfg_.activity).startTime then
					slot0.lockText_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(ActivityData:GetActivityData(slot0.cfg_.activity).startTime))
				else
					slot0.lockText_.text = GetTips("TIME_OVER")
				end
			else
				slot0.lockText_.text = GetTips("TIME_OVER")
			end
		end
	else
		slot0.activityIsOpen_ = true

		if slot0.cfg_.front_level_id ~= 0 then
			if NewWarChessData:GetLevelIsFinish(slot1) == 1 then
				slot0.controller_:SetSelectedState("true")

				slot0.isOpen_ = true
			else
				slot0.controller_:SetSelectedState("false")

				slot0.lockText_.text = string.format(GetTips("ACTIVITY_NEW_WARCHESS_UNLOCK"), NewWarChessLevelCfg[slot1].name_level)
				slot0.isOpen_ = false
			end
		else
			slot0.controller_:SetSelectedState("true")

			slot0.isOpen_ = true
		end
	end
end

function slot0.OnActivityUpdate(slot0, slot1)
	if slot1 == slot0.cfg_.activity then
		slot0:RefreshStatus()
	end
end

function slot0.CreatTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:RefreshStatus()
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
