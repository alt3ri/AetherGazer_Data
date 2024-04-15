slot0 = class("SevenDaySkinPopView", ReduxView)

function slot0.UIName(slot0)
	return "UI/SevenSignSkin/XH3rdSevenPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()

	slot0.items = {}
end

function slot0.InitUI(slot0)
	slot0.gameObject_:InjectUI(slot0)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.BtnMask, nil, handler(slot0, slot0.OpenRewardUI))
end

function slot0.OnEnter(slot0)
	slot0.msg = slot0.params_.msg
	slot0.reward = slot0.params_.reward

	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	slot0.TxtContent.text = GetTips(slot0.msg.body)
	slot0.TxtName.text = GetTips(slot0.msg.author)

	slot0.Ctrl:SetSelectedState(slot0.msg.name)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.OpenRewardUI(slot0)
	slot0.Back()

	if slot0.reward[1][1] == 1042051 then
		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = string.format(GetTips("USE_SKIN_CHANGE"), ItemTools.getItemName(1042051)),
			OkCallback = function ()
				CommonAction.TryToUseItem({
					{
						item_info = {
							id = 1042051,
							num = 1
						},
						use_list = {}
					}
				})
			end,
			MaskCallback = function ()
				getReward(formatRewardCfgList(uv0.reward))
			end,
			CancelCallback = function ()
				getReward(formatRewardCfgList(uv0.reward))
			end
		})
	else
		getReward(formatRewardCfgList(slot0.reward))
	end
end

return slot0
