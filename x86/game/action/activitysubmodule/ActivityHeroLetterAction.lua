slot1 = false

return {
	Init = function ()
		ActivityHeroLetterData:Init()

		if uv0 then
			return
		end

		manager.net:Bind(11095, function (slot0)
			ActivityHeroLetterData:SetData(slot0)
			ActivityHeroLetterAction.RefreshRedPoint(slot0.activity_id)
		end)

		uv0 = true
	end,
	GetReward = function (slot0)
		manager.net:SendWithLoadingNew(11092, {
			activity_id = slot0
		}, 11093, uv0.OnGetReward)
	end,
	OnGetReward = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward(slot0.item_list)
			ActivityHeroLetterData:SetRewardSign(slot1.activity_id, true)
			manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. slot1.activity_id, 0)
			manager.notify:CallUpdateFunc(HERO_LETTER_REWARD)
		else
			ShowTips(slot0.result)
		end
	end,
	InitRedPointKey = function (slot0)
		slot1 = {}

		for slot6, slot7 in ipairs(ActivityHeroTaskCfg.get_id_list_by_main_activity_id[slot0]) do
			slot8 = ActivityHeroTaskCfg[slot7].activity_id

			manager.redPoint:addGroup(RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. slot8, {
				RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. slot8,
				RedPointConst.ACTIVITY_TASK .. "_" .. slot8
			})
			table.insert(slot1, RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. slot8)
		end

		table.insert(slot1, RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. slot0)
		manager.redPoint:addGroup(RedPointConst.ACTIVITY_HERO_LETTER .. "_" .. slot0, slot1)
	end,
	RefreshRedPoint = function (slot0)
		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_REPORT .. "_" .. slot0, ActivityHeroLetterData:GetRewwardSign(slot0) == 0 and 1 or 0)

		for slot6, slot7 in ipairs(ActivityHeroTaskCfg.get_id_list_by_main_activity_id[slot0]) do
			slot8 = ActivityHeroTaskCfg[slot7].activity_id

			manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. slot8, ActivityData:GetActivityData(slot8):IsActivitying() and not ActivityHeroLetterTools.IsReward(slot7) and 1 or 0)
		end
	end
}
