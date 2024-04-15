slot0 = class("NewHeroWallPaperItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.roleController_ = ControllerUtil.GetController(slot0.transform_, "role")

	slot0:AddUIListener()
end

function slot0.OnTop(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickCallBack_ then
			SDKTools.SendMessageToSDK("chain_story_picture_change", {
				chain_story_picture_id = uv0.roleName_.text,
				record_id = uv0.data_.id
			})
			uv0.clickCallBack_(uv0.id_, uv0.type_)
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		ShowTips(uv0.lockTips_)
	end)
end

function slot0.SetClickFunc(slot0, slot1)
	slot0.clickCallBack_ = slot1
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data_ = slot1
	slot0.index_ = slot2
	slot0.id_ = slot1.id
	slot0.type_ = slot1.type
	slot0.archiveID_ = slot3

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if ArchiveData:GetSelectPicture(slot0.archiveID_).id == slot0.id_ then
		slot0.roleController_:SetSelectedState("yes")
	elseif slot1.id ~= slot0.id_ then
		slot0.roleController_:SetSelectedState("no")
	end

	slot0.lockPicGo_:SetActive(false)

	if not ArchiveTools.CheckWallPaperIsUnlock(slot0.data_) then
		slot0.roleController_:SetSelectedState("lock")

		if slot0.type_ == 3 then
			slot0.lockPicGo_:SetActive(true)
		else
			slot0.lockPicGo_:SetActive(false)
		end
	end

	if slot0.type_ == 1 then
		slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.id_)
		slot0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_HERO")
		slot0.roleName_.text = HeroCfg[slot0.data_.id].name
		slot0.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_HERO_NAME"), HeroCfg[slot0.data_.id].name)
	elseif slot0.type_ == 2 then
		slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.id_)
		slot0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_SKIN")
		slot0.roleName_.text = SkinCfg[slot0.data_.id].name
		slot0.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_SKIN_NAME"), SkinCfg[slot0.data_.id].name)
	elseif slot0.type_ == 3 then
		slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/IllustratedHandbook/Portrait/" .. CollectPictureCfg[slot0.id_].picture)
		slot0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_PICTURE")
		slot0.roleName_.text = CollectPictureCfg[slot0.data_.id].name
		slot0.lockTips_ = string.format(GetTips("HERO_HEART_CHAIN_PLOT_COVER_UNLOCK_PICTURE_NAME"), CollectPictureCfg[slot0.data_.id].name)
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
