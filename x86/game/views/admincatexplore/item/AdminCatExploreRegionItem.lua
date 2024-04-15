slot0 = class("AdminCatExploreRegionItem", ReduxView)
slot1 = {
	"I",
	"II",
	"III",
	"IV",
	"V"
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.exploreBtn_, nil, function ()
		if uv0.stateController:GetSelectedState() == "normal" then
			JumpTools.OpenPageByJump("adminCatExplorePop", {
				regionId = uv0.regionId
			})
		elseif slot0 == "finish" then
			AdminCatExploreAction.AdminCatExploreFinish(uv0.regionId)
		elseif slot0 == "exploring" then
			JumpTools.OpenPageByJump("adminCatExploringPop", {
				regionId = uv0.regionId
			})
		elseif slot0 == "lock" then
			ShowTips("ERROR_EXPLORE_LV_LIMIT")
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data = slot1
	slot0.index = slot2
	slot0.regionId = AdminCatExploreData:GetRegionIdByIndex(slot0.index)
end

function slot0.UpdateBar(slot0)
end

function slot0.UpdateView(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	slot0.level = AdminCatExploreData:GetDataByPara("level")
	slot1 = ExploreAreaCfg[slot0.regionId]
	slot0.regionData = AdminCatExploreData:GetDataByPara("regionData")[slot0.regionId]
	slot0.regionUnlockLevel = AdminCatExploreData:GetDataByPara("regionUnlockLevel")

	if slot0.regionUnlockLevel[slot0.regionId] and slot0.level < slot0.regionUnlockLevel[slot0.regionId] then
		slot0.stateController:SetSelectedState("lock")

		slot0.lockTxt_.text = string.format(GetTips("EXPLORE_DEBLOCKING_LEVEL"), uv0[slot0.regionUnlockLevel[slot0.regionId]])
	elseif slot0.regionData then
		if manager.time:GetServerTime() < slot0.regionData.stopTime then
			slot2 = slot0.regionData.stopTime - manager.time:GetServerTime()
			slot0.remainTxt_.text = manager.time:DescCDTime(slot2)
			slot0.fillImg_.fillAmount = 1 - slot2 / (slot0.regionData.stopTime - slot0.regionData.startTime)
			slot0.updateTimer_ = Timer.New(function ()
				uv0 = uv1.regionData.stopTime - manager.time:GetServerTime()
				uv1.remainTxt_.text = manager.time:DescCDTime(uv0)
				uv1.fillImg_.fillAmount = 1 - uv0 / (uv1.regionData.stopTime - uv1.regionData.startTime)

				if uv0 <= 0 then
					AdminCatExploreData:UpdateRegionRedPoint()
					uv1.stateController:SetSelectedState("finish")

					uv1.stateText_.text = GetTips("EXPLORE_REGION_FINISH")

					uv1.updateTimer_:Stop()

					uv1.updateTimer_ = nil
				end
			end, 1, slot2, 1)

			slot0.updateTimer_:Start()
			slot0.stateController:SetSelectedState("exploring")

			slot0.stateText_.text = GetTips("EXPLORE_REGION_EXPLORING")
		else
			slot0.getFill_.fillAmount = 1
			slot0.remainTxt_.text = manager.time:DescCDTime(0)

			slot0.stateController:SetSelectedState("finish")

			slot0.stateText_.text = GetTips("EXPLORE_REGION_FINISH")
		end
	else
		slot0.fillImg_.fillAmount = 0

		slot0.stateController:SetSelectedState("normal")

		slot0.stateText_.text = GetTips("EXPLORE_REGION_NORMAL")
	end

	slot0.regionNameTxt_.text = GetI18NText(slot1.area_name)

	if slot0.regionData then
		slot0.adminCatImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. ExploreMeowCfg[slot0.regionData.adminCatID].meow_icon)
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.exploreBtn_.transform, RedPointConst.EXPLORE_FINISH .. slot0.regionId, {
		x = 50,
		y = 50
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.exploreBtn_.transform, RedPointConst.EXPLORE_FINISH .. slot0.regionId)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.OnExit(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
