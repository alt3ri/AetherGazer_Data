slot0 = class("BulletinTextItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:SetViewProp("bulletinID", slot2)
	slot0:SetViewProp("contentIndex", slot3)
	slot0:InitUI()
	slot0:AddListeners()
	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0.richText_ = slot0:FindCom("RichText", "")
end

function slot0.AddListeners(slot0)
	slot0.richText_:AddListener(function (slot0, slot1)
		if slot0 == "1" then
			BulletinAction.OpenOperationUrl(slot1)
		elseif slot0 == "2" then
			slot3 = {}

			for slot7, slot8 in ipairs(string.split(slot1, ",")) do
				table.insert(slot3, tonumber(slot8) or slot8)
			end

			JumpTools.JumpToPage2(slot3)
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.richText_:RemoveAllListeners()
end

function slot0.RefreshUI(slot0)
	slot0.richText_.text = GetI18NText(slot0:GetContent(slot0:GetViewProp("bulletinID"), slot0:GetViewProp("contentIndex")).text)

	SetActive(slot0.gameObject_, true)
end

function slot0.GetContent(slot0, slot1, slot2)
	slot3 = SettingData:GetCurrentLanguage()

	for slot7, slot8 in pairs(BulletinData.GetBulletinPageList()) do
		if slot8.id == slot1 then
			if slot3 and slot8.i18n_info_content[slot3] then
				return slot8.i18n_info_content[slot3][slot2]
			else
				return slot8.content[slot2]
			end
		end
	end
end

return slot0
