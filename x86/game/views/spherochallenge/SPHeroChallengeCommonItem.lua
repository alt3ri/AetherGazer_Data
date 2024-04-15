slot0 = class("SPHeroChallengeCommonItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("state")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.itemID = slot1.id

	if slot1.state then
		slot0.stateController:SetSelectedState(slot1.state)

		if slot0.itemID > 0 and ItemCfg[slot0.itemID] then
			-- Nothing
		end
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
