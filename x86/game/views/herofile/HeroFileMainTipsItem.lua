slot0 = class("HeroFileMainTipsItem", ReduxView)

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

	slot0.unlockStateController_ = slot0.btnControllerEx_:GetController("unlock")
	slot0.rewardItem_ = CommonItemView.New(slot0.item_)
end

function slot0.AddUIListener(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	if slot1 <= ArchiveData:GetTrustLevel(slot2) then
		slot0.unlockStateController_:SetSelectedState("unlock")
	else
		slot0.unlockStateController_:SetSelectedState("lock")
	end

	slot0.titleText_.text = ArchiveTools.GetTrustLvDes(slot1)

	if HeroTrustCfg.get_id_list_by_hero_id[slot2][slot1 - 1] then
		if HeroTrustCfg[slot6].reward_item_list[1] then
			slot9 = clone(ItemTemplateData)
			slot9.id = slot8[1]
			slot9.number = slot8[2]

			function slot9.clickFun()
				ShowPopItem(POP_ITEM, {
					uv0.id
				})
			end

			slot0.rewardItem_:SetData(slot9)
			SetActive(slot0.item_, true)

			return
		end

		SetActive(slot0.item_, false)
	else
		SetActive(slot0.item_, false)
	end
end

function slot0.Dispose(slot0)
	if slot0.rewardItem_ then
		slot0.rewardItem_:Dispose()

		slot0.rewardItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
