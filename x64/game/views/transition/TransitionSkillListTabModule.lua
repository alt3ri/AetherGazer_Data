slot0 = class("TransitionSkillListTabModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		comps = slot0.tabController_,
		tab = {
			comps = slot0.tabController_:GetController("pos")
		}
	}
	slot0.constVar = {
		tabPrefix = "tab%dBtn_"
	}
	slot0.data = {
		tabIdx = -1
	}
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 6 do
		slot0:AddBtnListener(slot0[string.format(slot0.constVar.tabPrefix, slot4)], nil, function ()
			if uv0.data.tabIdx == uv1 then
				return
			end

			uv0:OnTabClick(uv1)
		end)
	end
end

function slot0.RegisterClickCallback(slot0, slot1)
	slot0.data.clickCallback = slot1
end

function slot0.OnTabClick(slot0, slot1)
	slot0.data.tabIdx = slot1

	slot0.controller.tab.comps:SetSelectedState(tostring(slot1))

	if slot0.data.clickCallback then
		slot2(slot1)
	end
end

function slot0.OnDispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
