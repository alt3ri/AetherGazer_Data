slot0 = class("IlluEnemyFiles", ReduxView)
slot1 = {
	7,
	8,
	6
}
slot2 = true

function slot0.UIName(slot0)
	return "Widget/System/IllustratedHandbook/IlluEnemyUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scroll_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, IlluEnemyFilesItem)
	slot0.btn1Controller = ControllerUtil.GetController(slot0.btn1trs_, "name")
	slot0.btn2Controller = ControllerUtil.GetController(slot0.btn2trs_, "name")
	slot0.btn3Controller = ControllerUtil.GetController(slot0.btn3trs_, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_1, nil, function ()
		uv0:RefreshUI(1)

		uv0.params_.index = 1
	end)
	slot0:AddBtnListener(slot0.btn_2, nil, function ()
		uv0:RefreshUI(2)

		uv0.params_.index = 2
	end)
	slot0:AddBtnListener(slot0.btn_3, nil, function ()
		uv0:RefreshUI(3)

		uv0.params_.index = 3
	end)
end

function slot0.UpdateDate(slot0, slot1)
	slot0.itemList_ = {}

	if MonsterCfg.get_id_list_by_race[uv0[slot1]] then
		slot5 = uv0[slot1]

		for slot5, slot6 in pairs(MonsterCfg.get_id_list_by_race[slot5]) do
			if CollectMonsterCfg[slot6].hide == 0 then
				table.insert(slot0.itemList_, {
					id = slot6,
					name = GetMonsterName({
						slot6
					})
				})
			elseif CollectMonsterCfg[slot6].hide == 2 then
				-- Nothing
			elseif IllustratedData:GetEnemyInfo()[slot6] then
				table.insert(slot0.itemList_, {
					id = slot6,
					name = GetMonsterName({
						slot6
					})
				})
			end
		end
	end
end

function slot0.RefreshNum(slot0, slot1)
	slot2 = nil
	slot2 = not MonsterCfg.get_id_list_by_race[uv0[slot1]] and 0 or #MonsterCfg.get_id_list_by_race[uv0[slot1]]
	slot3 = IllustratedData:GetEnemyInfo()
	slot4 = 0
	slot5 = 0

	if MonsterCfg.get_id_list_by_race[uv0[slot1]] then
		slot9 = uv0[slot1]

		for slot9, slot10 in pairs(MonsterCfg.get_id_list_by_race[slot9]) do
			if slot3[slot10] then
				slot4 = slot4 + 1
			end

			if not slot3[slot10] and CollectMonsterCfg[slot10].hide == 1 then
				slot5 = slot5 + 1
			end
		end
	end

	slot0.collectnumText_.text = slot4 .. "/" .. slot2 - slot5
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.selectType_

	slot2:RefreshUI(slot0.itemList_[slot1])
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0:UpdateDate(slot1)

	if slot2 then
		if slot0.params_.scrollPos_ then
			slot0.scroll_:StartScrollByPosition(#slot0.itemList_, slot0.params_.scrollPos_)
		else
			slot0.scroll_:StartScroll(#slot0.itemList_)
		end
	else
		slot0.scroll_:StartScroll(#slot0.itemList_)
	end

	slot0:RefreshNum(slot1)
	slot0.btn1Controller:SetSelectedIndex(slot1 == 1 and 0 or 1)
	slot0.btn2Controller:SetSelectedIndex(slot1 == 2 and 0 or 1)
	slot0.btn3Controller:SetSelectedIndex(slot1 == 3 and 0 or 1)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.params_.index = slot0.params_.index or 1

	slot0:RefreshUI(slot0.params_.index, true)
	manager.redPoint:bindUIandKey(slot0.btn1trs_, RedPointConst["ILUU_ENEMY" .. uv0[1]])
	manager.redPoint:bindUIandKey(slot0.btn2trs_, RedPointConst["ILUU_ENEMY" .. uv0[2]])
	manager.redPoint:bindUIandKey(slot0.btn3trs_, RedPointConst["ILUU_ENEMY" .. uv0[3]])
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.btn1trs_, RedPointConst["ILUU_ENEMY" .. uv0[1]])
	manager.redPoint:unbindUIandKey(slot0.btn2trs_, RedPointConst["ILUU_ENEMY" .. uv0[2]])
	manager.redPoint:unbindUIandKey(slot0.btn3trs_, RedPointConst["ILUU_ENEMY" .. uv0[3]])

	slot0.params_.scrollPos_ = slot0.scroll_:GetScrolledPosition()
end

function slot0.Dispose(slot0)
	slot0.scroll_:Dispose()

	slot0.scroll_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
