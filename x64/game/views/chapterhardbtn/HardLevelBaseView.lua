slot0 = class("HardLevelBaseView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.hardLevelItems_ = {}

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	for slot4, slot5 in ipairs(slot0.hardLevelItems_) do
		slot5:OnEnter()
	end

	slot0:ShowDifficultPanel(false)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()

	for slot4, slot5 in ipairs(slot0.hardLevelItems_) do
		slot5:OnExit()
	end

	slot0:ShowDifficultPanel(false)
end

function slot0.Dispose(slot0)
	if slot0.hardLevelItems_ then
		for slot4, slot5 in ipairs(slot0.hardLevelItems_) do
			slot5:Dispose()
		end

		slot0.hardLevelItems_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	for slot4 = 1, BattleConst.HARD_CNT do
		slot0.hardLevelItems_[slot4] = slot0:GetHardLevelItem().New(slot0["hardLevelGo" .. slot4 .. "_"], slot4)
	end

	slot0.hardController_ = slot0.btnControllerEx_:GetController("hard")
	slot0.hideController_ = slot0.controllerEx_:GetController("hide")
end

function slot0.GetHardLevelItem(slot0)
	return HardLevelBaseItem
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.selectDifficultBtn_, nil, function ()
		uv0:ShowDifficultPanel(true)
		uv0:ClickListener()
	end)
end

function slot0.RefreshSelectDifficult(slot0)
	if slot0.hardLevel_ == 1 then
		slot0.hardController_:SetSelectedState("hard1")
	elseif slot0.hardLevel_ == 2 then
		slot0.hardController_:SetSelectedState("hard2")
	end

	slot0.difficultText_.text = GetTips(BattleConst.HARD_LANGUAGE[slot0.hardLevel_])
end

function slot0.ShowDifficultPanel(slot0, slot1)
	slot0.hideController_:SetSelectedState(tostring(not slot1))
end

function slot0.ClickListener(slot0)
	if not slot0.clickTimer_ then
		slot0.buttonUp_ = 0
		slot0.clickTimer_ = FuncTimerManager.inst:CreateFuncFrameTimer(function ()
			if Input.GetMouseButtonUp(0) then
				uv0.buttonUp_ = uv0.buttonUp_ + 1

				if uv0.buttonUp_ >= 2 then
					uv0:ShowDifficultPanel(false)
					FuncTimerManager.inst:RemoveFuncTimer(uv0.clickTimer_)

					uv0.clickTimer_ = nil
				end
			end
		end, -1, true)
	end
end

function slot0.StopTimer(slot0)
	if slot0.clickTimer_ then
		FuncTimerManager.inst:RemoveFuncTimer(slot0.clickTimer_)

		slot0.clickTimer_ = nil
	end
end

function slot0.SetData(slot0, slot1)
	slot0.hardLevel_ = slot1

	slot0:RefreshSelectDifficult()
end

return slot0
