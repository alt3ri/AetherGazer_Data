slot0 = class("TerminologyItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.Dispose(slot0)
	slot0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.id_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if TerminologyCfg[slot0.id_] == nil then
		Debug.LogError(string.format("TerminologyItem: could not find terminology for id %d", slot0.id_))

		return
	end

	slot0.titleText_.text = TerminologyTools.GetCfgTitle(slot1)
	slot0.descText_.text = TerminologyTools.GetCfgDescription(slot1)
end

return slot0
