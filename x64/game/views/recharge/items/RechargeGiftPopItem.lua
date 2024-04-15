slot0 = class("RechargeGiftPopItem", ReduxView)

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

	slot0.commonItem = CommonItemView.New(slot0.iconGo_, true)
	slot0.CommonData = clone(ItemTemplateData)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.number = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	CommonTools.SetCommonData(slot0.commonItem, {
		number = 1,
		id = slot0.id,
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	}, slot0.CommonData1)

	slot0.limitLabel_.text = "X" .. slot0.number
	slot0.nameLabel_.text = ItemTools.getItemName(slot0.id)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.commonItem then
		slot0.commonItem:Dispose()

		slot0.commonItem = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
