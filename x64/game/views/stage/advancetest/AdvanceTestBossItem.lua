slot0 = class("AdvanceTestBossItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.difficultyController_ = ControllerUtil.GetController(slot0.transform_, "difficulty")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_()
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = AdvanceTestData:GetCurCfgByIndex(slot1)
	slot3 = slot2.stage_target
	slot0.nameText_.text = string.format(GetTips("TEST_CHALLENGE_TIPS_2"), GetMonsterName({
		slot3
	}))
	slot0.descText_.text = MonsterCfg[slot3].desc
	slot0.riskText_.text = slot0:GetTipsByCfg(slot2)
	slot0.bossImg_.sprite = getSpriteWithoutAtlas(SpritePathCfg.CollectBoss.path .. slot3)

	if slot0:SetLimitTextTop(slot2) ~= "" then
		slot0.limitText_.text = slot5 .. "\n" .. string.format(GetTips("TEST_CHALLENGE_TIPS_1"), slot0:GetStrByCharacterStar(slot2.character), slot2.weapon)
	else
		slot0.limitText_.text = slot6
	end

	slot0.difficultyController_:SetSelectedState(slot1)
end

function slot0.SetLimitTextTop(slot0, slot1)
	slot2 = ""

	for slot8 = 1, #slot1.limit_hero do
		slot9 = slot3[slot8]
		slot10 = slot9[1]

		for slot16, slot17 in pairs(slot9[2]) do
			slot12 = "" .. HeroCfg[slot17].name .. "·" .. HeroCfg[slot17].suffix .. " "
		end

		if slot10 == 1 then
			slot2 = slot2 .. string.format(GetTips("TEST_CHALLENGE_MAIN_HERO_LIMIT"), string.gsub(slot12, "^[%s]*(.-)[%s]*$", "%1"))
		elseif slot10 == 2 then
			slot2 = slot2 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_1"), slot12)
		elseif slot10 == 3 then
			slot2 = slot2 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_1"), slot12)
		elseif slot10 == 4 then
			slot2 = ""
		elseif slot10 == 5 then
			slot2 = slot2 .. string.format(GetTips("TEST_CHALLENGE_BAN_HERO"), slot12)
		elseif slot10 == 6 then
			slot2 = slot2 .. string.format(GetTips("TEST_CHALLENGE_OTHER_HERO_LIMIT_2"), slot12)
		elseif slot10 == 7 then
			slot2 = slot2 .. string.format(GetTips("TEST_CHALLENGE_HERO_LIST_LIMIT_2"), slot12)
		end

		if slot8 ~= slot4 then
			slot2 = slot2 .. "\n"
		end
	end

	return slot2
end

function slot0.GetTipsByCfg(slot0, slot1)
	slot2 = nil

	if slot1.stage_type == 1 then
		slot2 = GetTips("TEST_CHALLENGE_TIPS_3")
	elseif slot1.stage_type == 2 then
		slot2 = GetTips("TEST_CHALLENGE_TIPS_4")
	elseif slot1.stage_type == 3 then
		slot2 = GetTips("TEST_CHALLENGE_TIPS_5")
	end

	return slot2
end

function slot0.GetStrByCharacterStar(slot0, slot1)
	slot2 = nil

	if slot1 == 400 then
		slot2 = "SS"
	elseif slot1 == 500 then
		slot2 = "SSS"
	elseif slot1 == 600 then
		slot2 = "Ω"
	end

	return slot2
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

return slot0
