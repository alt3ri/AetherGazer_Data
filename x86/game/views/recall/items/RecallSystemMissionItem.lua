slot0 = class("RecallSystemMissionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.completeBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskCfg.id)
	end)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, CommonItemView)
end

function slot0.IndexItem(slot0, slot1, slot2)
	CommonTools.SetCommonData(slot2, {
		id = slot0.rewardList[slot1][1],
		number = slot0.rewardList[slot1][2],
		clickFun = function (slot0)
			ShowPopItem(POP_OTHER_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	})
end

function slot0.SetData(slot0, slot1)
	slot0.taskCfg = AssignmentCfg[slot1.id]
	slot0.taskInfo = slot1
	slot0.rewardList = slot0.taskCfg.reward or {}

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.list_:StartScrollWithoutAnimator(#slot0.rewardList)

	slot0.taskDescTxt_.text = slot0.taskCfg.desc

	if slot0.taskCfg.need < slot0.taskInfo.progress then
		slot1 = slot2
	end

	slot0.taskProgressTxt_.text = string.format("%d/%d", slot1, slot2)

	if slot0.taskInfo.complete_flag == 1 then
		slot0.controller:SetSelectedState("accepted")
	elseif slot2 <= slot1 then
		slot0.controller:SetSelectedState("complete")
	else
		slot0.controller:SetSelectedState("uncomplete")
	end

	slot0.taskTypeTxt_.text = slot0.taskCfg.name
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
