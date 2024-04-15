slot0 = class("HeroTrustGiftDisplaceItem", ReduxView)

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

	slot0.choiceController = ControllerUtil.GetController(slot0.transform_, "choice")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.loveList = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, HeroTrustGiftDisplaceHeroItem)
	slot0.item = CommonItemView.New(slot0.m_item, true)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.itemId)
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_choiceBtn, function ()
		if uv0.callback2_ then
			uv0.callback2_(uv0.itemId)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.itemId = slot1
	slot3 = clone(ItemTemplateData)
	slot3.id = slot1
	slot3.number = ItemTools.getItemNum(slot1)

	function slot3.clickFun()
		ShowPopItem(POP_ITEM, {
			uv0,
			ItemTools.getItemNum(uv0)
		})
	end

	slot0.item:SetData(slot3)

	slot0.m_name.text = ItemTools.getItemName(slot1)
	slot0.heroIds = slot0:GetLikeHeros(slot1)

	slot0.loveList:StartScroll(#slot0.heroIds)
	slot0.choiceController:SetSelectedIndex(slot2 == 0 and 0 or 1)

	slot0.m_choiceLab.text = slot2
end

function slot0.SetSelect(slot0, slot1)
	slot0.selectController:SetSelectedIndex(slot1 == slot0.itemId and 1 or 0)
end

function slot0.GetLikeHeros(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(HeroRecordCfg.all) do
		if table.indexof(HeroRecordCfg[slot7].gift_like_id1, slot1) then
			return slot8.hero_id
		end
	end

	return slot2
end

function slot0.Dispose(slot0)
	slot0.item:Dispose()
	slot0.loveList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.RegistCallBack2(slot0, slot1)
	slot0.callback2_ = slot1
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.heroIds[slot1])
end

return slot0
