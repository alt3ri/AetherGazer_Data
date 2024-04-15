slot0 = class("MythicFinalRankHeroItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:initUI()
	slot0:AddUIListeners()
end

function slot0.AddUIListeners(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["heroBtn_" .. slot4], nil, function ()
			ForeignInfoAction:TryToCheckForeignHeroInfo(uv0.userID_, _, 3, function ()
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					notShowBar = true,
					hid = uv0.herolist_[uv1].id,
					type = HeroConst.HERO_DATA_TYPE.FOREIGN
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end)
	end
end

function slot0.initUI(slot0)
	slot0:BindCfgUI()

	slot0.countcontroller_ = slot0.conExCollection_:GetController("heroCount")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.userID_ = slot3
	slot0.herolist_ = slot2
	slot8 = slot1
	slot0.teamText_.text = GetTips("TEAM_" .. slot8)
	slot7 = #slot2

	slot0.countcontroller_:SetSelectedState(slot7)

	for slot7, slot8 in pairs(slot2) do
		if slot8.skin_id == 0 then
			slot9 = slot8.id
		end

		slot0["heroImg_" .. slot7].sprite = ItemTools.getItemSprite(slot9)
	end
end

return slot0
