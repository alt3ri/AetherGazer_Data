slot0 = class("CombineGameFactorItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.selectController = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
end

function slot0.AddUIListener(slot0)
	if slot0.selectBtn_ then
		slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
			uv0.register(uv0.index, uv0.factorId, uv0.selectController)
		end)
	end
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.index = slot1
	slot0.factorId = slot2
	slot0.register = slot3
	slot0.cfg = ActivityCombineFactorCfg[slot2]
	slot0.isSelect = slot4

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot0.cfg.icon)
	slot0.descTxt_.text = GetI18NText(slot0.cfg.description)
	slot0.scoreTxt_.text = slot0.cfg.score > 0 and "+" .. slot0.cfg.score or slot0.cfg.score

	if slot0.selectController then
		slot0.selectController:SetSelectedState(slot0.isSelect and "true" or "false")
	end
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
