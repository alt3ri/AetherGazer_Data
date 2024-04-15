slot0 = class("StrongholdMainDifficultyItem", ReduxView)

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

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if uv0.clickFunc then
			if CooperationData:GetIsMatching() then
				ShowTips("ERROR_COORDINATOR_ALREADY_IN_MATCH")

				return
			end

			slot1, slot2 = uv0:CheckCondition()

			if not slot1 then
				ShowTips(slot2)

				return
			end

			uv0.clickFunc(uv0.id)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.main_id = slot1
	slot0.id = slot2
	slot0.all_increase_lv = StrongholdData:GetAllIncreaseLevel(slot0.main_id)
	slot0.m_lab.text = ActivityStrongholdCfg[slot2].difficulty_des

	slot0:RefreshTime()
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.id and 1 or 0)
end

function slot0.RefreshTime(slot0)
	slot1, slot2 = slot0:CheckCondition()

	if slot1 then
		slot0.lockController:SetSelectedIndex(0)
	elseif slot0.id == 182203 then
		slot0.m_timeLab.text = slot2

		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.m_lab.text = ActivityStrongholdCfg[slot0.id].difficulty_des .. "-" .. slot2

		slot0.lockController:SetSelectedIndex(0)
	end
end

function slot0.CheckCondition(slot0)
	if ActivityData:GetActivityIsOpen(slot0.id) then
		if slot0.all_increase_lv < ActivityStrongholdCfg[slot0.id].limit_increase_all_lv then
			return false, GetTips(string.format(GetTips("ACTIVITY_STRONGHOLD_DIFFICULTY_LOCK_INCREASE"), slot2))
		end
	elseif ActivityData:GetActivityData(slot0.id) and manager.time:GetServerTime() < slot1.startTime then
		return false, GetTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot1.startTime)))
	else
		return false, GetTips("TIME_OUT")
	end

	return true, ""
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

return slot0
