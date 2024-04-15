slot0 = class("PlotTalkItem", ReduxView)

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
	slot0:AddBtnListener(slot0.talkBtn_, nil, function ()
		manager.story:StartStoryById(uv0.storyId_, function ()
			manager.ui:SetMainCamera("heroSkin")
		end)

		if uv0.callBack_ then
			uv0.callBack_()
		end
	end)
end

function slot0.SetCallBack(slot0, slot1)
	slot0.callBack_ = slot1
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.titleText_.text = slot1
	slot0.storyId_ = slot2
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.descRect_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.rect_)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
