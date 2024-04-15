slot0 = {}
slot1, slot2 = pcall(require, "bit")

if not slot1 then
	slot1, slot2 = pcall(require, "bit32")
end

slot0.dirtyFlagIndex = {
	[RedPointStyle.NORMAL] = slot2.lshift(1, 1),
	[RedPointStyle.SHOW_NEW_TAG] = slot2.lshift(1, 2)
}
slot0.StyleCsharpMap = {
	[RedPointStyle.None] = UIRedPointStyle.None,
	[RedPointStyle.NORMAL] = UIRedPointStyle.Normal,
	[RedPointStyle.SHOW_NEW_TAG] = UIRedPointStyle.New
}
slot0.StyleKeyMap = {}

function slot0.Init(slot0)
	slot0._groupTipDic = {}
	slot0._parentTipDic = {}

	slot0:InitData()
end

function slot0.InitData(slot0)
	slot0._tipDic = {}
	slot0._UIKeyList = {}
end

function slot0.Dispose(slot0)
	slot0._UIKeyList = {}
end

function slot0.GetKeyStyle(slot0, slot1)
	return slot0.StyleKeyMap[slot1] or RedPointStyle.NORMAL
end

function slot0.GetKeyStyleFlag(slot0, slot1)
	return slot0.dirtyFlagIndex[slot0:GetKeyStyle(slot1)] or 0
end

function slot0.ShowRed(slot0, slot1, slot2)
	slot4 = slot1.tProperty or {}

	if slot1.display == nil then
		print("redpoint cant find parent transform")

		return
	end

	if uv0.band(slot0:GetTipFlag(slot2), slot0.dirtyFlagIndex[RedPointStyle.SHOW_NEW_TAG]) > 0 then
		slot0:ChangeRedStyle(slot1, RedPointStyle.SHOW_NEW_TAG, nil, slot2)
	elseif uv0.band(slot5, slot0.dirtyFlagIndex[RedPointStyle.NORMAL]) > 0 then
		slot0:ChangeRedStyle(slot1, RedPointStyle.NORMAL, nil, slot2)
	else
		slot0:ChangeRedStyle(slot1, RedPointStyle.None, nil, slot2)
	end
end

function slot0.PreShowRed(slot0, slot1, slot2)
	if not slot2 then
		return RedPointStyle.None
	end

	if slot1.banNew and slot2 == RedPointStyle.SHOW_NEW_TAG then
		return RedPointStyle.NORMAL
	end

	return slot2
end

function slot0.ChangeRedStyle(slot0, slot1, slot2, slot3, slot4, slot5)
	slot7 = slot1.tProperty or {}

	if isNil(slot1.display) then
		Debug.LogError("直接操作红点时出错<transform为空>,尝试显示Key\n(请检查transform为空,或者未解绑红点): " .. (slot4 or "nil"))

		return
	end

	slot9 = nil

	if not slot6:Find("notice_img") then
		if Asset.Load("Widget/System/Com_dynamic/notice_img") == nil then
			print("redpoint cant find current CommonNotice prefab")

			return
		end

		slot8 = Object.Instantiate(slot10, slot6)
		slot9 = slot8:GetComponent(typeof(UIRedPoint))
		slot8.name = "notice_img"
	else
		slot9 = slot8:GetComponent(typeof(UIRedPoint))
	end

	if slot9 then
		slot9:ShowRed(slot0.StyleCsharpMap[slot0:PreShowRed(slot7, slot2)])
		slot9:SetDebugName(slot4 or "NULL_KEY")

		slot11 = slot7.y
		slot12 = slot7.scaleX
		slot13 = slot7.scaleY

		if slot7.x and slot11 then
			slot9:SetPosition(slot10, slot11)
		else
			if slot10 then
				slot9:SetPositionAxis(slot10, 1)
			end

			if slot11 then
				slot9:SetPositionAxis(slot11, 2)
			end
		end

		if slot12 and slot13 then
			slot9:SetScale(slot12, slot13)
		else
			if slot12 then
				slot9:SetScale(slot12, 1)
			end

			if slot13 then
				slot9:SetScale(slot13, 2)
			end
		end
	else
		Debug.LogError("是红点,但是没有绑定UIRePoint " .. slot6.name)

		if slot5 then
			slot8.gameObject:SetActive(true)
		else
			slot8.gameObject:SetActive(false)
		end
	end
end

function slot0.SetKeyStyle(slot0, slot1, slot2)
	slot0.StyleKeyMap[slot1] = slot2 or RedPointStyle.NORMAL
end

function slot0.setTip(slot0, slot1, slot2, slot3)
	slot4 = slot1

	if slot3 and slot3 ~= RedPointStyle.None and slot3 ~= RedPointStyle.NORMAL then
		slot0:appendToGroup(slot1, string.format("%s_REDSTYLE_DECORATOR_%s", slot1, slot3), slot3)
	end

	slot5 = 0

	if slot2 == (slot0._tipDic[slot4] == nil and 0 or slot0._tipDic[slot4]) then
		return
	end

	slot0._tipDic[slot4] = slot2

	slot0:updateKey(slot4)
end

function slot0.getTipValue(slot0, slot1)
	slot2 = slot0._tipDic[slot1] or 0

	if slot0._groupTipDic[slot1] then
		for slot7, slot8 in pairs(slot3) do
			slot2 = slot2 + slot0:getTipValue(slot8)
		end
	end

	return slot2
end

function slot0.GetTipFlag(slot0, slot1)
	slot3 = 0

	if (slot0._tipDic[slot1] or 0) > 0 then
		slot3 = slot0:GetKeyStyleFlag(slot1)
	end

	if slot0._groupTipDic[slot1] then
		for slot8, slot9 in pairs(slot4) do
			slot3 = uv0.bor(slot3, slot0:GetTipFlag(slot9))
		end
	end

	return slot3
end

function slot0.getchildKeys(slot0, slot1)
	return slot0._groupTipDic[slot1]
end

function slot0.getTipBoolean(slot0, slot1)
	if slot0._tipDic[slot1] and slot0._tipDic[slot1] > 0 then
		return true
	end

	if slot0._groupTipDic[slot1] then
		for slot6, slot7 in pairs(slot2) do
			if slot0:getTipBoolean(slot7) == true then
				return true
			end
		end
	end

	return false
end

function slot0.addGroup(slot0, slot1, slot2, slot3)
	if slot3 == nil then
		slot3 = false
	end

	if slot0._groupTipDic[slot1] == nil then
		slot0._groupTipDic[slot1] = slot2

		for slot7, slot8 in ipairs(slot2) do
			slot0._parentTipDic[slot8] = slot0._parentTipDic[slot8] or {}

			table.insert(slot0._parentTipDic[slot8], slot1)
		end
	else
		if slot3 == true then
			if slot2 then
				for slot7, slot8 in ipairs(slot2) do
					slot0._parentTipDic[slot8] = slot0._parentTipDic[slot8] or {}

					if slot0:IsInTable(slot0._parentTipDic[slot8], slot1) == true then
						table.remove(slot0._parentTipDic[slot8], slot7)
					end
				end
			end

			slot0._groupTipDic[slot1] = {}
		end

		slot4 = slot0._groupTipDic[slot1]

		for slot8, slot9 in pairs(slot2) do
			if slot0:IsInTable(slot4, slot9) == false then
				table.insert(slot4, slot9)
			end
		end

		for slot8, slot9 in ipairs(slot2) do
			slot0._parentTipDic[slot9] = slot0._parentTipDic[slot9] or {}

			if slot0:IsInTable(slot0._parentTipDic[slot9], slot1) == false then
				table.insert(slot0._parentTipDic[slot9], slot1)
			end
		end
	end

	slot0:updateRedPoint(slot1)
end

function slot0.appendToGroup(slot0, slot1, slot2, slot3)
	slot4 = slot0._groupTipDic[slot1] or {}
	slot0._groupTipDic[slot1] = slot4

	if not slot0:IsInTable(slot4, slot2) then
		table.insert(slot4, slot2)

		slot0._parentTipDic[slot2] = slot0._parentTipDic[slot2] or {}

		table.insert(slot0._parentTipDic[slot2], slot1)

		if slot3 then
			slot0:SetKeyStyle(slot2, slot3)
		end
	end
end

function slot0.delGroup(slot0, slot1, slot2)
	if slot0._groupTipDic[slot1] == nil then
		return
	end

	slot3 = slot0._groupTipDic[slot1]

	for slot7, slot8 in pairs(slot2) do
		if slot0:IsInTable(slot3, slot8) then
			table.remove(slot3, slot7)
		end
	end

	for slot7, slot8 in ipairs(slot2) do
		slot0._parentTipDic[slot8] = slot0._parentTipDic[slot8] or {}

		if slot0:IsInTable(slot0._parentTipDic[slot8], slot1) then
			table.remove(slot0._parentTipDic[slot8], slot7)
		end
	end

	slot0:updateRedPoint(slot1)
end

function slot0.updateKey(slot0, slot1)
	slot0:updateRedPoint(slot1)

	for slot6, slot7 in ipairs(slot0._parentTipDic[slot1] or {}) do
		slot0:updateKey(slot7)
	end

	manager.notify:Invoke(RED_POINT_UPDATE, slot1)
end

function slot0.updateRedPoint(slot0, slot1)
	if slot0._UIKeyList[slot1] ~= nil then
		for slot6, slot7 in pairs(slot0._UIKeyList[slot1]) do
			slot0:ShowRed(slot7, slot1)
		end
	end
end

function slot0.bindUIandKey(slot0, slot1, slot2, slot3)
	if slot1 == nil then
		Debug.LogError("红点绑定Key时出错<transform为空>: " .. slot2)

		return
	end

	slot0:unbindUIandKey(slot1)

	slot4 = {}

	if slot0._UIKeyList[slot2] == nil then
		table.insert(slot4, {
			display = slot1,
			tProperty = slot3
		})

		slot0._UIKeyList[slot2] = slot4
	else
		table.insert(slot0._UIKeyList[slot2], {
			display = slot1,
			tProperty = slot3
		})
	end

	slot0:updateRedPoint(slot2)
end

function slot0.unbindUIandKey(slot0, slot1, slot2)
	if slot1 == nil then
		return
	end

	if slot2 then
		slot3 = -1

		if slot0._UIKeyList[slot2] then
			for slot8, slot9 in pairs(slot4) do
				if slot9.display == slot1 then
					slot3 = slot8

					break
				end
			end

			if slot3 ~= -1 then
				slot0:ShowRed(slot4[slot3], slot2)
				table.remove(slot4, slot3)
			end
		else
			print("unbindUIandKey key is not exist! key = " .. slot2)
		end
	else
		for slot6, slot7 in pairs(slot0._UIKeyList) do
			slot8 = -1

			for slot12, slot13 in pairs(slot7) do
				if slot13.display == slot1 then
					slot8 = slot12

					break
				end
			end

			if slot8 ~= -1 then
				slot0:ShowRed(slot7[slot8], slot2)
				table.remove(slot7, slot8)

				break
			end
		end
	end
end

function slot0.IsInTable(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot1) do
		if slot7 == slot2 then
			return true, slot6
		end
	end

	return false
end

function slot0.GetRedGraphWithKey(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = {}

	slot0:FindRedRoot(slot1, slot2)
	slot0:GetKeyGraph(slot2[1] or slot1, {
		keysList = {},
		keysVis = {}
	})

	for slot11 = 1, #slot4 do
		table.insert({}, {})
	end

	for slot11, slot12 in ipairs(slot4) do
		if slot0._groupTipDic[slot12.key] then
			for slot17, slot18 in pairs(slot13) do
				table.insert(slot5[slot6[slot12.key]], slot6[slot18] - 1)
			end
		end
	end

	Debug.LogError("keysGraph如下: " .. table.toString(slot5))
	Debug.LogError("所有的Keys: " .. table.toString(slot4))

	return {
		rootIdx = 0,
		status = true,
		edges = slot5,
		nodes = slot4,
		selectNode = slot6[slot1] - 1
	}
end

function slot0.FindRedRoot(slot0, slot1, slot2)
	slot3 = slot1

	if not slot0._parentTipDic[slot1] or #slot4 == 0 then
		slot2[slot1] = true
	else
		for slot8, slot9 in ipairs(slot0._parentTipDic[slot1]) do
			slot0:FindRedRoot(slot9, slot2)
		end
	end
end

function slot0.GetKeyGraph(slot0, slot1, slot2)
	if not slot2.keysVis[slot1] then
		table.insert(slot2.keysList, {
			key = tostring(slot1),
			value = slot0:getTipValue(slot1)
		})

		slot2.keysVis[slot1] = #slot2.keysList

		if slot0._groupTipDic[slot1] then
			for slot7, slot8 in pairs(slot3) do
				slot0:GetKeyGraph(slot8, slot2)
			end
		end
	end
end

function slot0.GetAllKey(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._groupTipDic) do
		table.insert(slot1, slot5)
	end

	return slot1
end

return slot0
