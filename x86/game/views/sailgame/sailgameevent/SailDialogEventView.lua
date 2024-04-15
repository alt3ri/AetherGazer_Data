slot1 = class("SailShopEventView", import("game.views.sailGame.sailGameEvent.SailGameEventBaseView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdVoyagesUI/XH3rdVoyagesHadesEventPopUI"
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot1.AddUIListener(slot0)
	for slot4 = 1, 2 do
		slot0:AddBtnListener(slot0[string.format("dialogBtn%d_", slot4)], nil, function ()
			uv0.statusController_:SetSelectedIndex(1)

			uv0.descText_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_REPLY")
		end)
	end

	slot0:AddBtnListener(slot0.acceptBtn_, nil, function ()
		uv0:AcceptEvent()
	end)
end

function slot1.RefreshUI(slot0)
	uv0.super.RefreshUI(slot0)
	slot0.statusController_:SetSelectedIndex(0)

	slot0.dialogText1_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_OPTION_1")
	slot0.dialogText2_.text = GetTips("ACTIVITY_SKADI_SEA_OSIRIS_EVENT_OPTION_2")
end

function slot1.RefreshReward(slot0)
	if ItemTools.getItemSprite(GameSetting.activity_skadi_sea_osiris_event_reward.value[1]) then
		slot0.rewardIcon_.sprite = slot2
	end

	slot0.rewardNumText_.text = slot1[2]

	SetActive(slot0.rewardPanelGo_, true)
end

function slot1.AcceptEvent(slot0)
	slot0.tipsIndex_ = SailGameConst.GAME_COMMON_TIPS_INDEX.SUCCESS

	SailGameAction.EventOperate(slot0.activityID_, slot0.curStageIndex_, nil)
end

return slot1
