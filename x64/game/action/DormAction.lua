slot1, slot2 = nil
slot3 = nil
slot4 = nil
slot5 = nil

manager.net:Bind(58157, function (slot0)
	DormSuitData:RefreshUnLockSuitList(slot0.suit_id_list)
end)

return {
	SetFurListInMap = function (slot0, slot1, slot2, slot3)
		if slot2 == nil then
			slot4 = {}
			uv0 = slot3.furInfoList
			slot5 = {}
			slot6 = {}
			slot7 = {}
			slot8 = {}
			slot10 = {
				architecture_id = slot1,
				furniture_layout = {
					temp_id = 0
				}
			}

			for slot14 = 0, slot3.furInfoList.Length - 1 do
				if DormFurnitureTools:CheckFurTileType(slot4[slot14].id, slot4[slot14].tileType) then
					if slot4[slot14].tileType == DormConst.TILE_TYPE.FLOOR then
						table.insert({}, {
							furniture_id = slot4[slot14].id,
							x = math.floor(slot4[slot14].pos.x * DormConst.POS_PRECISION),
							y = math.floor(slot4[slot14].pos.y * DormConst.POS_PRECISION),
							rotation = math.floor(slot4[slot14].rotation * DormConst.POS_PRECISION)
						})
					elseif slot4[slot14].tileType == DormConst.TILE_TYPE.WALL_LEFT then
						table.insert(slot5, slot15)
					elseif slot4[slot14].tileType == DormConst.TILE_TYPE.WALL_RIGHT then
						table.insert(slot6, slot15)
					elseif slot4[slot14].tileType == DormConst.TILE_TYPE.WALL_BEHIND then
						table.insert(slot8, slot15)
					elseif slot4[slot14].tileType == DormConst.TILE_TYPE.WALL_FRONT then
						table.insert(slot7, slot15)
					end
				else
					uv0 = nil

					print("同步家具失败，" .. slot4[slot14].id .. "家具所在地块和配置地块不匹配")

					return
				end
			end

			if slot3.specialInfo then
				for slot15, slot16 in pairs(slot11) do
					table.insert(slot9, {
						rotation = 0,
						x = 0,
						y = 0,
						furniture_id = slot16
					})
				end
			end

			if slot3.suitInfo then
				uv1 = slot3.suitInfo
				slot13 = {}

				for slot17, slot18 in pairs(slot3.suitInfo) do
					if slot17 > 1000 then
						table.insert(slot9, {
							furniture_id = slot17,
							x = math.floor(slot18.pos.x * DormConst.POS_PRECISION),
							y = math.floor(slot18.pos.y * DormConst.POS_PRECISION),
							rotation = math.floor(slot18.pos.rotation * DormConst.POS_PRECISION)
						})
						table.insert(slot13, slot17)
					end
				end

				SDKTools.SendMessageToSDK("backhome_dorm_edit", {
					suit_list = slot13
				})
			end

			slot10.furniture_layout.furniture_pos_list = {
				{
					default_suit_id = 0,
					type = 1,
					furniture_pos = slot5
				},
				{
					default_suit_id = 0,
					type = 2,
					furniture_pos = slot6
				},
				{
					default_suit_id = 0,
					type = 3,
					furniture_pos = slot7
				},
				{
					default_suit_id = 0,
					type = 4,
					furniture_pos = slot8
				},
				{
					default_suit_id = 0,
					type = 5,
					furniture_pos = slot9
				}
			}

			if slot3.suitInfo then
				slot13 = 100

				for slot17, slot18 in pairs(slot3.suitInfo) do
					if slot17 < 1000 then
						slot19 = {
							type = slot13
						}
						slot20 = {}

						for slot24 = 0, slot18.furList.Length - 1 do
							table.insert(slot20, {
								furniture_id = slot18.furList[slot24].id,
								x = math.floor(slot18.furList[slot24].pos.x * DormConst.POS_PRECISION),
								y = math.floor(slot18.furList[slot24].pos.y * DormConst.POS_PRECISION),
								rotation = math.floor(slot18.furList[slot24].rotation * DormConst.POS_PRECISION)
							})
						end

						slot19.furniture_pos = slot20

						if slot18.oriSuitID then
							slot19.default_suit_id = slot18.oriSuitID
						else
							slot19.default_suit_id = 0
						end

						slot13 = slot13 + 1

						table.insert(slot10.furniture_layout.furniture_pos_list, slot19)
					end
				end
			end

			if DormData:GetDevModelFlag() then
				DormSuitTools:SerializeDormSuitData(clone(slot10.furniture_layout.furniture_pos_list), DormSuitData:GetSuitSerializeData())
			end

			manager.net:SendWithLoadingNew(58010, slot10, 58011, uv2.SetFurListInMapCallBack)
		else
			manager.net:SendWithLoadingNew(58010, {
				architecture_id = slot1,
				furniture_layout = {
					temp_id = slot2,
					furniture_pos_list = {}
				}
			}, 58011, uv2.SetFurListInMapCallBack)
		end
	end,
	SetFurListInMapCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = nil

			if not uv0 then
				slot4 = DormFurnitureTemplateData:GetDormTemplateInfo(slot1.furniture_layout.temp_id)
				uv0 = slot4:GetDormTemplateFurList()

				for slot9, slot10 in pairs(slot4:GetTemplateWallAndFloorInfo()) do
					table.insert({}, {
						furniture_id = slot10
					})
				end
			end

			DormFurEditStateData:SyncRoomFurniture(slot1, uv0, slot2, uv1)
			DormLuaBridge.SyncRoomFurniture(uv0)

			uv0 = nil
			uv1 = nil
		end
	end,
	UnLockDormArchitecture = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58130, {
			architecture_id = slot1,
			pos_id = slot2
		}, 58131, uv0.UnLockDormArchitectureCallBack)
	end,
	UnLockDormArchitectureCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:UnLockDormArchitecture(slot1.architecture_id, slot1.pos_id)
			DormRedPointTools:CheckUnLockEntrustRedPoint()
			manager.notify:Invoke(DORM_PRIVATE_DORM_CHANGE, slot1.architecture_id)
		else
			ShowTips(slot0.result)
		end
	end,
	DeployHeroInRoom = function (slot0, slot1, slot2, slot3)
		uv0 = slot3
		slot4 = {}

		for slot8, slot9 in ipairs(slot2) do
			table.insert(slot4, slot9)
		end

		manager.net:SendWithLoadingNew(58132, {
			architecture_id = slot1,
			hero_id = slot4
		}, 58133, uv1.DeployHeroInRoomCallBack)
	end,
	DeployHeroInRoomCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			if uv0 == DormEnum.DormDeployType.Place then
				DormData:RefreshInDormHeroInfo(slot1.architecture_id, slot1.hero_id)
				manager.notify:Invoke(DORM_DRAG_HERO_SUCCESS)
				manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
			elseif uv0 == DormEnum.DormDeployType.ReCall then
				DormData:RefreshInDormHeroInfo(slot1.architecture_id, slot1.hero_id)
				DormHeroTools:ReGenerateDormHeroEntity()
				manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
			elseif uv0 == DormEnum.DormDeployType.Occupy then
				DormData:RefreshInDormHeroInfo(slot1.architecture_id, slot1.hero_id, true)

				slot3 = DormData:GetHeroArchiveID(slot1.hero_id[1])

				DormData:GetHeroInfo(slot3):InitHeroRoomID(slot1.architecture_id)
				DormRoomTools:GetDormLevelAward(slot3, 0, 1)
				DormitoryData:UpdatePrivateDormRedPoint()
				DormRoomTools:RefreshDormExp(slot1.architecture_id)

				if DormitoryData:GetDormLevel(slot1.architecture_id) ~= DormitoryData:GetDormLevel(slot1.architecture_id) then
					DormRoomTools:GetDormLevelAward(slot3, slot5, slot6)
					manager.notify:Invoke(DORM_PRIVATE_LEVEL_UP, slot1.architecture_id, slot3)
				end

				manager.notify:Invoke(DORM_HERO_OCCUPY, {
					slot3
				})
			end

			uv0 = nil
		else
			ShowTips(slot0.result)
		end
	end,
	RecallHeroInPrivateDorm = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58134, {
			architecture_id = slot1,
			hero_id = slot2
		}, 58135, uv0.RecallHeroInPrivateDormCallBack)
	end,
	RecallHeroInPrivateDormCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot3 = DormitoryData:GetDormMapList()[slot1.architecture_id].archiveIDList[1]
			slot4 = 0

			for slot8, slot9 in ipairs(BackHomeCfg.all) do
				if BackHomeCfg[slot9].type == DormConst.BACKHOME_TYPE.PublicDorm then
					slot4 = slot9

					break
				end
			end

			for slot9 = 1, #DormitoryData:GetDormSceneData(slot4).archiveIDList do
				if slot5.archiveIDList[slot9] == slot3 then
					table.remove(slot5.archiveIDList, slot9)

					break
				end
			end

			DormData:RefreshInDormHeroInfo(slot1.architecture_id, {
				slot1.hero_id
			})
			manager.notify:Invoke(DORM_REFRESH_HERO_DEPLOY_LIST)
		else
			ShowTips(slot0.result)
		end
	end,
	GiftFurToHero = function (slot0, slot1, slot2, slot3)
		slot4 = {}
		uv0 = slot3

		for slot8, slot9 in pairs(slot2) do
			table.insert(slot4, {
				id = slot8,
				num = slot9
			})
		end

		manager.net:SendWithLoadingNew(58136, {
			hero_id = slot1,
			furniture = slot4
		}, 58137, uv1.GiftFurToHeroCallBack)
	end,
	GiftFurToHeroCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.hero_id
			slot4 = DormRoomTools:GetDormIDViaArchive(slot2)

			for slot8, slot9 in ipairs(slot1.furniture) do
				DormData:GetHeroTemplateInfo(slot2):GiftFur(slot9.id, slot9.num, uv0)
			end

			uv0 = nil

			if not slot4 then
				Debug.LogError("未获取到场景id")

				return
			end

			manager.notify:Invoke(DORM_REFRESH_GIFT_FUR_LIST, slot1.furniture)
			DormRoomTools:RefreshDormExp(slot4)

			if DormitoryData:GetDormLevel(slot4) ~= DormitoryData:GetDormLevel(slot4) then
				DormRoomTools:GetDormLevelAward(slot2, slot5, slot6)
				manager.notify:Invoke(DORM_PRIVATE_LEVEL_UP, slot4, slot2)
			end
		else
			ShowTips(slot0.result)
		end
	end,
	GiftFoodToHero = function (slot0, slot1, slot2, slot3, slot4)
		manager.net:SendWithLoadingNew(58138, {
			type = slot3,
			hero_id = slot3 == 1 and 0 or slot1
		}, 58139, uv0.GiftFoodToHeroCallBack(slot4, slot1, slot2))
	end,
	GiftFoodToHeroCallBack = function (slot0, slot1, slot2)
		return function (slot0, slot1)
			if isSuccess(slot0.result) then
				if uv0 then
					uv0(slot1.type, uv1, uv2)
				end

				for slot5, slot6 in ipairs(slot0.fatigue_list) do
					DormData:GetHeroInfo(slot6.archives_id):SetFatigue(slot6.fatigue)
				end

				manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)
			else
				ShowTips(slot0.result)
			end
		end
	end,
	SaveFurTemplate = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
		slot9 = nil

		if slot8 then
			slot9 = {
				user_id = slot8.user_id or PlayerData.INVALID_PLAYER,
				layout_uid = tonumber(slot8.layout_uid) or 0
			}
		end

		if slot4 == 0 or slot4 > 1000 then
			slot11, slot12, slot13, slot14, slot15, slot16 = slot0:SwitchFurInfoToLayout(slot5)

			if slot16 then
				for slot20, slot21 in pairs(slot7) do
					if slot21 then
						table.insert(slot15, {
							rotation = 0,
							x = 0,
							y = 0,
							furniture_id = slot21
						})
					end
				end
			else
				print("家具所在墙面类型错误")

				return
			end
		end

		manager.net:SendWithLoadingNew(58040, {
			id = slot1,
			type = slot2,
			name = slot3,
			architecture_id = slot4,
			furniture_pos_list = {},
			pos = slot6,
			host_info = slot9,
			architecture_id = 0,
			furniture_pos_list = {
				{
					default_suit_id = 0,
					type = 1,
					furniture_pos = slot11
				},
				{
					default_suit_id = 0,
					type = 2,
					furniture_pos = slot12
				},
				{
					default_suit_id = 0,
					type = 3,
					furniture_pos = slot13
				},
				{
					default_suit_id = 0,
					type = 4,
					furniture_pos = slot14
				},
				{
					default_suit_id = 0,
					type = 5,
					furniture_pos = slot15
				}
			}
		}, 58041, uv0.SaveFurTemplateCallBack)
	end,
	SwitchFurInfoToLayout = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = {}
		slot5 = {}
		slot6 = {}
		slot7 = true

		for slot11 = 0, slot1.Length - 1 do
			if DormFurnitureTools:CheckFurTileType(slot1[slot11].id, slot1[slot11].tileType) then
				if slot1[slot11].tileType == DormConst.TILE_TYPE.FLOOR then
					table.insert(slot6, {
						furniture_id = slot1[slot11].id,
						x = math.floor(slot1[slot11].pos.x * DormConst.POS_PRECISION),
						y = math.floor(slot1[slot11].pos.y * DormConst.POS_PRECISION),
						rotation = math.floor(slot1[slot11].rotation * DormConst.POS_PRECISION)
					})
				elseif slot1[slot11].tileType == DormConst.TILE_TYPE.WALL_LEFT then
					table.insert(slot2, slot12)
				elseif slot1[slot11].tileType == DormConst.TILE_TYPE.WALL_RIGHT then
					table.insert(slot3, slot12)
				elseif slot1[slot11].tileType == DormConst.TILE_TYPE.WALL_BEHIND then
					table.insert(slot4, slot12)
				elseif slot1[slot11].tileType == DormConst.TILE_TYPE.WALL_FRONT then
					table.insert(slot5, slot12)
				end
			else
				slot7 = false

				break
			end
		end

		return slot2, slot3, slot4, slot5, slot6, slot7
	end,
	SaveFurTemplateCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormFurnitureTemplateData:SaveFurTemplateInfo(slot1)
			manager.notify:Invoke(DORM_TEMPLATE_CHANGE)
			ShowTips(GetTips("DORM_MOULD_SAVE_SUCCESS"))
		else
			ShowTips(slot0.result)
		end
	end,
	ReviseFurTemplateName = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58142, {
			id = slot1,
			name = slot2
		}, 58143, uv0.ReviseFurTemplateNameCallBack)
	end,
	ReviseFurTemplateNameCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormFurnitureTemplateData:GetDormTemplateInfo(slot1.id):ReviseFurTemplateNameInfo(slot1.name)
			manager.notify:Invoke(DOMR_RENAME_TEMPLATE_SUCCESS)
		else
			ShowTips(slot0.result)
		end
	end,
	DeleteFurTemplate = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58144, {
			id = slot1
		}, 58145, uv0.DeleteFurTemplateCallBack)
	end,
	DeleteFurTemplateCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormFurnitureTemplateData:DeleteDormTemplateInfo(slot1.id)
			manager.notify:Invoke(DORM_TEMPLATE_CHANGE)
		else
			ShowTips(slot0.result)
		end
	end,
	RevisePrivateDormPos = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			table.insert(slot2, {
				architecture_id = slot7.roomID,
				pos_id = slot7.posID
			})
		end

		manager.net:SendWithLoadingNew(58146, {
			dorm_pos_list = slot2
		}, 58147, uv0.RevisePrivateDormPosCallBack)
	end,
	RevisePrivateDormPosCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormitoryData:RevisePrivateDormPosData(slot1)
		else
			ShowTips(slot0.result)
		end
	end,
	AskFurTemplateExhibitList = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58148, {
			type = slot1
		}, 58149, uv0.AskFurTemplateExhibitListCallBack)
	end,
	AskFurTemplateExhibitListCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormVisitTools:RefreshTemplateExhibit(slot0.exhibition_brief, slot1.type)
			manager.notify:Invoke(DORM_REFRESH_TEMPLATE_EXHI, #slot0.exhibition_brief)
		else
			ShowTips(slot0.result)
		end
	end,
	AskSingleFurTemplateExhibit = function (slot0, slot1)
		uv0 = slot1

		BackHomeAction:GetAllDetailInfo(function ()
			manager.net:SendWithLoadingNew(58050, {
				user_id = uv0
			}, 58051, function (slot0)
				if isSuccess(slot0.result) then
					DormVisitTools:RefreshCurTemplateExhibit(slot0, uv0, false)

					if slot0.architecture_id then
						if BackHomeCfg[slot0.architecture_id].type == DormConst.BACKHOME_TYPE.PublicDorm then
							BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_LOBBY)
						elseif slot1 == DormConst.BACKHOME_TYPE.PrivateDorm then
							BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_PRIVATE)
						end
					end
				else
					ShowTips(slot0.result)
				end
			end)
		end)
	end,
	OtherSystemAskSingleFurTemplateExhibit = function (slot0, slot1)
		BackHomeAction:GetAllDetailInfo(function ()
			manager.net:SendWithLoadingNew(58050, {
				user_id = uv0
			}, 58051, function (slot0)
				if isSuccess(slot0.result) then
					DormVisitTools:RefreshCurTemplateExhibit(slot0, uv0, true)

					if slot0.architecture_id then
						if BackHomeCfg[slot0.architecture_id].type == DormConst.BACKHOME_TYPE.PublicDorm then
							BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_LOBBY)
						elseif slot1 == DormConst.BACKHOME_TYPE.PrivateDorm then
							BackHomeDataManager:GotoBackHomeScene(DormConst.DORM_VISIT_PRIVATE)
						end
					end
				else
					ShowTips(slot0.result)
				end
			end)
		end)
	end,
	SetFurTemplateExhibit = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58152, {
			architecture_id = slot1
		}, 58153, uv0.SetFurTemplateExhibitCallBack)
	end,
	SetFurTemplateExhibitCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormVisitTools:SetCurTemplateExhibit(slot1.architecture_id)
			manager.notify:Invoke(DORM_REFRESH_EXIBIT)
		else
			ShowTips(slot0.result)
		end
	end,
	WatchTheatre = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58128, {
			theatrical_id = slot1
		}, 58129, uv0.WatchTheatreCallBack)
	end,
	WatchTheatreCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:Invoke(DORM_BIRTHDAY_THEATRE_WATCHED, slot1.theatrical_id)
		else
			ShowTips(slot0.result)
		end
	end,
	SettlementRhythmGame = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58154, {
			stage_id = slot1.stage_id,
			percentage_complete = slot1.percentage_complete,
			hero_id = slot1.hero_id
		}, 58155, uv0.SettlementRhythmGameCallBack)
	end,
	SettlementRhythmGameCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormData:GetHeroTemplateInfo(slot1.hero_id):SetFatigue(slot0.fatigue)
			manager.notify:Invoke(BACKHOME_HERO_FATIGUR_REFRESH)

			slot3 = {}

			for slot7, slot8 in ipairs(slot0.reward_list) do
				table.insert(slot3, {
					id = slot8.id,
					num = slot8.num
				})
			end

			if slot3[1] then
				DormitoryData:AddDailCurrencyNum(slot3[1].num)
			else
				DormitoryData:AddDailCurrencyNum(0)
			end

			manager.notify:Invoke(DORM_STOP_RHYTHM_GAME, true, slot3 or {})
		else
			ShowTips(slot0.result)
		end
	end,
	SetHeroSkin = function (slot0, slot1, slot2)
		if BackHomeHeroSkinCfg[slot1] then
			manager.net:SendWithLoadingNew(58126, {
				hero_id = BackHomeHeroSkinCfg[slot1].hero_id,
				skin_id = slot1,
				source = slot2
			}, 58127, uv0.SetHeroSkinCallBack)
		else
			print("不存在的皮肤配置信息" .. slot1)
		end
	end,
	SetHeroSkinCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			slot2 = slot1.skin_id
			slot3 = BackHomeHeroSkinCfg[slot2].hero_id

			DormData:GetHeroTemplateInfo(slot3):SetHeroSkinID(slot3, slot2)
			manager.notify:Invoke(DORM_HERO_SKIN_CHANGE, slot2)
			ShowTips("DORM_HERO_SKIN_CHANGE_SUCCESS")
		else
			ShowTips(slot0.result)
		end
	end,
	SetFurnitureTemplatCanSave = function (slot0)
		manager.net:SendWithLoadingNew(58158, {
			is_open = slot0
		}, 58159, uv0.SetFurnitureTemplatCanSaveCallBack)
	end,
	SetFurnitureTemplatCanSaveCallBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			DormFurnitureTemplateData:SetOtherCanSave(slot1.is_open)
			manager.notify:Invoke(DOMR_SAVE_FLAG_CHANGE)
		else
			ShowTips(slot0.result)
		end
	end,
	ModifyFurniture = function (slot0, slot1, slot2)
		DormData:AddFurTotalNum(slot0, slot1, slot2)
	end,
	LikeDormRoom = function (slot0, slot1, slot2)
		manager.net:SendWithLoadingNew(58052, {
			user_id = slot0,
			architecture_id = slot1
		}, 58053, function (slot0, slot1)
			if isSuccess(slot0.result) then
				if DormVisitTools:GetExhibitListByUserID(uv0) then
					slot2.likeNum = slot2.likeNum + 1
				end

				slot3 = DormVisitTools:GetCurVisitRoomData()
				slot3.likeNum = slot3.likeNum + 1
				slot3.todayLikeNum = slot3.todayLikeNum + 1

				manager.notify:Invoke(DORM_LIKE_NUM_REFRESH)

				if uv1 then
					uv1(slot0, slot1)
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end,
	AskDormRoomLikeNum = function (slot0, slot1)
		manager.net:SendWithLoadingNew(58054, {
			architecture_id = slot0
		}, 58055, function (slot0, slot1)
			if isSuccess(slot0.result) then
				if DormitoryData:GetDormSceneData(slot1.architecture_id) then
					slot2.likeNum = slot0.liked_num
				end

				manager.notify:Invoke(DORM_LIKE_NUM_REFRESH)

				if uv0 then
					uv0()
				end
			else
				ShowTips(slot0.result)
			end
		end)
	end
}
