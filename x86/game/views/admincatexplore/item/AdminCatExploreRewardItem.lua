slot0 = class("AdminCatExploreRewardItem", ReduxView)

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

	slot0.nameController = ControllerUtil.GetController(slot0.gameObject_.transform, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		ShowPopItem(POP_OTHER_ITEM, {
			uv0.data[1],
			uv0.data[2]
		})
	end)
end

function slot0.SetItemData(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.index = slot2

	slot0:UpdateView()
end

function slot0.UpdateText(slot0, slot1)
	slot0.numTxt_.text = slot1
end

function slot0.UpdateView(slot0)
	slot0.numTxt_.text = slot0.data[2]
	slot0.iconImage_.sprite = ItemTools.getItemSprite(slot0.data[1])
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
