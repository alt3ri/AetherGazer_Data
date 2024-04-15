slot1 = class("XH3rdWaterBattleStatisticsItemView", import("game.views.battleResult.statistics.BattleStatisticsHeroItem"))

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.haveHeroController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "haveHero")
	slot0.cooperationController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "cooperation")
	slot0.reportController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "report")

	slot0.reportController_:SetSelectedIndex(0)

	slot0.controllers_ = {
		ControllerUtil.GetController(slot0.highGo1_.transform, "zero"),
		ControllerUtil.GetController(slot0.highGo2_.transform, "zero"),
		ControllerUtil.GetController(slot0.highGo3_.transform, "zero"),
		ControllerUtil.GetController(slot0.highGo4_.transform, "zero"),
		ControllerUtil.GetController(slot0.highGo5_.transform, "zero")
	}

	slot0:AddBtnListener(slot0.reportBtn_, nil, function ()
		CooperationAction.CooperationReport(uv0.player_.playerID, BattleFieldData:GetServerBattleID())
		uv0.reportController_:SetSelectedIndex(1)
	end)
end

function slot1.SetPlayer(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	slot0.index_ = slot1
	slot0.scheduleActivityId_ = slot2
	slot0.maxFangfan_ = slot4
	slot0.maxZjj_ = slot5
	slot0.player_ = slot3
	slot0.isCooperation_ = slot6
	slot0.extraData_ = slot7

	slot0:RefreshUI()

	if slot8 then
		SetActive(slot0.captainGo_, true)
	else
		SetActive(slot0.captainGo_, false)
	end
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)

	if slot0.isCooperation_ then
		slot0.cooperationController_:SetSelectedState("true")
	else
		slot0.cooperationController_:SetSelectedState("false")
	end

	if not slot0.player_ or not slot0.heroData_ then
		slot0.nickText_.text = ""

		slot0.reportController_:SetSelectedState("2")

		return
	end

	if slot0.isCooperation_ then
		slot0.reportController_:SetSelectedState("1")

		slot0.nickText_.text = slot0.player_.nick
	else
		slot0.reportController_:SetSelectedState("2")

		slot1 = HeroCfg[slot0.heroData_.id]
		slot0.nickText_.text = string.format("%s·%s", slot1.name, slot1.suffix)
	end

	if slot0.extraData_ then
		slot3 = 59
		slot1[slot2] = slot1[45] or 0
		slot1[slot3] = slot1[slot3] or 0

		if slot1[slot2] == 0 then
			slot0.battleCountFangfanNum_.text = "0"

			slot0.controllers_[4]:SetSelectedState("true")
		else
			slot0.battleCountFangfanNum_.text = slot1[slot2] or 0

			slot0.controllers_[4]:SetSelectedState("false")
		end

		if slot1[slot3] == 0 then
			slot0.battleCountZjjNum_.text = "0"

			slot0.controllers_[5]:SetSelectedState("true")
		else
			slot0.battleCountZjjNum_.text = slot1[slot3] or 0

			slot0.controllers_[5]:SetSelectedState("false")
		end

		slot0.battleCountFangfanImg_.enabled = slot0.maxFangfan_ < slot1[slot2]
		slot0.battleCountZjjImg_.enabled = slot0.maxZjj_ < slot1[slot3]
	else
		slot0.battleCountFangfanNum_.text = "0"
		slot0.battleCountZjjNum_.text = "0"
		slot0.battleCountFangfanImg_.enabled = false
		slot0.battleCountZjjImg_.enabled = false

		slot0.controllers_[4]:SetSelectedState("false")
		slot0.controllers_[5]:SetSelectedState("false")
	end
end

return slot1
