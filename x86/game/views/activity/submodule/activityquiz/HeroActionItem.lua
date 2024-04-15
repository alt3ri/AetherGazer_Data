slot0 = class("HeroActionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.buttonItem_, nil, function ()
		manager.notify:CallUpdateFunc(ACTIVITY_QUIZ_SEND_ACTION, uv0.act_)
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.Refresh(slot0, slot1)
	slot0.act_ = slot1
	slot0.imageIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/motionIcon/" .. slot0.act_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
