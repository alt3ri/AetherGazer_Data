slot0 = class("SurveyItem", ReduxView)

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

	slot0.controller_ = ControllerUtil.GetController(slot0.gameObject_.transform, "Item")
	slot0.commonList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, CommonItemView)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.info_ = slot1

	slot0.controller_:SetSelectedIndex(slot1.status)

	slot0.nameText_.text = GetI18NText(slot1.name)
	slot0.datetextText_.text = string.format(GetTips("TIME_DISPLAY_12"), manager.time:STimeDescS(slot1.stop_time, "!%Y/%m/%d ") .. manager.time:STimeDescS(slot1.stop_time, "!%H:%M:%S"))

	slot0:UpdateData()
	slot0.commonList_:StartScroll(#slot0.itemList_)
end

function slot0.UpdateData(slot0)
	slot0.itemList_ = {}

	for slot4, slot5 in ipairs(slot0.info_.attachment_list) do
		table.insert(slot0.itemList_, {
			id = slot5.id,
			number = slot5.num
		})
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot3 = slot0.itemList_[slot1]
	slot4 = clone(ItemTemplateData)
	slot4.id = slot3.id
	slot4.number = slot3.number

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.answerbtnBtn_, nil, function ()
		if uv0.info_.status == 0 then
			slot3 = OperationAction.GetOperationUrl("gameNotifyURL") or ""

			if SDKTools.GetIsThisServer({
				"kr"
			}) then
				LuaForUtil.OpenWebView(uv0.info_.url .. PlayerData:GetPlayerInfo().userID .. "_" .. PlayerData:GetPlayerInfo().signUserId, true)
			elseif SDKTools.GetIsOverSea() then
				SendMessageToSDK(string.format("{\"messageType\" : \"ShowSurvey\", \"activityId\" : \"%s\",\"roleId\" : \"%s\" , \"serverId\" : \"%s\", \"gameNotifyURL\" : \"%s\" }", uv0.info_.question_num, slot0 .. "_" .. slot1, tostring(_G.TMP_SERVER_ID), slot3))
			else
				LuaForUtil.OpenWebView(slot2 .. slot0 .. "_" .. slot1, true)
			end
		end
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.info_.status == 1 then
			SurveyAction.GetReward(uv0.info_.id)
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.commonList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
