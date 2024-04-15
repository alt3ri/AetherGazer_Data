ActivityMainBaseView = import("game.views.activity.Main.ActivityMainBaseView")
slot0 = class("ActivitySummerMainView", ActivityMainBaseView)

function slot0.UIName(slot0)
	return "UI/VersionUI/SummerUI/SummerMainUI"
end

function slot0.Init(slot0)
	uv0.super.Init(slot0)
	slot0:AddBtnListener(slot0.shopBtn_, nil, function ()
		uv0:ClickShopBtn()
	end)
	slot0:AddBtnListener(slot0.shopBtn2_, nil, function ()
		uv0:ClickShopBtn()
	end)
end

function slot0.ClickShopBtn(slot0)
	slot1, slot2 = ShopTools.IsShopOpen(26)

	if slot1 then
		JumpTools.GoToSystem("/activityShop", {
			shopId = ShopConst.SHOP_ID.SUMMER_SHOP1,
			showShops = {
				ShopConst.SHOP_ID.SUMMER_SHOP1
			}
		}, ViewConst.SYSTEM_ID.SHOP)
	elseif slot2 == 2 then
		ShowTips("SHOP_EXPIRED")
	elseif slot2 == 3 then
		ShowTips("SHOP_NOT_OPEN")
	end
end

function slot0.InitSubmoduleButton(slot0)
	slot0.submoduleBtnList_ = {
		ActivitySubmoduleItem.New(slot0.storyGo_, ActivityConst.SUMMER_STORY),
		ActivitySkinTrialSubmoduleItem.New(slot0.heroSkinGo_, ActivityConst.SUMMER_SKIN_TRIAL_STAGE),
		ActivitySubmoduleItem.New(slot0.challengeGo_, ActivityConst.SUMMER_SOLO_CHALLENGE),
		ActivityHeroTrialItem.New(slot0.heroTrialGo_, ActivityConst.SCARCATTY_HERO_TRIAL_STAGE_),
		ActivitySubmoduleItem.New(slot0.artifactGo_, ActivityConst.SUMMER_ARTIFACT),
		ActivitySubmoduleItem.New(slot0.frontierGo_, ActivityConst.SUMMER_LIMITED_CALCULATION),
		ActivitySubmoduleItem.New(slot0.fishGo_, ActivityConst.SUMMER_FISHING),
		ActivitySubmoduleItem.New(slot0.ptGo_, ActivityConst.SUMMER_PT),
		ActivitySubmoduleItem.New(slot0.leviathanGo_, ActivityConst.SIKADI_GAME),
		ActivitySubmoduleItem.New(slot0.skinExchangeGo_, ActivityConst.SKIN_EXCHANGE)
	}
end

function slot0.GetActivityID(slot0)
	return ActivityConst.SUMMER_ACTIVITY
end

return slot0
