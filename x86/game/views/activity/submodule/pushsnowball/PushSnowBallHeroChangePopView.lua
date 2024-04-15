slot0 = class("PushSnowBallHeroChangePopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRoleChangePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroDataList_ = PushSnowBallData:GetHeroDataList()
	slot0.heroItemList_ = {}
	slot0.heroControllerList_ = {}

	for slot4 = 1, 4 do
		if slot0.heroDataList_[slot4] then
			slot0["heroIcon" .. slot4].sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/snowballPortrait/" .. slot0.heroDataList_[slot4])

			slot0:AddBtnListener(slot0["heroItem" .. slot4], nil, function ()
				uv0.selectIndex_ = uv1

				uv0:RefreshController()
			end)
			table.insert(slot0.heroItemList_, slot0["heroItem" .. slot4])
			table.insert(slot0.heroControllerList_, ControllerUtil.GetController(slot0["heroItem" .. slot4].transform, "toggle"))
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.changeBtn_, nil, function ()
		PushSnowBallData:SetSelectedHeroIndex(uv0.selectIndex_)
		PushSnowBallGameMgr.GetInstance():SetPlayer(PushSnowBallData:GetSelectedHeroID())
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.selectIndex_ = PushSnowBallData:GetSelectedHeroIndex()

	slot0:RefreshController()
end

function slot0.RefreshController(slot0)
	for slot4, slot5 in ipairs(slot0.heroControllerList_) do
		if slot0.selectIndex_ == slot4 then
			slot5:SetSelectedState("on")
		else
			slot5:SetSelectedState("off")
		end
	end
end

return slot0
