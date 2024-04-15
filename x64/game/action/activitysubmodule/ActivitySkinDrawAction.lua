slot1 = false

return {
	Init = function ()
		ActivitySkinDrawData:Init()

		if uv0 then
			return
		end

		manager.net:Bind(68151, function (slot0)
			ActivitySkinDrawData:InitDrawData(slot0)
			uv0.RefreshRed(slot0.activity_id)
		end)
		manager.net:Bind(68161, function (slot0)
			ActivitySkinDrawData:InitStoryData(slot0)
		end)

		uv0 = true
	end,
	InitRedPointKey = function (slot0)
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_DRAW .. "_" .. slot0, {
			RedPointConst.ACTIVITY_TASK .. "_" .. ActivitySkinDrawTools.GetTaskActivityID(slot0)
		})

		if uv0.GetSceneID(slot0) then
			manager.redPoint:addGroup(RedPointConst.ACTIVITY_DRAW .. "_" .. slot0, {
				RedPointConst.SCENE .. "_" .. slot3
			})
		end
	end,
	GetSceneID = function (slot0)
		for slot8, slot9 in ipairs(ActivityLimitedDrawPoolCfg.get_id_list_by_pool_id[ActivitySkinDrawData:GetPoolID(ActivityCfg[slot0].sub_activity_list[2])]) do
			if ItemCfg[ActivityLimitedDrawPoolCfg[slot9].reward[1][1]].type == ItemConst.ITEM_TYPE.SCENE then
				return slot12.param[1]
			end
		end
	end,
	RefreshRed = function (slot0)
		if uv0.GetSceneID(ActivityTools.GetMainActivityId(slot0)) then
			manager.redPoint:setTip(RedPointConst.SCENE .. "_" .. slot2, getData("scene", tostring(slot2)) or 0)
		end
	end,
	StartDraw = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(68152, {
			activity_id = slot0,
			pool_id = slot1,
			drop_type = slot2
		}, 68153, uv0.OnStartDraw)
	end,
	OnStartDraw = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.pool_id
			slot3 = slot0.drop_list
			slot4 = slot1.activity_id

			ActivitySkinDrawData:RefreshData(slot4, slot3)
			JumpTools.OpenPageByJump("/activitySkinDrawStart", {
				activityID = slot4,
				poolID = slot1.pool_id,
				draw_list = slot3
			})
		else
			ShowTips(slot0.result)
		end
	end,
	FinishStory = function (slot0)
		manager.net:SendWithLoadingNew(68162, {
			activity_id = slot0
		}, 68163, uv0.OnFinishStory)
	end,
	OnFinishStory = function (slot0, slot1)
		if isSuccess(slot0.result) then
			ActivitySkinDrawData:FinishStory(ActivityLimitedSkinStoryCfg[slot1.activity_id].main_activity_id)
		else
			ShowTips(slot0.result)
		end
	end
}
