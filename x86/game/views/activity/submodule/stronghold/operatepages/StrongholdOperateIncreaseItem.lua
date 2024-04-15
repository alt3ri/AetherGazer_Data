slot0 = class("StrongholdOperateIncreaseItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.node_id = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdIncrease/" .. slot0.node_id)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.node_id, true, uv0)
		end
	end)
end

function slot0.Refresh(slot0, slot1, slot2)
	slot5 = ActivityStrongholdIncreaseCfg[ActivityStrongholdIncreaseCfg.get_id_list_by_skill_id[slot0.node_id][slot1 + 1]]

	if slot1 == 0 then
		slot0.lockController:SetSelectedIndex(1)
	elseif not slot5 then
		slot0.lockController:SetSelectedIndex(2)

		slot0.m_lvLab.text = GetTips("ACTIVITY_STRONGHOLD_SKILL_MAX")
	else
		slot0.lockController:SetSelectedIndex(0)

		slot0.m_lvLab.text = "Lv" .. slot1
	end

	if slot5 and slot5.cost <= slot2 then
		manager.redPoint:SetRedPointIndependent(slot0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.node_id and 1 or 0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

return slot0
