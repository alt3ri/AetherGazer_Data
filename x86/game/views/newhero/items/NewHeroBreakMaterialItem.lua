slot0 = class("NewHeroBreakMaterialItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.enoughController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "enough")
	slot0.commonItem_ = CommonItemView.New(slot0.gameObject_)
end

function slot0.SetInfo(slot0, slot1, slot2)
	slot0.materialId_ = slot1
	slot0.count_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot1 = slot0.commonItem_:GetData()
	slot0.data = clone(ItemTemplateData)

	function slot0.data.clickFun()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.materialId_,
			uv0.count_
		})
	end

	slot0.data.id = slot0.materialId_
	slot0.data.number = slot0.count_

	slot0.commonItem_:SetData(slot0.data)
	slot0.commonItem_:RefreshBottomText({
		ItemTools.getItemNum(slot0.materialId_),
		slot0.count_
	})
end

function slot0.IsEnough(slot0)
	return slot0.count_ <= ItemTools.getItemNum(slot0.materialId_)
end

function slot0.GetMaterialId(slot0)
	return slot0.materialId_
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.commonItem_ then
		slot0.commonItem_:Dispose()

		slot0.commonItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
