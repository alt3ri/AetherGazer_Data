slot0 = class("XH3rsWaterReviewItemView", ReduxView)

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

	slot0.selectController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.roleStatusController1_ = ControllerUtil.GetController(slot0.head1Go_.transform, "status")
	slot0.roleStatusController2_ = ControllerUtil.GetController(slot0.head2Go_.transform, "status")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickListener_ ~= nil then
			uv0.clickListener_(uv0.index_, uv0.data_)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "yes" or "no")
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickListener_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.activityId_ = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = ActivityWaterCfg[slot0.data_.schedule_id].schedule_name
	slot0.head1_.sprite = HeroTools.GetHeadSprite(HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot0.data_.competition_list[1].competition_id].hero_id].hero_id)
	slot0.head2_.sprite = HeroTools.GetHeadSprite(HeroStandardSystemCfg[ActivityWaterCompetitionCfg[slot0.data_.competition_list[2].competition_id].hero_id].hero_id)
	slot8, slot9 = nil

	if slot0.data_.competition_list[2].assistance_process < slot0.data_.competition_list[1].assistance_process then
		slot8 = "win"
		slot9 = "lose"
	elseif slot0.data_.competition_list[1].assistance_process == slot0.data_.competition_list[2].assistance_process then
		slot8 = "draw"
		slot9 = "draw"
	else
		slot8 = "lose"
		slot9 = "win"
	end

	if slot0.data_.schedule_id == ActivityWaterData:GetCurrentSchedule(slot0.activityId_).schedule_id then
		slot8 = "current"
		slot9 = "current"

		slot0.statusController_:SetSelectedState("progress")
	else
		slot0.statusController_:SetSelectedState("over")
	end

	slot0.roleStatusController1_:SetSelectedState(slot8)
	slot0.roleStatusController2_:SetSelectedState(slot9)

	if slot0.data_.is_success and slot0.data_.is_success > 0 and not ActivityWaterData:HaveGotHistoryReward(slot0.data_.schedule_id) then
		SetActive(slot0.noticeGo_, true)
	else
		SetActive(slot0.noticeGo_, false)
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil
	slot0.clickListener_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
