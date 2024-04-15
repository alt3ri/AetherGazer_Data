slot0 = class("CombineGamePoolTaskItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.typeController = ControllerUtil.GetController(slot0.gameObject_.transform, "type")
	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, CommonItem)
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.cfg.reward[slot1][1],
		number = slot0.cfg.reward[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityId) then
			return
		end

		TaskAction:SubmitTask(uv0.taskId)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.taskId = slot2
	slot0.cfg = AssignmentCfg[slot2]
	slot0.activityId = slot3
	slot0.showBar = true

	slot0:UpdateView()
end

function slot0.HideBar(slot0)
	slot0.showBar = false

	SetActive(slot0.barGo_, slot0.showBar)
	SetActive(slot0.processTxt_.gameObject, slot0.showBar)
end

function slot0.UpdateView(slot0)
	slot2 = 0

	slot0.controller:SetSelectedState("cannotGet")

	if TaskData2:GetTask(slot0.taskId) then
		slot2 = slot1.progress
	end

	if slot0.cfg.need <= slot2 then
		slot2 = slot0.cfg.need

		slot0.controller:SetSelectedState("get")
	end

	if slot1 ~= nil and TaskData2:GetTaskComplete(slot0.taskId) then
		slot0.controller:SetSelectedState("getted")
	end

	slot0.typeController:SetSelectedState(slot0.cfg.type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY and "false" or "true")
	slot0.list:StartScroll(#slot0.cfg.reward)

	slot0.descTxt_.text = GetI18NText(slot0.cfg.desc)
	slot0.processTxt_.text = slot2 .. "/" .. slot0.cfg.need
	slot0.barImg_.fillAmount = slot2 / slot0.cfg.need

	SetActive(slot0.barGo_, slot0.showBar)
	SetActive(slot0.processTxt_.gameObject, slot0.showBar)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
