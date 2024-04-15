slot0 = class("BigMonthCardPopItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItemView.New(slot0.commonitemGo_)
end

function slot0.RefreshData(slot0, slot1)
	slot0.commonItem_:SetData(slot1)
end

function slot0.SetText(slot0, slot1)
	slot0.text_.text = slot1
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()
	slot0:RemoveAllListeners()

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	slot0.super.Dispose(slot0)
end

return slot0
