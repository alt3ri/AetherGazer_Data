slot0 = class("RestaurantCookConditionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.conditionController = ControllerUtil.GetController(slot0.tickTrs_, "state")
end

function slot0.RefreshUI(slot0, slot1)
	slot2 = slot1.cfgID
	slot4 = slot1.level

	if slot1.type == 1 then
		slot5 = slot1.furID

		slot0.stateController:SetSelectedState("skill")

		if not slot2 then
			slot0.skillText_.text = ""

			return
		end

		if BackHomeHeroSkillCfg[slot2] then
			slot7 = false
			slot8 = DormSkillData:GetSkillDesc(slot2)

			if BackHomeCanteenFurnitureCfg[slot5].skill[slot4 + 1] then
				for slot13, slot14 in ipairs(BackHomeCanteenFurnitureCfg[slot5].skill[slot4 + 1]) do
					if BackHomeHeroSkillCfg[slot14].type == slot6.type then
						if slot6.type == 1 or slot6.type == 2 then
							if slot6.param[1] == BackHomeHeroSkillCfg[slot14].param[1] then
								slot0.skillText_.text = slot8 .. "<color=#e48a00> >>> " .. BackHomeHeroSkillCfg[slot14].param[2] .. "%</color>"
							end
						else
							slot0.skillText_.text = slot8 .. "<color=#e48a00> >>> " .. BackHomeHeroSkillCfg[slot14].param[1] .. "</color>"
						end

						slot7 = true

						break
					end
				end
			end

			if not slot7 then
				slot0.skillText_.text = slot8
			end
		else
			print("传入技能id错误")
		end
	elseif slot3 == 2 then
		slot0.stateController:SetSelectedState("condition")

		if not slot2 then
			slot0.conditionText_.text = ""

			return
		end

		if ConditionCfg[slot2] then
			slot0.conditionText_.text = BackHomeTools:GetBackHomeConditionDes(slot2)

			if BackHomeTools:CheckBackHomeConditionAccord(slot2) then
				slot0.conditionController:SetSelectedState("true")
			else
				slot0.conditionController:SetSelectedState("false")

				if slot0.conFunc then
					slot0.conFunc(false)
				else
					print("未注册升级条件方法")
				end
			end
		end
	elseif slot3 == 3 then
		slot0.stateController:SetSelectedState("skill")

		slot5 = slot1.level

		if slot1.effectType == CanteenConst.FurEffectType.Storage then
			if BackHomeCanteenFurnitureCfg[slot2].canteen_storage_max[slot5] and slot6 > 0 then
				if not BackHomeCanteenFurnitureCfg[slot2].canteen_storage_max[slot5 + 1] then
					slot0.skillText_.text = string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), slot6)
				else
					slot0.skillText_.text = string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), slot6) .. uv0:GetLevelUpDesc(" >>> " .. slot7)
				end
			end
		elseif slot1.effectType == CanteenConst.FurEffectType.SellMax then
			if BackHomeCanteenFurnitureCfg[slot2].canteen_sell_max[slot5] and slot6 > 0 then
				if not BackHomeCanteenFurnitureCfg[slot2].canteen_sell_max[slot5 + 1] then
					slot0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), slot6)
				else
					slot0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), slot6) .. uv0:GetLevelUpDesc(" >>> " .. slot7)
				end
			end
		elseif slot1.effectType == CanteenConst.FurEffectType.UnLockFood then
			if not BackHomeCanteenFurnitureCfg[slot2].canteen_sell_max[slot5 + 1] then
				slot0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), CanteenTools:GetFootTypeName(BackHomeFurniture[slot1.cfgID].type), tostring(slot1.unLockNum))
			elseif slot6 and slot6 > 0 then
				if not #DormSkillData:GetCookCanUnlockFoodList(slot7, slot5 + 1) then
					slot0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), slot8, tostring(slot6))
				else
					slot0.skillText_.text = string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), slot8, tostring(slot6)) .. uv0:GetLevelUpDesc(" >>> " .. string.format(GetTips("DORM_CANTEEN_INFO_NUM"), slot10))
				end
			end
		end
	elseif slot3 == 4 then
		slot0.stateController:SetSelectedState("skill")

		if BackHomeHeroSkillCfg[slot2] then
			slot0.skillText_.text = uv0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), slot1.level, BackHomeHeroSkillCfg[slot2].desc))
		elseif slot1.effectType == CanteenConst.FurEffectType.Storage then
			slot0.skillText_.text = uv0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), slot5, string.format(GetTips("CANTEEN_STORAGE_MAX_UP"), BackHomeCanteenFurnitureCfg[slot2].canteen_storage_max[slot5])))
		elseif slot1.effectType == CanteenConst.FurEffectType.SellMax then
			slot0.skillText_.text = uv0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), slot5, string.format(GetTips("CANTEEN_FOOD_SET_MAX_UP"), BackHomeCanteenFurnitureCfg[slot2].canteen_sell_max[slot5])))
		elseif slot1.effectType == CanteenConst.FurEffectType.UnLockFood then
			slot0.skillText_.text = uv0:GetLevelUpDesc(string.format(GetTips("CANTEEN_UNLOCK_ITEM"), slot5, string.format(GetTips("CANTEEN_FOOD_UNLOCK_NUM"), tostring(slot1.unLockNum))))
		end
	end
end

function slot0.UpdataCondition(slot0, slot1)
	if slot1 then
		slot0.conFunc = slot1
	end
end

function slot0.GetLevelUpDesc(slot0, slot1)
	return "<color=#e48a00>" .. slot1 .. "</color>"
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
