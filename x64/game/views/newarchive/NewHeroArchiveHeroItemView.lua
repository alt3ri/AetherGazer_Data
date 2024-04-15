slot0 = class("NewHeroArchiveHeroItemView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.index = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.superController_ = ControllerUtil.GetController(slot0.transform_, "super")
	slot0.profileController_ = ControllerUtil.GetController(slot0.transform_, "profile")
	slot0.maskController_ = ControllerUtil.GetController(slot0.transform_, "mask")
end

function slot0.OnTop(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = uv0.data_.archive_id
		})
		SDKTools.SendMessageToSDK("chain_story_enter", {
			chain_story_enter_source = 2,
			record_id = uv0.data_.archive_id
		})

		if uv0.callback then
			uv0.callback()
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		ShowTips(string.format(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_HERO"), HeroCfg[uv0.recordData_.hero_id[1]].suffix))
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.recordData_ = HeroRecordCfg[slot0.data_.archive_id]
	slot0.heroIdList_ = slot0.recordData_.hero_id
	slot0.type_ = slot2

	slot0:RefreshUI()
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.callback = slot1
end

function slot0.RefreshUI(slot0)
	if not slot0.favorItemList_ then
		slot0.favorItemList_ = {}
	end

	slot1 = 0

	for slot5, slot6 in ipairs(slot0.favorItemList_) do
		SetActive(slot6.gameObject_, false)
		slot6:ResetData()
	end

	slot2 = false

	for slot6, slot7 in ipairs(slot0.heroIdList_) do
		if ArchiveData:GetTrustLevel(slot7) > 0 then
			slot2 = true
		end
	end

	for slot6, slot7 in ipairs(slot0.heroIdList_) do
		if HeroData:GetHeroData(slot0.heroIdList_[slot6]).unlock == 1 then
			if not slot0.favorItemList_[slot1 + 1] then
				slot10 = NewHeroArchiveHerofavorItemView.New(Object.Instantiate(slot0.favorabilityItem_), slot1)

				slot10.transform_:SetParent(slot0.favorabilityList_, false)
				table.insert(slot0.favorItemList_, slot10)
			end

			slot0.data_ = ArchiveData:GetArchive(slot0.data_.archive_id)

			slot0.favorItemList_[slot1]:SetData(slot0.data_, slot8.id, slot1)
			SetActive(slot0.favorItemList_[slot1].gameObject_, true)
		end
	end

	slot0:SetRoleImg()

	for slot6, slot7 in ipairs(slot0.favorItemList_) do
		slot7:RefreshUI(slot2)
	end

	if slot1 == 0 then
		slot0.maskController_:SetSelectedState("true")
	else
		slot0.maskController_:SetSelectedState("false")
	end

	if table.isEmpty(slot0.recordData_.super_plot_id) then
		slot0.superController_:SetSelectedState("no")
	else
		slot0.superController_:SetSelectedState("yes")
	end

	for slot7, slot8 in pairs(slot0.data_.video_list) do
		slot3 = 0 + 1
	end

	slot0.heartText_.text = slot3 + #ArchiveData:GetHasViewedSuperHeartList(slot0.data_.archive_id) .. "/" .. #slot0.recordData_.plot_id + #slot0.recordData_.super_plot_id

	if not table.isEmpty(ArchiveData:GetAnedoteList(slot0.heroIdList_)) then
		slot0.profileController_:SetSelectedState("yes")

		slot0.profileText_.text = #ArchiveData:GetIsViewedArhiveStoryList(slot0.data_.archive_id) .. "/" .. #slot5
	else
		slot0.profileController_:SetSelectedState("no")
	end

	slot0.nameText_.text = slot0.recordData_.name

	manager.redPoint:unbindUIandKey(slot0.redPoint_)
	manager.redPoint:bindUIandKey(slot0.redPoint_, RedPointConst.HERO_HEART_STORY_ROOT_ID .. slot0.data_.archive_id)
end

function slot0.SetRoleImg(slot0)
	if table.isEmpty(ArchiveData:GetSelectPicture(slot0.data_.archive_id)) or slot1.type == 0 then
		for slot6, slot7 in ipairs(slot0.heroIdList_) do
			if HeroData:GetHeroData(slot7).unlock == 1 and not false then
				slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot7)
				slot2 = true
			end
		end

		if not slot2 then
			slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.heroIdList_[1])
		end

		return
	end

	if slot1.type == 1 or slot1.type == 2 then
		slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot1.id)
	elseif slot1.type == 3 then
		slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/IllustratedHandbook/Portrait/" .. CollectPictureCfg[slot1.id].picture)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.redPoint_)

	if slot0.favorItemList_ then
		for slot4, slot5 in ipairs(slot0.favorItemList_) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
