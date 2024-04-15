slot0 = class("ShowHeroPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/UserInfor/HeroshowUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ShowHeroPopItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.list_[slot1], slot0.isForeign_)
	slot2:RegistClickFunction(function ()
		if manager.windowBar:GetWhereTag() ~= nil then
			if not uv0.isForeign_ then
				ShowTips("PROFILE_ROLES_SET_PROMPT")
			end

			return
		end

		if not uv0.isForeign_ then
			JumpTools.OpenPageByJump("/HeroShowChange", {
				heroID = uv0.list_[uv1].hero_id ~= 0 and uv0.list_[uv1].hero_id or nil
			})
		elseif uv0.list_[uv1].hero_id ~= 0 then
			ForeignInfoAction:TryToCheckForeignHeroInfo(uv0.userID_, slot0, 1, function ()
				JumpTools.OpenPageByJump("/newHero", {
					pageIndex = 1,
					isEnter = true,
					notShowBar = true,
					hid = uv0,
					type = HeroConst.HERO_DATA_TYPE.FOREIGN
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.list_ = {}
	slot0.userID_ = slot0.params_.userID
	slot0.isForeign_ = slot0.params_.isForeign

	if not slot0.isForeign_ then
		for slot5, slot6 in ipairs(PlayerData:GetHeroShowList()) do
			slot7 = HeroData:GetHeroData(slot6)
			slot0.list_[slot5] = {
				hero_id = slot6,
				star = slot7.star,
				level = slot7.level,
				using_skin = slot7.using_skin
			}
		end
	else
		for slot5, slot6 in ipairs(slot0.params_.heroList) do
			slot0.list_[slot5] = slot6
		end
	end

	for slot4 = #slot0.list_ + 1, 3 do
		slot0.list_[slot4] = {
			hero_id = 0,
			star = 0,
			level = 0,
			using_skin = 0
		}
	end

	slot0.scrollHelper_:StartScroll(#slot0.list_)
	CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
end

function slot0.OnExit(slot0)
	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllEventListener()

	slot3 = slot0.scrollHelper_
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.GetItemList(slot5)) do
		slot5:Dispose()
	end

	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
