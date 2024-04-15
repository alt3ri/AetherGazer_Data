slot0 = class("ActivityAttributeArenaRewardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.awardList_ = {}
	slot0.buttonController = slot0.allBtnController_:GetController("all")

	for slot4 = 1, 3 do
		table.insert(slot0.awardList_, CommonItemView.New(slot0["awardItem" .. slot4 .. "Obj_"]))
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		TaskAction:SubmitTask(uv0.taskID_)
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.taskID_ = slot1.id
	slot0.taskProgress = slot1.progress
	slot0.taskComplete_ = slot1.complete_flag >= 1

	slot0:RefreshUI(slot2)
	slot0:RefreshProgress()
end

function slot0.RefreshUI(slot0, slot1)
	slot0.rewards = AssignmentCfg[slot0.taskID_].reward or {}

	slot0:RefreshItems()
end

function slot0.RefreshProgress(slot0)
	slot2 = slot0.taskProgress

	if AssignmentCfg[slot0.taskID_].need < slot0.taskProgress then
		slot2 = slot1.need
	end

	slot3 = AssignmentCfg[slot0.taskID_]
	slot0.titleText_.text = slot3.desc
	slot0.progressBar_.value = slot2 / slot3.need
	slot0.progressText_.text = string.format("%s/%s", slot2, slot3.need)
	slot4 = slot3.need <= slot0.taskProgress

	if slot0.taskComplete_ then
		slot0.buttonController:SetSelectedIndex("2")
	elseif slot4 then
		slot0.buttonController:SetSelectedIndex("1")
	else
		slot0.buttonController:SetSelectedIndex("3")
	end
end

function slot0.RefreshItems(slot0)
	for slot4, slot5 in ipairs(slot0.awardList_) do
		if slot0.rewards[slot4] then
			slot7 = clone(ItemTemplateData)
			slot7.id = slot6[1]
			slot7.number = slot6[2]

			function slot7.clickFun(slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot5:SetData(slot7)
		else
			slot5:SetData(nil)
		end
	end
end

function slot0.Dispose(slot0)
	if slot0.awardList_ then
		for slot4, slot5 in ipairs(slot0.awardList_) do
			slot5:Dispose()

			slot5 = nil
		end

		slot0.awardList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
