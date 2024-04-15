slot0 = class("GameHelpProItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.showTextureController_ = slot0.m_controller:GetController("showTexture")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	if slot0.curPath_ == slot2 then
		return
	end

	slot0.curPath_ = slot2

	slot0:DestroyGo()

	if slot3 then
		slot0.showTextureController_:SetSelectedState("false")

		slot0.prefabGo_ = Object.Instantiate(Asset.Load(slot2), slot0.transform_)
	else
		slot0.showTextureController_:SetSelectedState("true")
		getSpriteWithoutAtlasAsync(slot2, function (slot0)
			uv0.m_icon.sprite = slot0
		end)
	end
end

function slot0.DestroyGo(slot0)
	if slot0.prefabGo_ then
		Object.Destroy(slot0.prefabGo_)

		slot0.prefabGo_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:DestroyGo()
end

return slot0
