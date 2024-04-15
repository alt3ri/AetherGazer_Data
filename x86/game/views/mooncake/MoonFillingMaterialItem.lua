slot0 = class("MoonFillingMaterialItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = activityID
	slot0.ID_ = slot1
	slot0.nameText_.text = ""

	slot0.SetActive(true)
end

function slot0.SetNum(slot0, slot1)
	slot0.numText_.text = slot1
end

function slot0.SetEnough(slot0, slot1)
	if slot0.statusController_ then
		slot0.statusController_:SetSelectedState(slot1 and "true" or "false")
	end
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
