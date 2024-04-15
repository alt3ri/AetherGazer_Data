slot0 = singletonClass("BackHomeDataManager")
slot1, slot2 = nil
slot3 = {
	[DormEnum.DormSystemType.Canteen] = CanteenData,
	[DormEnum.DormSystemType.Dormitory] = DormitoryData,
	[DormEnum.DormSystemType.CricketBattle] = BackHomeCricketBattleData
}

function slot0.Init(slot0)
	uv0 = DormEnum.DormSystemType.Main
	uv1 = false
end

function slot0.InitAllSampleData(slot0, slot1)
	DormData:InitSimplaDormData(slot1)

	if not uv0 then
		DormitoryData:InitSimpleDormInfo(slot1)
	end

	CanteenData:InitSimpleCanteenInfo(slot1)
	BackHomeCricketBattleData:InitSimpleCricketBattleInfo(slot1)
	DormSkillData:Init()
end

function slot0.InitAllDetailData(slot0, slot1)
	DormData:InitDetailDormData(slot1)
	CanteenData:InitDetailCanteenData(slot1)
	DormitoryData:InitDetialDormData(slot1)
	BackHomeCricketBattleData:InitDetailCricketBattleData(slot1)
	DormSkillData:Init()
end

function slot0.EnterBackHomeSystem(slot0, slot1, slot2, slot3)
	if not uv0 then
		uv0 = true

		DormVisitTools:SetIsOtherSystem(slot3 or false)
		BackHomeAction:GetAllDetailInfo(slot1, slot2)
	elseif slot1 then
		slot1(slot2)
	end
end

function slot0.ExitBackHomeSystem(slot0, slot1, slot2)
	uv0 = false

	if uv1 ~= DormEnum.DormSystemType.Main then
		uv2[uv1]:ExitCurSystem()
	end

	uv1 = DormEnum.DormSystemType.Main

	DormData:SetCurrentScene(nil)
	CanteenData:ExitBackHomeSystem()
	DormitoryData:ExitBackHomeSystem()
	BackHomeCricketBattleData:ExitBackHomeSystem()

	if slot1 then
		slot1(slot2)
	end
end

function slot0.OtherSystemVisitBack(slot0)
	uv0 = false

	if uv1 ~= DormEnum.DormSystemType.Main then
		uv2[uv1]:ExitCurSystem()
	end

	uv1 = DormEnum.DormSystemType.Main

	DormData:SetCurrentScene(nil)
	CanteenData:ExitBackHomeSystem()
	DormitoryData:ExitBackHomeSystem()
	DormitoryData:OtherSystemVisitBack()
end

function slot0.ChangeCurSystem(slot0, slot1, slot2)
	if slot2 then
		uv0 = DormEnum.DormSystemType.CricketBattle

		if uv0 ~= uv0 then
			if slot3 ~= DormEnum.DormSystemType.Main then
				uv1[slot3]:ExitCurSystem()
			end

			if uv0 ~= DormEnum.DormSystemType.Main then
				uv1[uv0]:EnterCurSystem()
			end
		end

		return
	end

	if slot1 then
		slot4 = uv0

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.Canteen then
			uv0 = DormEnum.DormSystemType.Canteen
		elseif slot3 == DormConst.BACKHOME_TYPE.PublicDorm then
			uv0 = DormEnum.DormSystemType.Dormitory
		elseif slot3 == DormConst.BACKHOME_TYPE.PrivateDorm then
			uv0 = DormEnum.DormSystemType.Dormitory
		end

		if slot4 ~= uv0 then
			if slot4 ~= DormEnum.DormSystemType.Main then
				uv1[slot4]:ExitCurSystem()
			end

			if uv0 ~= DormEnum.DormSystemType.Main then
				uv1[uv0]:EnterCurSystem()
			end
		end
	end
end

function slot0.GotoBackHomeScene(slot0, slot1)
	if slot1 then
		BackHomeAction:CheckToEnterDormScene(slot1)
		slot0:ChangeCurSystem(slot1)
	end
end

function slot0.GotoBackHomeCricketStage(slot0, slot1, slot2)
	if slot1 == BackHomeCricketConst.ROOM_TYPE.TRAIN then
		DormMinigame.Launch("WT_RK")
		slot0:ChangeCurSystem(nil, true)
		DormData:SetCurrentScene(nil)

		return
	end

	if slot2 and uv0 == DormEnum.DormSystemType.CricketBattle then
		slot3 = nil

		DormMinigame.Launch(((slot1 ~= BackHomeCricketConst.ROOM_TYPE.PVP_STAGE or IdolTraineePvpBattleCfg) and IdolTraineePveBattleCfg)[slot2].scene_name, DanceGameBridge)
	end
end

function slot0.GetCurSystem(slot0)
	return uv0
end

return slot0
