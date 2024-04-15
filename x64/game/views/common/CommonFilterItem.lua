slot0 = class("CommonFilterItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.filterContext = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.oldIsFlag = false
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.SelectController = ControllerUtil.GetController(slot0.controllerObj_, "select")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, handler(slot0, slot0.OnBtnClick))
end

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot0.filter_id = slot1
	slot0.group_id = slot2
	slot0.tagId = slot3

	if not CommonFilterConst.GetFilterTagCfg(slot3) then
		return
	end

	slot0.isFlag = slot0.filterContext:HasIndexFlag(slot0.group_id, slot3)

	if slot0.isFlag ~= slot0.oldIsFlag then
		slot0.oldIsFlag = slot0.isFlag

		slot0.SelectController:SetSelectedState(slot0.isFlag and "on" or "off")
	end

	if slot4.atlasName and slot4.atlasName ~= "" then
		SetActive(slot0.tagImg_.gameObject, true)

		slot0.tagImg_.sprite = getSprite(slot4.atlasName, slot4.spriteName)
		slot0.tagTxt_.text = GetTips(slot4.name)
	else
		SetActive(slot0.tagImg_.gameObject, false)

		slot0.tagTxt_.text = GetTips(slot4.name)
	end
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

function slot0.OnBtnClick(slot0)
	slot1 = -1
	slot1 = (not slot0.isFlag or slot0.filterContext:DeSelectTag(slot0.group_id, slot0.tagId)) and slot0.filterContext:SelectTag(slot0.group_id, slot0.tagId)

	manager.notify:Invoke("OnCommonFilterItemClick", {
		gId = slot0.group_id,
		tId = slot0.tagId
	})
end

return slot0
