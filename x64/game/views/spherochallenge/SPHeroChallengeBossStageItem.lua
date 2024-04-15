slot0 = class("SPHeroChallengeBossStageItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("state")
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot3 = BattleVerthandiExclusiveCfg[slot1]
	slot0.stageID = slot1

	slot0.stateController:SetSelectedState("unlock")

	if slot2 == slot0.stageID then
		slot0.stateController:SetSelectedState("selected")
	end

	if slot3 then
		slot4, slot5 = SPHeroChallengeTools:CheckStageIsOpen(slot1)
		slot0.bossnameText_.text = slot3.name

		if slot4 then
			slot0.stateController:SetSelectedState("lock")

			slot0.conditiontextText_.text = slot5 or ""
		elseif SPHeroChallengeData:GetCurActivityInfo():GetBossScoreInfo(slot1) > 0 then
			slot0.recordText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_RECORD"), slot7)
		else
			slot0.recordText_.text = GetTips("NO_RECORD")
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bossitemBtn_, nil, function ()
		if uv0.stateController:GetSelectedState() == "lock" then
			return
		end

		if uv0.clickFunc then
			uv0.clickFunc(uv0.stageID)
		end
	end)
end

function slot0.RegisterClickCallBack(slot0, slot1)
	if slot1 then
		slot0.clickFunc = slot1
	end
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
