slot0 = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.hander_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdIncreaseUI"), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:Refresh()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.node_list = {}

	for slot5, slot6 in pairs(ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id) do
		slot8 = StrongholdOperateIncreaseItem.New(slot0.m_nodes:Find(tostring(slot5)), slot5)

		slot8:RegistCallBack(handler(slot0, slot0.SetSelectNode))

		slot0.node_list[slot5] = slot8
	end

	slot0.stateConotroller = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.showConotroller = ControllerUtil.GetController(slot0.transform_, "show")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_unlockBtn, nil, function ()
		if uv0.curNodeId == nil then
			return
		end

		StrongholdAction.QueryUpgradeIncrease(uv0.activity_id, uv0.curNodeId)
	end)
	slot0:AddBtnListener(slot0.m_upgradeBtn, nil, function ()
		if uv0.curNodeId == nil then
			return
		end

		StrongholdAction.QueryUpgradeIncrease(uv0.activity_id, uv0.curNodeId)
	end)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:SetSelectNode(nil)
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.activity_id = slot1

	slot0:SetSelectNode(nil, false)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.all_level, slot0.all_poit = StrongholdData:GetStrongholdLevelAndIncreasePoint(slot0.activity_id)
	slot0.m_allLvLab.text = slot0.all_level
	slot0.use_point = StrongholdData:GetUsePoint(slot0.activity_id)
	slot5 = GetTips("ACTIVITY_STRONGHOLD_POINT_LEFT")
	slot6 = slot0.all_poit - slot0.use_point
	slot0.m_point.text = string.format(slot5, slot6)

	for slot5, slot6 in pairs(slot0.node_list) do
		slot6:Refresh(StrongholdData:GetIncreaseLevel(slot0.activity_id, slot6.node_id), slot1)
	end
end

function slot0.SetSelectNode(slot0, slot1, slot2, slot3)
	slot0.curNodeId = slot1

	for slot7, slot8 in pairs(slot0.node_list) do
		slot8:SetSelect(slot0.curNodeId)
	end

	if slot0.curNodeId == nil then
		slot0.showConotroller:SetSelectedIndex(0)

		slot0.m_scrollCom.movementType = ScrollRect.MovementType.Elastic

		slot0:RemoveTween()

		return
	end

	slot0:RemoveTween()

	slot0.tween_ = LeanTween.moveLocal(slot0.m_scrollContent.gameObject, Vector3.New(-slot0.m_scrollContent.transform:InverseTransformPoint(slot3.transform_:TransformPoint(Vector3(0, 0, 0))).x, 0, 0), 0.2)
	slot0.m_scrollCom.movementType = ScrollRect.MovementType.Unrestricted

	slot0.showConotroller:SetSelectedIndex(1)
	slot0:RefreshRightInfo()

	if slot2 then
		slot0.m_animator:Play("Fx_messagebg_cx_01", 0, 0)
	end
end

function slot0.RefreshRightInfo(slot0)
	if StrongholdData:GetIncreaseLevel(slot0.activity_id, slot0.curNodeId) == 0 then
		slot0.stateConotroller:SetSelectedIndex(0)

		slot4 = ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[slot0.curNodeId][1]]
		slot0.m_name.text = slot4.skill_name
		slot0.m_des.text = slot0:GetSkillDes(slot4)
		slot0.m_lvLab.text = "Lv" .. slot4.skill_level
		slot0.m_nextLvDes.text = ""
		slot0.m_costLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_COST"), slot4.cost)
		slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. slot4.skill_id)
	elseif slot2 >= #slot1 then
		slot0.stateConotroller:SetSelectedIndex(2)

		slot4 = ActivityStrongholdIncreaseCfg[slot1[#slot1]]
		slot0.m_name.text = slot4.skill_name
		slot0.m_des.text = slot0:GetSkillDes(slot4)
		slot0.m_lvLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
		slot0.m_nextLvDes.text = ""
		slot0.m_costLab.text = ""
		slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. slot4.skill_id)
	else
		slot0.stateConotroller:SetSelectedIndex(1)

		slot5 = ActivityStrongholdIncreaseCfg[slot1[slot2]]
		slot6 = ActivityStrongholdIncreaseCfg[slot1[slot2 + 1]]
		slot0.m_name.text = slot5.skill_name
		slot0.m_des.text = slot0:GetSkillDes(slot5)
		slot0.m_lvLab.text = "Lv" .. slot5.skill_level
		slot0.m_nextLvDes.text = string.format(GetTips("ACTIVITY_STRONGHOLD_INCREASE_NEXT_LV"), "", slot0:GetSkillDes(slot6))
		slot0.m_costLab.text = string.format(GetTips("ACTIVITY_STRONGHOLD_POINT_COST"), slot6.cost)
		slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. slot5.skill_id)
	end
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil)
		LeanTween.cancel(slot0.m_scrollContent)

		slot0.tween_ = nil
	end
end

function slot0.GetSkillDes(slot0, slot1)
	if slot1.effect_type == 1 then
		return getAffixDesc(slot1.effect_params)
	elseif slot1.effect_type == 2 then
		return string.format(GetTips("ACTIVITY_STRONGHOLD_INCREASE_REVIVAL"), slot1.effect_params[1])
	else
		rteurn("")
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.node_list) do
		slot5:Dispose()
	end

	slot0:RemoveTween()

	slot0.node_list = {}

	uv0.super.Dispose(slot0)
end

function slot0.OnStrongholdUpgradeIncrease(slot0)
	slot0:RefreshUI()
	slot0:RefreshRightInfo()
end

return slot0
