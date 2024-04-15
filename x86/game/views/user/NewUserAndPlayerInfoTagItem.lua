slot0 = class("NewUserAndPlayerInfoTagItem", ReduxView)
slot1 = 288

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.textContentFitter_ = slot0.desc_.transform:GetComponent("ContentSizeFitter")
	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1)
	SetActive(slot0.gameObject_, true)

	slot0.id_ = slot1
	slot0.cfg_ = ProfileLabelCfg[slot0.id_]
	slot0.desc_.text = slot0.cfg_.name

	slot0.typeCon_:SetSelectedState(slot0.cfg_.type)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)

	if slot0.desc_.transform.rect.width < uv0 then
		slot0.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.PreferredSize
	else
		slot0.textContentFitter_.horizontalFit = ContentSizeFitter.FitMode.Unconstrained
		slot0.descRect_.sizeDelta = Vector2(uv0, slot0.descRect_.sizeDelta.y)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.desc_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
