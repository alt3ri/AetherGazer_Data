slot0 = class("PassportPosterView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Passport/PassportPosterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.items_ = {}

	if slot0.itemGo1_ then
		table.insert(slot0.items_, {
			item = CommonItemView.New(slot0.itemGo1_),
			data = clone(ItemTemplateData)
		})
	end

	if slot0.itemGo2_ then
		table.insert(slot0.items_, {
			item = CommonItemView.New(slot0.itemGo2_),
			data = clone(ItemTemplateData)
		})
	end
end

function slot0.AddUIListener(slot0)
	slot4 = nil

	function slot5()
		uv0:Back()
	end

	slot0:AddBtnListener(slot0.bgBtn_, slot4, slot5)

	for slot4, slot5 in ipairs(slot0.items_) do
		function slot5.data.clickFun(slot0)
			ShowPopItem(POP_OTHER_ITEM, {
				slot0.id,
				slot0.number
			})
		end
	end
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
	slot0.dataList_ = BattlePassListCfg[PassportData:GetId()].display_reward_01

	for slot4, slot5 in ipairs(slot0.items_) do
		CommonTools.SetCommonData(slot5.item, {
			id = slot0.dataList_[slot4][1],
			number = slot0.dataList_[slot4][2] > 1 and slot0.dataList_[slot4][2] or nil
		}, slot5.data)
	end

	slot0.bgImg_.sprite = getSpriteWithoutAtlas(BattlePassListCfg[PassportData:GetId()].poster_ui)
	slot0.titleImg_.sprite = getSpriteWithoutAtlas(string.format(BattlePassListCfg[PassportData:GetId()].slogan_ui, string.upper(SettingData:GetCurrentLanguage())))
end

function slot0.OnExit(slot0)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.Cacheable(slot0)
	return false
end

function slot0.OnExitInput(slot0)
	JumpTools.Back()

	return true
end

function slot0.Dispose(slot0)
	if slot0.items_ then
		for slot4, slot5 in pairs(slot0.items_) do
			slot5.item:Dispose()
		end

		slot0.items_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
