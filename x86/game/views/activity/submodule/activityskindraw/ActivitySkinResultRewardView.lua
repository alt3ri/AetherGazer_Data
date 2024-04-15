slot0 = class("ActivitySkinResultRewardView", ReduxView)

function slot0.UIName(slot0)
	return ActivitySkinDrawTools.GetDrawResultUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.btn_ = {}
	slot0.icon_ = {}
	slot0.role_ = {}
	slot0.text_ = {}
	slot0.name_ = {}
	slot0.itemGo_ = {}
	slot0.typeCon_ = {}

	for slot4 = 1, 10 do
		slot0.btn_[slot4] = slot0["btn_" .. slot4]
		slot0.icon_[slot4] = slot0["icon_" .. slot4]
		slot0.role_[slot4] = slot0["role_" .. slot4]
		slot0.text_[slot4] = slot0["text_" .. slot4]
		slot0.name_[slot4] = slot0["name_" .. slot4]
		slot0.itemGo_[slot4] = slot0["itemGo_" .. slot4]
		slot0.typeCon_[slot4] = ControllerUtil.GetController(slot0.itemGo_[slot4].transform, "type")
	end
end

function slot0.AddUIListeners(slot0)
	slot4 = nil

	function slot5()
		JumpTools.OpenPageByJump("/activityskinDraw", {
			activityID = uv0.mainActivityID_,
			isSceneDrawed = uv0.isScene_
		})
	end

	slot0:AddBtnListener(slot0.bgBtn_, slot4, slot5)

	for slot4, slot5 in ipairs(slot0.btn_) do
		slot0:AddBtnListener(slot5, nil, function ()
			ShowPopItem(POP_ITEM, {
				ActivityLimitedDrawPoolCfg[uv0.list_[uv1]].reward[1][1]
			})
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = ActivityTools.GetMainActivityId(slot0.params_.activityID)

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.list_ = slot0.params_.list

	table.sort(slot0.list_, function (slot0, slot1)
		slot2 = ActivityLimitedDrawPoolCfg[slot0]
		slot3 = slot2.reward[1][1]
		slot5 = ActivityLimitedDrawPoolCfg[slot1]
		slot6 = slot5.reward[1][1]

		if slot2.minimum_guarantee ~= slot5.minimum_guarantee then
			return slot7 < slot4
		end

		return slot3 < slot6
	end)

	slot0.isScene_ = false

	for slot4, slot5 in ipairs(slot0.list_) do
		slot6 = ActivityLimitedDrawPoolCfg[slot5]
		slot7 = slot6.reward[1]
		slot9 = slot7[2]
		slot10 = false
		slot13 = 1
		slot13 = slot6.minimum_guarantee == 2 and 3 or 2

		if ItemCfg[slot7[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
			slot10 = true

			slot0.typeCon_[slot4]:SetSelectedState("special")
		elseif slot12 == ItemConst.ITEM_TYPE.SCENE then
			slot0.isScene_ = true

			slot0.typeCon_[slot4]:SetSelectedState("special")
		else
			slot0.typeCon_[slot4]:SetSelectedState(slot13)
		end

		if slot10 then
			SetActive(slot0.icon_[slot4].gameObject, false)
			SetActive(slot0.role_[slot4].gameObject, true)

			slot0.role_[slot4].sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot8)
		else
			SetActive(slot0.icon_[slot4].gameObject, true)
			SetActive(slot0.role_[slot4].gameObject, false)

			slot0.icon_[slot4].sprite = ItemTools.getItemSprite(slot8)

			slot0.icon_[slot4]:SetNativeSize()
		end

		slot0.text_[slot4].text = "X" .. slot9
		slot0.name_[slot4].text = ItemTools.getItemName(slot8)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
