slot0 = class("GuildActivitySPDispatchItemView", ReduxView)

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

	slot0.statusController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "status")
	slot0.selectController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
	slot0.dispatchTypeController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "dispatchType")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		slot4 = false

		if table.indexof(ActivityClubSPLevelSettingCfg[GuildActivitySPData:GetCurRateID(GuildActivitySPData:GetCurRunActivityID())].dispatch, uv0.catId_) then
			slot4 = true
		end

		if not slot4 then
			ShowTips(string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(GuildActivitySPData:GetCatUnlockLevel(uv0.catId_))))

			return
		end

		if uv0.selectHandler_ ~= nil then
			uv0.selectHandler_(uv0.index_, uv0.nodeId_)
		end
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.SetSelectHandler(slot0, slot1)
	slot0.selectHandler_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.nodeId_ = slot3
	slot0.nodeData_ = GuildActivitySPData:GetNodeData(slot3)
	slot0.nodeCfg_ = ActivityClubSPCfg[slot3]
	slot0.cfg_ = ChipCfg[slot2]
	slot0.catId_ = slot2

	slot0:UpdateView()

	slot0.iconImg_.sprite = ItemTools.getItemSprite(tonumber(GuildActivitySpTools.GetCurCurrencyID(GuildActivitySPData:GetCurMainActivityID(), 1)))
end

function slot0.UpdateView(slot0)
	slot0.energyLabel_.text = slot0.nodeCfg_.token_get
	slot0.nameLabel_.text = slot0.cfg_.suit_name
	slot0.icon_.sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot0.catId_].picture_id)
	slot2, slot3 = GuildActivitySPData:IsCatDispatched(slot0.catId_)

	if slot2 then
		slot4 = ActivityClubSPCfg[slot3]
		slot5 = GuildActivitySPData:GetNodeData(slot3)
		slot0.energyLabel_.text = "+" .. slot4.token_get .. "/"
		slot0.levelLabel_.text = "Lv." .. slot4.level

		slot0.statusController_:SetSelectedState("dispatch")

		slot0.grideName.text = GetTips(GuildActivitySPConst.NodeType[slot4.type])
	else
		slot8 = false

		if table.indexof(ActivityClubSPLevelSettingCfg[GuildActivitySPData:GetCurRateID(GuildActivitySPData:GetCurRunActivityID())].dispatch, slot0.catId_) then
			slot8 = true
		end

		if slot8 then
			slot0.statusController_:SetSelectedState("notdispatched")
		else
			slot0.statusController_:SetSelectedState("lock")

			slot0.lockLabel_.text = string.format(GetTips("ACTIVITY_CLUB_FIGHT_MEMBER_LOCK_TIP"), tostring(GuildActivitySPData:GetCatUnlockLevel(slot0.catId_)))
		end
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
