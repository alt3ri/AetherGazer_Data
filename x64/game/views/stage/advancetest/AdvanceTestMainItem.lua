slot0 = class("AdvanceTestMainItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.mainActivityID = AdvanceTestData:GetMainActivityID()
	slot0.index_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()
	slot0:InitUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.InitUI(slot0)
	slot1 = nil

	if slot0.index_ == 1 then
		slot1 = "SS"
	elseif slot0.index_ == 2 then
		slot1 = "SSS"
	elseif slot0.index_ == 3 then
		slot1 = "Ω"
	end

	slot0.stageText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_6"), slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_(uv0.index_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0:SetSelectMode(slot0.index_ == slot1)

	if AdvanceTestData:GetHistortyMaxScoreByIndex(slot0.index_) == -1 then
		slot0.scoreText_.text = ""
	else
		slot0.scoreText_.text = slot2
	end
end

function slot0.SetSelectMode(slot0, slot1)
	if slot1 then
		slot0.selectController_:SetSelectedState("selected")
	else
		slot0.selectController_:SetSelectedState("normal")
	end
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

return slot0
