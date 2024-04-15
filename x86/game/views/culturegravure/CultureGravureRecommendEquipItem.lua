slot0 = class("CultureGravureRecommendEquipItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.positionController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "position")
	slot0.starController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "star")
	slot0.btnController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnEquip_, nil, function ()
		JumpTools.OpenPageByJump("cultureGravureEquipPopView", {
			heroId = uv0.heroID_,
			recommendIdList = {
				[uv0.index_] = uv0.id_
			},
			stateList = {
				[uv0.index_] = uv0.state_
			},
			index = uv0.index_
		})
	end)
	slot0:AddBtnListener(slot0.btnGet_, nil, function ()
		ShowPopItemSource(uv0.id_)
	end)
	slot0:AddBtnListener(slot0.btnShow_, nil, function ()
		ShowPopItem(POP_OPERATE_ITEM, {
			uv0.id_
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.index_ = slot1
	slot0.id_ = slot2
	slot0.heroID_ = slot3
	slot0.state_ = slot4
	slot0.cfg_ = EquipCfg[slot2]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	SetSpriteWithoutAtlasAsync(slot0.icon_, SpritePathCfg.EquipIcon_s.path .. ItemCfg[slot0.id_].icon)
	slot0.positionController_:SetSelectedState(slot0.cfg_.pos)
	slot0.starController_:SetSelectedState(slot0.cfg_.starlevel)
	slot0.btnController_:SetSelectedState(slot0.state_)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
