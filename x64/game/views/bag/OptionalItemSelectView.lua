slot0 = class("OptionalItemSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/UIInquirepopup14"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.selectInex_ = 0
	slot0.lastSelectItem_ = nil

	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.okBtnController_ = slot0.controllerEx_:GetController("btn")
	slot0.scrollHelper = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiList_, CommonItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot5 = clone(ItemTemplateData)
	slot5.id = slot0.dataList_[slot1][1]
	slot5.number = slot0.dataList_[slot1][2]
	slot5.selectStyle = slot1 == slot0.selectInex_

	function slot5.clickFun()
		uv0:SelectItem(uv1, uv2)
	end

	slot2:SetData(slot5)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if ItemCfg[uv0.itemInfo_[1]].param[uv0.indexMap_[uv0.selectInex_]] then
			if ItemCfg[slot1[1]].type == ItemConst.ITEM_TYPE.HERO_SKIN then
				if HeroTools.IsSkinUnlock(slot2) then
					ShowTips("SKIN_HAD_UNLOCKED")

					return
				end

				if MaterialData:GetMaterialListById(getTicketIDBySkinID(slot2)) then
					for slot9, slot10 in pairs(slot5) do
						if slot10 > 0 then
							ShowTips("SKIN_HAD_UNLOCKED")

							return
						end
					end
				end
			end

			CommonAction.TryToUseItem({
				{
					item_info = {
						id = uv0.itemInfo_[1],
						num = uv0.useNum_,
						time_valid = uv0.itemInfo_[4]
					},
					use_list = {
						uv0.selectInex_
					}
				}
			})
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.SelectItem(slot0, slot1, slot2)
	if slot0.selectInex_ == slot2 then
		return
	end

	if slot0.lastSelectItem_ then
		slot0.lastSelectItem_:RefreshSelectState(false)
	end

	slot0.selectInex_ = slot2
	slot0.lastSelectItem_ = slot1

	slot1:RefreshSelectState(true)
	slot0:RefreshSelect()
end

function slot0.RefreshUI(slot0)
	slot0.itemInfo_ = slot0.params_.popItemInfo
	slot0.useNum_ = slot0.params_.selectNum
	slot0.dataList_ = {}
	slot0.indexMap_ = {}
	slot2 = 1

	for slot6 = 1, #ItemCfg[slot0.itemInfo_[1]].param do
		if not HeroTools.GetIsHide(slot1.param[slot6][1]) then
			if not HeroTools.GetIsSkinHide(slot7) then
				table.insert(slot0.dataList_, slot1.param[slot6])

				slot0.indexMap_[slot2] = slot6
				slot2 = slot2 + 1
			end
		end
	end

	slot0.scrollHelper:StartScroll(#slot0.dataList_)
	slot0:RefreshSelect()
end

function slot0.RefreshSelect(slot0)
	if slot0.dataList_[slot0.selectInex_] then
		slot0.tipText_.text = string.format(GetTips("TIP_SELECT"), ItemTools.getItemName(slot1[1]))

		slot0.okBtnController_:SetSelectedState("state1")
	else
		slot0.tipText_.text = GetTips("SELECT_CURRENT")

		slot0.okBtnController_:SetSelectedState("state0")
	end
end

function slot0.OnTryToUseItem(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot3 = slot0.dataList_[slot0.selectInex_]

		JumpTools:Back()
		getReward(slot1.drop_list, {
			ItemConst.ITEM_TYPE.HERO,
			ItemConst.ITEM_TYPE.HERO_SKIN
		})
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnExit(slot0)
	slot0.selectInex_ = 0
	slot0.lastSelectItem_ = nil
end

function slot0.Dispose(slot0)
	slot0.scrollHelper:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
