manager.net:Bind(61001, function (slot0)
	HeroGiftData:InitData(slot0)
	manager.notify:CallUpdateFunc(HERO_GIFT_REWARD)
end)

return {
	QueryReceiveHeroGift = function (slot0)
		manager.net:SendWithLoadingNew(61002, {
			activity_id = slot0
		}, 61003, uv0.OnQueryReceiveHeroGiftCallBack)
	end,
	OnQueryReceiveHeroGiftCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			getReward2(slot0.reward_list, {
				ItemConst.ITEM_TYPE.HERO
			})
			HeroGiftData:SetReceiveHeroGift(slot1.activity_id)
			manager.notify:CallUpdateFunc(HERO_GIFT_REWARD)
		end
	end
}
