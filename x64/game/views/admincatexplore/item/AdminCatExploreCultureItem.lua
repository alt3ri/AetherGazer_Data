slot0 = class("AdminCatExploreCultureItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.selectController = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		if uv0.registerFunction then
			uv0.registerFunction(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.data = slot1
	slot0.index = slot2
	slot0.registerFunction = slot3
	slot0.selectIndex = slot4

	slot0:UpdateView()
end

function slot0.GetController(slot0)
	return slot0.selectController
end

function slot0.UpdateView(slot0)
	slot1 = ExploreMeowCfg[slot0.data.id]

	slot0.stateController:SetSelectedState(slot0.data.canUse and "unlock" or "lock")

	slot0.adminCatImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_l/" .. slot1.meow_icon)
	slot0.nameTxt_.text = GetI18NText(slot1.meow_name)

	slot0.selectController:SetSelectedState(slot0.index == slot0.selectIndex and "sel" or "normal")
	manager.redPoint:bindUIandKey(slot0.adminCatImg_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. slot0.data.id, {
		x = 150,
		y = 70
	})
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.adminCatImg_.transform, RedPointConst.EXPLORE_UNLOCK_ADMIN_CAT .. slot0.data.id)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
