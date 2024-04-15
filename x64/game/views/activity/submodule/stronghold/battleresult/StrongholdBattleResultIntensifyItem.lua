slot0 = class("StrongholdBattleResultIntensifyItem", ReduxView)

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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_btn, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.id)
		end
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.id = slot1
	slot2 = ActivityStrongholdArtifactCfg[slot1]
	slot0.m_icon.sprite = getSpriteWithoutAtlas(slot2.icon)
	slot0.m_name.text = slot2.name
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

return slot0
