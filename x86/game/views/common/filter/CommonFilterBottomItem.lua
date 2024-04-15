slot0 = class("CommonFilterBottomItem", ReduxView)

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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.info_)
		end
	end)
end

function slot0.Refresh(slot0, slot1)
	slot0.info_ = slot1
	slot0.nameText_.text = slot0.info_.name

	SetActive(slot0.gameObject_, true)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
