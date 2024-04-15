slot0 = class("RechargeRecommendBgItemView", ReduxView)

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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		OperationRecorder.RecordButtonTouch("shop_recommend_right_" .. uv0.cfg_.goods_id)

		slot0 = uv0.cfg_.jump

		if uv0.cfg_.goods_id == 0 then
			-- Nothing
		end

		slot3 = false

		if not uv0.cfg_.time[1] or #slot2[1] < 3 or #slot2[2] < 3 then
			slot3 = true
		end

		if not slot1.time[2] or #slot4[1] < 3 or #slot4[2] < 3 then
			slot3 = true
		end

		slot3 = slot3 or TimeMgr.GetInstance():GetServerTime() < TimeMgr.GetInstance():parseTimeFromConfig(slot1.time[2]) and TimeMgr.GetInstance():parseTimeFromConfig(slot1.time[1]) <= slot7 and true or false

		if uv0.cfg_.jump2 ~= "" then
			if #uv0.cfg_.jump2 == 5 then
				slot3 = ShopTools.IsGoodCanDisplay(uv0.cfg_.jump2[5], uv0.cfg_.jump2[2])
			elseif #uv0.cfg_.jump2 == 3 then
				slot3 = ShopTools.IsGoodCanDisplay(uv0.cfg_.jump2[3], uv0.cfg_.jump2[2])
			end
		end

		if slot3 then
			JumpTools.JumpToPage(slot0)

			if uv0.cfg_.jump2 ~= nil and uv0.cfg_.jump2 ~= "" then
				if #uv0.cfg_.jump2 == 5 and ShopTools.IsGoodCanBuyInShop(uv0.cfg_.jump2[5], uv0.cfg_.jump2[2]) and ShopTools.CheckSoldOut(uv0.cfg_.jump2[2]) then
					ShowTips("SKIN_HAD_UNLOCKED")

					return
				end

				JumpTools.JumpToPage(uv0.cfg_.jump2)
			end
		else
			ShowTips("GOODS_HAS_BEEN_REMOVED")
		end
	end)

	if slot0.infoBtn_ then
		slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
			slot1 = ""

			if uv0.cfg_.info_desc[1] == 1 then
				slot1 = RechargeShopDescriptionCfg[slot0[2]].desc2
			else
				print("未支持对应类型的说明文本", slot0[1])
			end

			JumpTools.OpenPageByJump("gameHelp", {
				title = GetTips("SHOP_GIFT_DESCRIBE"),
				content = slot1
			})
		end)
	end
end

function slot0.AddEventListeners(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.cfg_ = slot2

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	if slot0.timeGo_ then
		SetActive(slot0.timeGo_, slot0.cfg_.show_time ~= "")

		slot0.timeTxt_.text = slot0.cfg_.show_time
	end
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	slot0.data_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
