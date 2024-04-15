slot0 = class("KagutsuchiSpecialWinBarItem")
slot1 = import("manager.windowBar.WindowCurrencyItem")
slot2 = import("manager.windowBar.WindowMaterialItem")
slot3 = import("manager.windowBar.WindowActivityMatrixCoinItem")

function slot0.Ctor(slot0, slot1, slot2, slot3)
	uv0.gameObject_ = slot2
	uv0.transform_ = slot2.transform

	slot0:Init(slot3)
	slot0:AddListeners(slot1)
end

slot0.RegistEventListener = BaseView.RegistEventListener
slot0.RemoveAllEventListener = BaseView.RemoveAllEventListener

function slot0.TryInitDisplayTokenItem(slot0)
	slot0.materialItemCount = 0

	for slot4 = 1, 4 do
		if isNil(nullable(slot0, "token" .. slot4 .. "_")) then
			break
		else
			slot0.materialItemCount = slot4
		end
	end
end

function slot0.AddListeners(slot0, slot1)
	if slot0.homeBtn_ then
		slot1:AddBtnListener(slot0.homeBtn_, nil, function ()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")

			if uv0.homeFunc_ then
				uv0.homeFunc_()
			else
				DestroyLua()
				LuaExchangeHelper.GoToMain()
				OpenPageUntilLoaded("/home")
			end
		end)
	end

	if slot0.backBtn_ then
		slot1:AddBtnListener(slot0.backBtn_, nil, function ()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "backBtn")

			if uv0.backFunc_ then
				uv0.backFunc_()
			else
				JumpTools.Back()
			end
		end)
	end

	if slot0.infoBtn_ then
		slot1:AddBtnListener(slot0.infoBtn_, nil, function ()
			OperationRecorder.Record(gameContext:GetLastOpenPage(), "infoBtn")

			if uv0.infoFunc_ then
				uv0.infoFunc_()
			elseif type(uv0.gameHelpKey) == "table" then
				if uv0.gameHelpKey.type == "jump" then
					JumpTools.OpenPageByJump(uv0.gameHelpKey.view, uv0.gameHelpKey.params)
				end
			else
				JumpTools.OpenPageByJump("gameHelp", {
					icon = "icon_i",
					iconColor = Color(1, 1, 1),
					title = GetTips("STAGE_DESCRIPE"),
					content = GetTips(uv0.gameHelpKey),
					key = uv0.gameHelpKey
				})
			end
		end)
	end
end

function slot0.RegistHomeCallBack(slot0, slot1)
	slot0.homeFunc_ = slot1
end

function slot0.RegistBackCallBack(slot0, slot1)
	slot0.backFunc_ = slot1
end

function slot0.RegistInfoCallBack(slot0, slot1)
	slot0.infoFunc_ = slot1
end

function slot0.SetGameHelpKey(slot0, slot1)
	slot0.gameHelpKey = slot1
end

function slot4(slot0, slot1)
	slot2 = 0

	if slot1 == nil then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if bar ~= BACK_BAR and bar ~= HOME_BAR then
			if bar == INFO_BAR then
				-- Nothing
			elseif nullable(ItemCfg, slot7, "type") == ItemConst.ITEM_TYPE.CURRENCY and slot2 < slot0.materialItemCount then
				slot8 = "token" .. slot2 + 1 .. "_"
				slot9 = slot0.barGo[slot8]
				slot9 = uv0.New(nullable(slot0, slot8), slot7)

				slot9:SetActive(true)
				slot9:SetCanAdd(false)
				slot9:SetCanClick(true)

				slot0.barGo[slot8] = slot9
			end
		end
	end

	for slot6 = slot2 + 1, slot0.materialItemCount do
		SetActive(slot0["token" .. slot6 .. "_"], false)
	end
end

function slot0.Init(slot0, slot1)
	BaseView.BindCfgUI(slot0)
	slot0:TryInitDisplayTokenItem()

	slot0.barGo = {}

	uv0(slot0, slot1)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.barGo) do
		slot5:Dispose()
	end
end

return slot0
