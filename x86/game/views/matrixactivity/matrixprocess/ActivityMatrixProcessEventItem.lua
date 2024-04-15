slot0 = class("ActivityMatrixProcessEventItem", MatrixProcessEventItem)

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.index = slot2

	if slot0.id and ActivityMatrixEventTemplateCfg[slot0.id] or nil then
		slot5 = slot4.event_type

		slot0.typeController_:SetSelectedIndex(slot5 - 1)

		if (MatrixConst.EVENT_TYPE.CURRENCY == slot5 or MatrixConst.EVENT_TYPE.CURRENCY_ELITE == slot5) and ItemCfg[ActivityMatrixTools.GetCoinItem(slot3)] then
			slot0.m_name.text = ItemTools.getItemName(slot6)
		end

		if slot5 - 1 == 0 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("SHEN_GE")
		elseif slot6 == 1 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("KE_YIN")
		elseif slot6 == 2 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("YAO_CONG")
		elseif slot6 == 3 then
			slot0.m_subName.text = GetTips("JING_YING_ZHAN")
			slot0.m_name.text = GetTips("YAO_CONG")
		elseif slot6 == 4 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("MIAO_MIAO")
		elseif slot6 == 5 then
			slot0.m_subName.text = GetTips("JING_YING_ZHAN")
			slot0.m_name.text = GetTips("MIAO_MIAO")
		elseif slot6 == 6 then
			slot0.m_subName.text = GetTips("NORMAL_BATTLE")
			slot0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif slot6 == 7 then
			slot0.m_subName.text = GetTips("JING_YING_ZHAN")
			slot0.m_name.text = GetTips("JI_YI_ZHEN_BAO")
		elseif slot6 == 8 then
			slot0.m_subName.text = GetTips("BOSS_ZHAN")
			slot0.m_name.text = GetTips("E_MENG_TIAO_ZHAN")
		elseif slot6 == 9 then
			slot0.m_subName.text = GetTips("BOSS_ZHAN")
			slot0.m_name.text = GetTips("ZHONG_YAN_TIAO_ZHAN")
		elseif slot6 == 10 then
			slot0.m_subName.text = GetTips("TE_SHU")
			slot0.m_name.text = GetTips("DUO_WEI_SHANG_DIAN")
		elseif slot6 == 11 then
			slot0.m_subName.text = GetTips("TE_SHU")
			slot0.m_name.text = GetTips("JI_YU")
		end
	end
end

return slot0
