slot0 = singletonClass("BulletinData")
slot1 = {}
slot2 = {}
slot3 = false
slot4, slot5 = nil
slot6 = false

Timer.New(function ()
	for slot3, slot4 in pairs(BulletinData.GetBulletinPageList()) do
		if slot4.endTime < manager.time:GetServerTime() then
			BulletinAction.BulletinDelete(slot4.id)
		end
	end
end, 1, -1):Start()

function slot0.Init()
	uv0 = {}
	uv1 = {}
	uv2 = false
end

function slot0.constructImage(slot0)
	return {
		itemType = slot0.content_type,
		spriteUrl = slot0.image,
		text = slot0.text,
		event = {
			slot0.event_type,
			slot0.event_arg
		}
	}
end

function slot0.constructText(slot0)
	return {
		itemType = slot0.content_type,
		text = slot0.text
	}
end

function slot0.constructTitle(slot0)
	return {
		itemType = slot0.content_type,
		text = string.match(slot0.text, "<title>(%a+)</title>")
	}
end

slot7 = {
	CONTENT = 2,
	TITLE = 1
}

function slot0.constructBulletin(slot0)
	slot2 = {
		id = slot0.id,
		type = slot0.type,
		name = slot0.title,
		startTime = slot0.start_timestamp,
		endTime = slot0.end_timestamp,
		index = slot0.index,
		content = uv0.constructSingleBulletin(slot0.content),
		i18n_info_name = {},
		i18n_info_content = {}
	}

	for slot6, slot7 in pairs(slot0.i18n_info) do
		if slot7.type == uv1.TITLE then
			slot2.i18n_info_name[slot7.language] = slot7.string
		elseif slot7.type == uv1.CONTENT then
			slot2.i18n_info_content[slot7.language] = uv0.constructSingleBulletin(slot7.content)
		end
	end

	return slot2
end

function slot0.constructSingleBulletin(slot0)
	for slot5, slot6 in ipairs(slot0) do
		if slot6.content_type == 1 then
			-- Nothing
		elseif slot6.content_type == 2 then
			if string.find(slot6.text, "<title>") then
				slot6.content_type = 4
				slot1[slot5] = uv0.constructTitle(slot6)
			else
				slot1[slot5] = uv0.constructText(slot6)
			end
		end
	end

	return {
		[slot5] = uv0.constructImage(slot6)
	}
end

function slot0.constructBulletionID(slot0, slot1)
	uv0[slot0] = uv0[slot0] or {}

	for slot5, slot6 in pairs(uv0[slot0]) do
		if slot6 == slot1 then
			return
		end
	end

	for slot5, slot6 in ipairs(uv0[slot0]) do
		if uv1[slot6].index < uv1[slot1].index then
			table.insert(uv0[slot0], slot5, slot1)

			return
		end
	end

	table.insert(uv0[slot0], slot1)
end

function slot0.insertBulletin(slot0)
	for slot4, slot5 in ipairs(uv0) do
		if slot5.id == slot0.id then
			uv0[slot0.id] = uv1.constructBulletin(slot0)

			return
		end
	end

	uv0[slot0.id] = uv1.constructBulletin(slot0)
end

function slot0.refreshBulletin(slot0)
	for slot4, slot5 in ipairs(slot0.announcement_list) do
		uv0.insertBulletin(slot5)
		uv0.constructBulletionID(slot5.type, slot5.id)
	end

	manager.notify:Invoke(BULLETIN_LIST_UPDATE)
end

function slot0.deleteBulletin(slot0)
	uv0[slot0.id] = nil

	for slot5, slot6 in pairs(uv1) do
		for slot10, slot11 in pairs(slot6) do
			if slot11 == slot1 then
				uv1[slot5][slot10] = nil

				break
			end
		end
	end

	manager.notify:Invoke(BULLETIN_LIST_UPDATE)
	manager.notify:Invoke(BULLETIN_DELETE, slot1)
end

function slot0.GetBulletinIDList()
	return uv0
end

function slot0.GetBulletinPageList()
	return uv0
end

function slot0.GetReadFlag()
	return uv0
end

function slot0.SetReadFlag(slot0)
	uv0 = slot0
end

function slot0.SetReadFlagById(slot0)
	saveData("bulletin", "bulletin_" .. slot0, "true")
end

function slot0.GetIslogin()
	return uv0
end

function slot0.SetIslogin(slot0)
	uv0 = slot0
end

function slot0.SetCacheString(slot0, slot1)
	uv0 = slot0
	uv1 = slot1
end

function slot0.GetCurCacheStringAndID()
	return uv0, uv1
end

function slot0.GetCacheStringIsShowByID(slot0)
	if table.indexof(getData("BulletinData", "Id") or {
		-1
	}, slot0) then
		if (getData("BulletinData", "Num") or {
			-1
		})[slot3] > 2 then
			return true
		else
			return false
		end
	else
		return false
	end
end

function slot0.SetCacheStringIsShowByID(slot0)
	slot2 = getData("BulletinData", "Num") or {
		-1
	}

	if table.indexof(getData("BulletinData", "Id") or {
		-1
	}, slot0) then
		slot2[slot3] = slot2[slot3] + 1
	else
		table.insert(slot1, slot0)
		table.insert(slot2, 1)
	end

	saveData("BulletinData", "Id", slot1)
	saveData("BulletinData", "Num", slot2)
end

function slot0.OnLogout()
	uv0 = false
	uv1 = nil
	uv2 = nil
end

return slot0
