slot0 = class("MythicFinalTeamViewItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.teamSwapController_ = ControllerUtil.GetController(slot0.transform_, "place")
	slot0.teamChangeController_ = ControllerUtil.GetController(slot0.transform_, "change")
	slot0.chipController_ = ControllerUtil.GetController(slot0.chipbtnBtn_.transform, "name")
	slot0.godUpController_ = ControllerUtil.GetController(slot0.godupBtn_.transform, "name")
	slot4 = "name"
	slot0.aoyiController_ = ControllerUtil.GetController(slot0.aoyiBtn_.transform, slot4)
	slot0.heroHead_ = {}
	slot0.heroHeadCon_ = {}

	for slot4 = 1, 3 do
		slot0.heroHead_[slot4] = TeamHeroShortHead.New(slot0["newherohead" .. slot4 .. "Btn_"].gameObject)

		slot0.heroHead_[slot4]:SetProxy(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT))
		slot0.heroHead_[slot4]:SetRedPointEnable(false)

		slot0.heroHeadCon_[slot4] = ControllerUtil.GetController(slot0["newherohead" .. slot4 .. "Btn_"].transform, "switch")
	end
end

function slot0.AddListeners(slot0)
	slot4 = slot0.chipbtnBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		if not MythicData:GetIsBattleIng() then
			JumpTools.GoToSystem("/battleChipManager", {
				stageType = uv0.stageType_,
				stageID = uv0.stageID_,
				activityID = uv0.activityID_,
				reserveParams = uv0.reserveParams_
			})
		end
	end)

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["newherohead" .. slot4 .. "Btn_"], nil, function ()
			if not MythicData:GetIsBattleIng() then
				uv0:Go("/mythicHeroTeamInfoView", {
					isEnter = false,
					canCleanTeam = true,
					selectHeroPos = uv1,
					stageID = uv0.stageID_,
					stageType = uv0.stageType_,
					teamLength = uv0.teamLength_,
					reserveParams = uv0.reserveParams_,
					type = HeroConst.HERO_DATA_TYPE.DEFAULT
				})
			end
		end)
	end

	slot0:AddBtnListener(slot0.godupBtn_, nil, function ()
		slot0, slot1, slot2 = BattleTools.GetMaxRaceData(uv0.heroList_)

		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = slot0,
			sameCamp = slot2
		})
	end)
	slot0:AddBtnListener(slot0.aoyiBtn_, nil, function ()
		JumpTools.OpenPageByJump("sectionComboSelect", {
			stageType = uv0.stageType_,
			stageID = uv0.stageID_,
			heroList = uv0.heroList_,
			trialList = {
				0,
				0,
				0
			},
			comboSkillID = uv0.comboSkillID_,
			sectionProxy = uv0.sectionProxy_
		})
	end)
	slot0:AddBtnListener(slot0.changebtn_, nil, function ()
		if not MythicData:GetIsBattleIng() and uv0.changefunc_ then
			uv0.changefunc_(uv0.teamID_)
		end
	end)
	slot0:AddBtnListener(slot0.confirmbtn_, nil, function ()
		if not MythicData:GetIsBattleIng() and uv0.confirmfunc_ then
			uv0.confirmfunc_(uv0.teamID_)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.teamLength_ = slot3
	slot0.teamID_ = slot1
	slot0.stageID_ = slot2
	slot0.stageType_ = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL
	slot0.reserveParams_ = ReserveParams.New(ReserveConst.RESERVE_TYPE.MYTHIC_FINAL, ReserveConst.MYTHIC_CONT_ID.FINAL_MULTI, slot0.teamID_, {
		stageType = BattleConst.STAGE_TYPE_NEW.MYTHIC_FINAL,
		stageID = slot2
	})

	if not slot0.sectionProxy_ then
		slot0.sectionProxy_ = SectionSelectHeroTools.GetProxy({
			stageType = slot0.stageType_,
			stageID = slot0.stageID_
		}, slot0.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	else
		slot0.sectionProxy_:Init({
			stageType = slot0.stageType_,
			stageID = slot0.stageID_
		}, slot0.reserveParams_, HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	slot0.heroList_ = ReserveTools.GetHeroList(slot0.reserveParams_)
	slot4, slot5 = ReserveTools.GetMimirData(slot0.reserveParams_)
	slot0.comboSkillID_ = ReserveTools.GetComboSkillID(slot0.reserveParams_)
	slot6 = slot0:GetRaceEffect()

	for slot10 = 1, 3 do
		if slot0.heroList_[slot10] ~= 0 then
			slot0.heroHead_[slot10]:SetHeroId(slot0.heroList_[slot10])
			slot0.heroHeadCon_[slot10]:SetSelectedState("1")
		else
			slot0.heroHeadCon_[slot10]:SetSelectedState("0")
		end
	end

	if slot4 == 0 then
		slot0.chipController_:SetSelectedState("false")
		SetActive(slot0.subchip1Img_.gameObject, false)
		SetActive(slot0.subchip2Img_.gameObject, false)
	else
		slot0.chipController_:SetSelectedState("true")

		slot11 = "TextureConfig/Managecat_s/" .. ChipCfg[slot4].picture_id
		slot0.chipiconImg_.sprite = getSpriteWithoutAtlas(slot11)

		for slot11 = 1, 2 do
			if slot5[slot11] then
				SetActive(slot0["subchip" .. slot11 .. "Img_"].gameObject, true)

				slot0["subchip" .. slot11 .. "Img_"].sprite = getSpriteViaConfig("ChipSkillIcon", ChipCfg[slot5[slot11]].picture_id)
			else
				SetActive(slot0["subchip" .. slot11 .. "Img_"].gameObject, false)
			end
		end
	end

	slot0.godUpController_:SetSelectedState(slot6 == 0 and "off" or "on")
	slot0.aoyiController_:SetSelectedState(slot0.comboSkillID_ == 0 and "off" or "on")

	slot0.bianduiText_.text = GetTips("TEAM_" .. slot1)

	if MythicData:GetIsBattleIng() then
		slot0.teamChangeController_:SetSelectedState("false")
	else
		slot0.teamChangeController_:SetSelectedState("true")
	end
end

function slot0.GetRaceEffect(slot0)
	slot1 = {}
	slot2 = 0
	slot3 = false

	for slot8, slot9 in pairs(ReserveTools.GetHeroList(slot0.reserveParams_)) do
		if slot9 ~= 0 then
			slot1[slot10] = (slot1[HeroCfg[slot9].race] or 0) + 1

			if slot1[slot10] == 2 then
				slot2 = slot10
			elseif slot1[slot10] == 3 then
				slot3 = true
			end
		end
	end

	return slot2, slot3, slot1[slot2] or 1
end

function slot0.OnChangeRefreshStatus(slot0, slot1)
	if slot1 == slot0.teamID_ then
		slot0.teamSwapController_:SetSelectedState("select")
	else
		slot0.teamSwapController_:SetSelectedState("change")
	end
end

function slot0.ResetState(slot0)
	slot0.teamSwapController_:SetSelectedState("off")
end

function slot0.RegionHandler(slot0, slot1, slot2)
	slot0.changefunc_ = slot1
	slot0.confirmfunc_ = slot2
end

function slot0.Dispose(slot0)
	for slot4 = 1, 3 do
		slot0.heroHead_[slot4]:Dispose()
	end

	slot0.changefunc_ = nil
	slot0.confirmfunc_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
