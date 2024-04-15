slot0 = class("NewHeroArchiveHeroFillterItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			if uv0.lock_ then
				if uv0.type_ == 1 then
					ShowTips(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_RACE"))
				elseif uv0.type_ == 2 then
					ShowTips(GetTips("HERO_HEART_CHAIN_SUPER_PLOT_UNLOCK_RACE"))
				end

				return
			end

			uv0.clickHandler_(uv0.id_, uv0.index)
		end
	end)
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.OnTop(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.id_ = slot1.id
	slot0.index_ = slot2

	slot0:RefreshUI(1)
end

function slot0.ResetData(slot0)
	slot0.data_ = nil
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot3 = nil
	slot0.type_ = slot1

	if slot1 == 1 then
		slot3 = ArchiveData:GetContinuousHeartArchiveListByType(slot0.id_)
	elseif slot1 == 2 then
		slot3 = ArchiveData:GetContinuousSuperHeartArchiveListByType(slot0.id_)
	end

	if table.isEmpty(slot3) then
		slot0.stateController:SetSelectedState("lock")

		slot0.lock_ = true
	elseif slot0.index_ == slot2 then
		slot0.stateController:SetSelectedState("selected")

		slot0.lock_ = false
	elseif slot0.index_ ~= slot2 then
		slot0.stateController:SetSelectedState("unselected")

		slot0.lock_ = false
	end

	slot0.img_.sprite = getSprite("Atlas/CampItemAtlas", slot0.data_.icon)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
