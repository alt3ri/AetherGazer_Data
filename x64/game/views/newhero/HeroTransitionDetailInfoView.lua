slot0 = class("HeroTransitionDetailInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

slot0.asciiMap = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ",
	"Ⅵ"
}

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.jumpNumController_ = slot0.barController_:GetController("num")
	slot0.jumpPosController_ = slot0.posController_:GetController("pos")
	slot0.lockController_ = slot0.contentController_:GetController("lock")
	slot0.emptyController_ = slot0.contentController_:GetController("empty")
	slot0.isSelfController_ = slot0.contentController_:GetController("isSelf")
	slot0.transitionItemList_ = {}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		JumpTools.OpenPageByJump("/transitionSkill", {
			index = uv0.info_.slotIdx,
			heroID = uv0.heroID_,
			type_ = uv0.heroViewProxy_:GetViewDataType()
		})
	end)
end

function slot0.SetSlotInfo(slot0, slot1)
	slot0.info_ = slot1

	slot0:UpdateView()
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1
	slot0.heroID_ = slot1.id
end

function slot0.UpdateView(slot0)
	if not slot0.info_ then
		return
	end

	slot0.jumpPosController_:SetSelectedState(slot0.info_.slotIdx)
	slot0.lockController_:SetSelectedState(slot0.info_.isLock and "true" or "false")
	slot0.emptyController_:SetSelectedState(#slot0.info_.skills == 0 and "true" or "false")
	slot0.isSelfController_:SetSelectedState(slot0.heroViewProxy_.isSelf and "true" or "false")
	SetActive(slot0.lockRootObj_, slot0.heroViewProxy_.isSelf)

	slot1 = slot0.info_.totalPoint

	for slot6, slot7 in ipairs(slot0.info_.skills) do
		slot2 = 0 + slot7.level
	end

	slot0.jumpNumController_:SetSelectedState(slot2)

	slot0.numText_.text = table.concat({
		slot2,
		"/",
		slot1
	})
	slot6 = GetTips("EXCLUSIVE_CORE")
	slot7 = slot0.asciiMap[slot0.info_.slotIdx]
	slot0.nameText_.text = string.format(slot6, slot7)

	for slot6, slot7 in ipairs(slot0.transitionItemList_) do
		SetActive(slot7.gameObject_, false)
	end

	slot3 = 1

	for slot7, slot8 in ipairs(slot0.info_.skills) do
		if not slot0.transitionItemList_[slot3] then
			slot10 = HeroTransitionItem.New(Object.Instantiate(slot0.jumpItemGo_, slot0.jumpItemListTrs_, false))

			slot10:SetData(slot8)
			table.insert(slot0.transitionItemList_, slot10)
		else
			slot0.transitionItemList_[slot3]:SetData(slot8)
		end

		SetActive(slot0.transitionItemList_[slot3].gameObject_, true)

		slot3 = slot3 + 1
	end
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewProxy_ = slot1

	slot0:RegistEventListener(HERO_TRANSITION_CHANGE, handler(slot0, slot0.OnHeroModify))
end

function slot0.OnExit(slot0)
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroInfo_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	for slot4, slot5 in ipairs(slot0.transitionItemList_) do
		if slot5 then
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
