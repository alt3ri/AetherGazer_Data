slot0 = class("IdolTraineeLevelListItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.stateController_ = slot0.mainControllerEx_:GetController("state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.challengeBtn_, nil, function ()
		uv0.timer = Timer.New(handler(uv0, function ()
			if not IdolTraineeCampBridge.cinemachineBrain.IsBlending then
				JumpTools.OpenPageByJump("/idolTraineeEnterBattleView", {
					pvpBattle_ = false,
					stageID = uv0.stageID
				})
			end
		end), 0.34, 1):Start()
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.stageID = slot1
	slot4 = IdolTraineePveBattleCfg[slot1]
	slot6 = nil

	if IdolTraineeTools:GetChapterScoreList(slot3) then
		slot6 = slot5[slot1]
	end

	if not slot6 then
		slot0.stateController_:SetSelectedState("lock")
	elseif not slot6.pass then
		slot0.stateController_:SetSelectedState("unlock")
	else
		slot0.stateController_:SetSelectedState("complete")

		slot0.score_.text = slot6.score
	end

	slot0.levelID_.text = slot3 .. "-" .. slot2
	slot0.levelName_.text = slot4.name
end

function slot0.Dispose(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
