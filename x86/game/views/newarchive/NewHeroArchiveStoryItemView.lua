slot0 = class("NewHeroArchiveStoryItemView", ReduxView)

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

	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "btn")

	slot0:AddUIListener()
	slot0:RegistEventListener(UPDATE_ANDOTE, function ()
		uv0:RefreshUI()
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not uv0.isUnlock then
			ShowTips(string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), HeroCfg[uv0.data_.id].name, GetTips("HERO_TRUST_LEVEL_DES_" .. uv0.all)))
		else
			if not uv0.isViewed then
				uv0.callBackHandler = handler(uv0, function ()
					uv0:RefreshUI()
				end)
			end

			JumpTools.GoToSystem("newHeroStory", {
				data = uv0.data_,
				callback = uv0.callBackHandler,
				archiveID = uv0.archiveID_
			})
		end

		manager.redPoint:setTip(RedPointConst.HERO_ANEDOTE_ID .. uv0.data_.id, 0)
	end)
	slot0:AddBtnListener(slot0.heroPieceBtn_, nil, function ()
		ShowPopItem(POP_ITEM, {
			tonumber("1" .. uv0.data_.id)
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.archiveID_ = slot2

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.title_.text = string.format(GetTips("HERO_ANECDOTE_TITLE"), HeroCfg[slot0.data_.id].name)
	slot0.rewardText_.text = "x" .. slot0.data_.reward[1][2]
	slot0.rewardIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Piece/" .. slot0.data_.id)
	slot3, slot4 = nil
	slot0.isUnlock, slot3, slot0.all = IsConditionAchieved(GameSetting.hero_anecdote_unlock_condition.value[1], {
		heroId = slot0.data_.id
	})
	slot0.isViewed = ArchiveData:IsArchiveStoryRead(slot0.archiveID_, slot0.data_.id)

	if slot0.isUnlock then
		slot0.lockController_:SetSelectedState("yes")

		if slot0.isViewed then
			slot0.lockController_:SetSelectedState("get")
		end
	else
		slot0.lockText_.text = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), slot1.name, GetTips("HERO_TRUST_LEVEL_DES_" .. slot0.all))

		slot0.lockController_:SetSelectedState("no")
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()
	uv0.super.Dispose(slot0)
end

return slot0
