slot0 = class("StrongholdOperateSkillPage", StrongholdOperateBasePage)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.hander_ = slot1
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/VersionUI/XuHeng3rdUI/Stronghold/Operate/StrongholdSkillUI"), slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:Refresh()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.items = {}

	for slot4 = 1, 3 do
		table.insert(slot0.items, StrongholdOperateSkillItem.New(slot0["m_skill" .. slot4], slot4))
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
end

function slot0.Refresh(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.items) do
		slot6:RefreshUI()
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.items) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
