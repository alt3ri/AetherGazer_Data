slot0 = class("HeroTrammelsNetPartnerItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.hero_id)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.hero_id = slot1
	slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot1)

	slot0.selectController:SetSelectedIndex(slot1 == slot2 and 1 or 0)

	if ArchiveTools.GetRelationConfig(slot3, slot1) ~= nil and slot4.story_id ~= 0 and not ArchiveData:GetRelationStoryRead(slot4.id) and IsConditionAchieved(slot4.story_condtion_id, {
		heroId = slot0.hero_id
	}) then
		manager.redPoint:SetRedPointIndependent(slot0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
