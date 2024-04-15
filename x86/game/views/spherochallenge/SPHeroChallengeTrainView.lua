slot0 = class("SPHeroChallengeTrainView", import(".SPHeroChallengeBattleStageBaseView"))

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTrainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController = slot0.controller:GetController("open")
end

function slot0.OnEnter(slot0)
	slot0:RefreshBar()

	if not slot0.params_.showFlag then
		slot0.lockController:SetSelectedState("no")

		if slot0.params_.reason then
			slot0.lockdescText_.text = GetTips(slot0.params_.reason)
		end
	else
		slot0.lockController:SetSelectedState("open")
	end
end

function slot0.RefreshBar(slot0)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	for slot4 = SpHeroChallengeConst.BattleSubType.train1, SpHeroChallengeConst.BattleSubType.train3 do
		slot0:AddBtnListener(slot0["trainitem" .. slot4 .. "Btn_"], nil, function ()
			JumpTools.OpenPageByJump("/spHeroChallengeTrainStageView", {
				playAnimation = true,
				trainType = uv0
			})
		end)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
