slot0 = class("DormDispatchAwardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.item = CommonItemView.New(slot0.commonitemGo_1)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	if slot1.extraNum then
		slot0.extraText_.text = string.format("+%d", slot1.extraNum)
	else
		slot0.extraText_.text = ""
	end

	slot0.item:SetData({
		id = slot1.id,
		number = slot1.num,
		clickFun = function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id
			})
		end
	})
end

function slot0.Dispose(slot0)
	if slot0.item then
		slot0.item:Dispose()

		slot0.item = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
