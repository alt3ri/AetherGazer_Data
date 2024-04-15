slot0 = class("SPHeroChallengeAffixItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("state")
	slot0.showTipsController = slot0.controller:GetController("showTips")

	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if uv0.timer then
			uv0.timer:Stop()

			uv0.timer = nil
		end

		uv0.showTipsController:SetSelectedState("show")
		uv0:RefreshDesc()

		uv0.timer = Timer.New(function ()
			uv0.showTipsController:SetSelectedState("close")
			uv0.timer:Stop()

			uv0.timer = nil
		end, 3, 1)

		uv0.timer:Start()
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.activityID = SPHeroChallengeData:GetActivityID()

	slot0.showTipsController:SetSelectedState("close")

	if ActivityHeroChallengeCfg[slot0.activityID] then
		slot6 = slot3["affix_group_" .. SpHeroChallengeConst.trainIndex[slot1]][slot2]
		slot0.affixID = slot6[2]
		slot0.nameText.text = GetTips("TIP_CLEARTIMES") .. slot6[1]
		slot0.skillText.text = ActivityAffixPoolCfg[slot6[2]].name
		slot0.skillIcon.sprite = getSpriteWithoutAtlas(SpritePathCfg.AffixIcon.path .. PublicBuffCfg[slot6[2]].icon)

		if SPHeroChallengeData:GetCurActivityInfo():GetTrainNumByType(slot1) <= slot6[1] then
			slot0.stateController:SetSelectedState("lock")
		else
			slot0.stateController:SetSelectedState("unlock")
		end
	end
end

function slot0.RefreshDesc(slot0)
	slot0.name.text = ActivityAffixPoolCfg[slot0.affixID].name
	slot0.desc.text = GetCfgDescription(AffixTypeCfg[slot0.affixID].description[1])
end

function slot0.Dispose(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
