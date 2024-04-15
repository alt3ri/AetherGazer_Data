slot0 = class("ChapterMapView", ReduxView)
slot1 = import("game.const.BattleConst")

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationOvUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.toggleView_ = {}
	slot0.contentView_ = {}

	slot0:InitUI()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		NAVI_BAR,
		INVITE_BAR
	})
end

function slot0.OnEnter(slot0, slot1)
	SetActive(slot0.mainContent_, false)
	SetActive(slot0.resourceContent_, false)
	SetActive(slot0.equipContent_, false)
	SetActive(slot0.challengeContent_, false)
	SetActive(slot0.plotExPanel_, false)
	manager.ui:SetMainCamera("chapterSelect")

	for slot5, slot6 in pairs(slot0.contentView_) do
		slot6:OnEnter()
	end

	for slot5, slot6 in pairs(slot0.toggleView_) do
		slot6:OnEnter()
	end

	slot0:SwitchToggle(slot0.params_.chapterToggle)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:OnExit()
	end

	manager.ui:ResetMainCamera()

	for slot4, slot5 in pairs(slot0.toggleView_) do
		slot5:OnExit()
	end

	slot0:RecordStay(slot0.curToggle)
end

function slot0.Dispose(slot0)
	if slot0.clickListenerTimer_ then
		slot0.clickListenerTimer_:Stop()

		slot0.clickListenerTimer_ = nil
	end

	for slot4, slot5 in pairs(slot0.toggleView_) do
		slot5:Dispose()
	end

	slot0.toggleView_ = nil

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:Dispose()
	end

	slot0.contentView_ = nil

	uv0.super.Dispose(slot0)

	slot0.mainToggle_ = nil
	slot0.resourceToggle_ = nil
	slot0.equipToggle_ = nil
	slot0.challengeToggle_ = nil
	slot0.mapContent_ = nil
	slot0.resourceContent_ = nil
	slot0.challengeContent_ = nil
	slot0.equipContent_ = nil
end

function slot0.OnUpdate(slot0)
	slot0:SwitchToggle(slot0.params_.chapterToggle)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.toggleView_[uv0.TOGGLE.MAIN] = ChapterBtnView.New(slot0.mainButton_, uv0.TOGGLE.MAIN)
	slot0.toggleView_[uv0.TOGGLE.RESOURCE] = ChapterBtnView.New(slot0.resourceButton_, uv0.TOGGLE.RESOURCE)
	slot0.toggleView_[uv0.TOGGLE.CHALLENGE] = ChapterBtnView.New(slot0.challengeButton_, uv0.TOGGLE.CHALLENGE)
	slot0.toggleView_[uv0.TOGGLE.EQUIP] = ChapterBtnView.New(slot0.equipButton_, uv0.TOGGLE.EQUIP)
end

function slot0.SwitchToggle(slot0, slot1)
	slot0:HideWeakGuide()

	if slot0.contentView_[slot1] == nil then
		slot0:CreateContentView(slot1)
	end

	for slot5, slot6 in pairs(slot0.contentView_) do
		slot0.contentView_[slot5]:SetActive(slot5 == slot1)
	end

	for slot5, slot6 in pairs(slot0.toggleView_) do
		slot0.toggleView_[slot5]:SelectChapterToggle(slot5 == slot1)
	end

	if slot0.curToggle and slot1 ~= slot0.curToggle then
		slot0:RecordStay(slot0.curToggle)
	end

	slot0.curToggle = slot1
end

function slot0.CreateContentView(slot0, slot1)
	if slot1 == uv0.TOGGLE.MAIN then
		slot0.contentView_[slot1] = ChapterMainContentView.New(slot0.mainContent_, slot1)
	elseif slot1 == uv0.TOGGLE.RESOURCE then
		slot0.contentView_[slot1] = ChapterDailyContentView.New(slot0.resourceContent_, slot1)
	elseif slot1 == uv0.TOGGLE.EQUIP then
		slot0.contentView_[slot1] = ChapterEquipContentView.New(slot0.equipContent_, slot1)
	elseif slot1 == uv0.TOGGLE.CHALLENGE then
		slot0.contentView_[slot1] = ChapterChallengeContentView.New(slot0.challengeContent_, slot1, slot0)
	end

	slot0.contentView_[slot1]:OnEnter()
end

function slot0.RecordStay(slot0, slot1)
	if slot0:GetStayTime() == 0 then
		return
	end

	slot3 = 0

	if slot1 == uv0.TOGGLE.MAIN then
		slot3 = 70
	elseif slot1 == uv0.TOGGLE.RESOURCE then
		slot3 = 20
	elseif slot1 == uv0.TOGGLE.EQUIP then
		slot3 = 30
	elseif slot1 == uv0.TOGGLE.CHALLENGE then
		slot3 = 40
	end

	OperationRecorder.RecordStayView("STAY_VIEW_CHAPTER_MAP", slot2, slot3)
	slot0:UpdateLastOpenTime()
end

return slot0
