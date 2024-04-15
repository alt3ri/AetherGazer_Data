slot0 = class("FragmentExchangeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem = CommonItemView.New(slot0.commonItem_, true)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.number = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	CommonTools.SetCommonData(slot0.commonItem, slot0.data)

	slot0.numTxt_.text = "x " .. slot0.number
	slot0.nameTxt_.text = ItemTools.getItemName(slot0.data.id)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
