slot0 = class("StrongholdBattleResultAchieveItem", ReduxView)

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

	slot0.levelController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1)
	slot2 = ActivityStrongholdAchievementCfg[slot1]
	slot0.m_name.text = slot2.name

	slot0.levelController:SetSelectedIndex(math.max(0, slot2.level - 1))
end

return slot0
