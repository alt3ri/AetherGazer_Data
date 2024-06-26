slot0 = class("BulletinContentView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.bulletinItem_ = {}

	slot0:InitUI()
end

function slot0.SetBulletInId(slot0, slot1)
	slot0:SetViewProp("bulletinID", slot1)
	slot0:RefreshContent()
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	for slot4 = #slot0.bulletinItem_, 1, -1 do
		slot0.bulletinItem_[slot4]:Dispose()

		slot0.bulletinItem_[slot4] = nil
	end

	slot0.bulletinItem_ = nil
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemParent_ = slot0.gameObject_
end

function slot0.RefreshContent(slot0)
	SetActive(slot0.itemParent_.gameObject, false)

	for slot4 = #slot0.bulletinItem_, 1, -1 do
		slot0.bulletinItem_[slot4]:Dispose()

		slot0.bulletinItem_[slot4] = nil
	end

	slot5 = slot0
	slot4 = slot0.GetViewProp

	for slot4, slot5 in ipairs(slot0:GetContent(slot4(slot5, "bulletinID"))) do
		if slot5.itemType == 1 then
			table.insert(slot0.bulletinItem_, BulletinImageItemView.New(Object.Instantiate(slot0.imageItem_, slot0.itemParent_.transform), slot0:GetViewProp("bulletinID"), slot4))
		elseif slot5.itemType == 2 then
			table.insert(slot0.bulletinItem_, BulletinTextItemView.New(Object.Instantiate(slot0.textItem_, slot0.itemParent_.transform), slot0:GetViewProp("bulletinID"), slot4))
		elseif slot5.itemType == 4 then
			table.insert(slot0.bulletinItem_, BulletinTitleItemView.New(Object.Instantiate(slot0.titleItem_, slot0.itemParent_.transform), slot0:GetViewProp("bulletinID"), slot4))
		end
	end

	if slot0.timer_ ~= nil then
		slot0.timer_:Stop()
	end

	slot0.timer_ = TimeTools.StartAfterSeconds(0.1, function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.itemParent_.transform)
		SetActive(uv0.itemParent_.gameObject, true)
	end, {})
end

function slot0.SwitchBulletinPage(slot0, slot1)
	slot0:SetViewProp("bulletinID", slot1)
	slot0:RefreshContent()
end

function slot0.GetContent(slot0, slot1)
	slot3 = SettingData:GetCurrentLanguage()

	for slot7, slot8 in pairs(BulletinData.GetBulletinPageList()) do
		if slot8.id == slot1 and manager.time:GetServerTime() < slot8.endTime then
			if slot3 and slot8.i18n_info_content[slot3] then
				return slot8.i18n_info_content[slot3]
			else
				return slot8.content
			end
		end
	end

	return {}
end

return slot0
