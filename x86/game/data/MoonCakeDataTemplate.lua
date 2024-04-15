MoonDelegateDataTemplate = class("MoonDelegateDataTemplate")

function MoonDelegateDataTemplate.Ctor(slot0, slot1)
	slot0:UpdateData(slot1)
end

function MoonDelegateDataTemplate.UpdateData(slot0, slot1)
	slot0.delegateID = slot1.entrust_id
	slot0.targetID = slot1.item_id
	slot0.timestamp = slot1.timestamp
	slot0.isReceived = slot1.is_receive == 1
	slot0.uid = slot1.user_id
	slot0.submiter_uid = slot1.present_id
	slot0.isCompleted = slot0.submiter_uid and slot0.submiter_uid ~= "0"
end

function MoonDelegateDataTemplate.UpdateUserInfo(slot0, slot1)
	slot0.nick = slot1.base_info.nick
	slot0.portrait = slot1.base_info.icon
	slot0.frame = slot1.base_info.icon_frame
	slot0.level = slot1.level
end

MoonPartyUserDataTemplate = class("MoonPartyUserDataTemplate")

function MoonPartyUserDataTemplate.Ctor(slot0, slot1)
	slot0:UpdateData(slot1)
end

function MoonPartyUserDataTemplate.UpdateData(slot0, slot1)
	slot0.uid = slot1.user_id
	slot0.isVisited = slot1.is_visit == 1
end

function MoonPartyUserDataTemplate.UpdateUserInfo(slot0, slot1)
	slot0.nick = slot1.base_info.nick
	slot0.portrait = slot1.base_info.icon
	slot0.frame = slot1.base_info.icon_frame
	slot0.level = slot1.level
end

MoonPartyDataTemplate = class("MoonPartyDataTemplate")

function MoonPartyDataTemplate.Ctor(slot0, slot1)
	slot0:UpdateData(slot1)
end

function MoonPartyDataTemplate.UpdateData(slot0, slot1)
	slot0.partyType = slot1.open_type
	slot0.isOpened = slot0.partyType ~= 0
	slot0.visitNum = slot1.visit_num
	slot0.openTime = slot1.open_time
end

function MoonPartyDataTemplate.Reset(slot0)
	slot0.partyType = 0
	slot0.isOpened = false
	slot0.visitNum = 0
	slot0.closeTiem = 0
end
