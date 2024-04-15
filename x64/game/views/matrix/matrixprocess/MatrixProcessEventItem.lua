slot0 = class("MatrixProcessEventItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.index = slot2

	slot0:initUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_clickBtn, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.index)
		end
	end)
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.selectedController_ = ControllerUtil.GetController(slot0.m_controller, "selected")
	slot0.typeController_ = ControllerUtil.GetController(slot0.m_controller, "type")
end

function slot0.Refresh(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.index = slot2

	if slot0.id and MatrixEventCfg[slot0.id] or nil then
		slot4 = slot3.event_type

		slot0.typeController_:SetSelectedIndex(slot4 - 1)

		if slot4 - 1 == 0 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("SHEN_GE")
		elseif slot5 == 1 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("KE_YIN")
		elseif slot5 == 2 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("YAO_CONG")
		elseif slot5 == 3 then
			slot0.m_subName.text = GetTips("JING_YING_ZHAN")
			slot0.m_name.text = GetTips("YAO_CONG")
		elseif slot5 == 4 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("MIAO_MIAO")
		elseif slot5 == 5 then
			slot0.m_subName.text = GetTips("JING_YING_ZHAN")
			slot0.m_name.text = GetTips("MIAO_MIAO")
		elseif slot5 == 6 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif slot5 == 7 then
			slot0.m_subName.text = GetTips("JING_YING_ZHAN")
			slot0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif slot5 == 8 then
			slot0.m_subName.text = GetTips("BOSS_ZHAN")
			slot0.m_name.text = GetTips("E_MENG_TIAO_ZHAN")
		elseif slot5 == 9 then
			slot0.m_subName.text = GetTips("BOSS_ZHAN")
			slot0.m_name.text = GetTips("ZHONG_YAN_TIAO_ZHAN")
		elseif slot5 == 10 then
			slot0.m_subName.text = GetTips("TE_SHU")
			slot0.m_name.text = GetTips("DUO_WEI_SHANG_DIAN")
		elseif slot5 == 11 then
			slot0.m_subName.text = GetTips("TE_SHU")
			slot0.m_name.text = GetTips("JI_YU")
		end

		slot0.m_name.text = GetI18NText(slot3.name)
		slot0.m_subName.text = GetI18NText(slot3.sub_name)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.GetTypeName(slot0, slot1)
	return GetTips("MATRIX_TYPE_NOTE_" .. slot1)
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedIndex(slot1 and 1 or 0)
end

function slot0.GetIndex(slot0)
	return slot0.index
end

return slot0
