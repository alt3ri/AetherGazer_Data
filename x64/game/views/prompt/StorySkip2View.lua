slot0 = class("StorySkip2View", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

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
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if uv0.handler_ then
			uv0.handler_()

			uv0.handler_ = nil
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		SetActive(uv0.gameObject_, false)

		if uv0.handler_ then
			uv0.handler_(true)

			uv0.handler_ = nil
		end
	end)
end

function slot0.SetCallback(slot0, slot1)
	slot0.handler_ = slot1
end

function slot0.SetContentTitle(slot0, slot1, slot2)
	slot0.content_ = slot2
	slot0.title_ = slot1

	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0.titleText_.text = GetI18NText(slot0.title_) or ""
	slot0.contentText_.text = slot0.content_ or ""
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
