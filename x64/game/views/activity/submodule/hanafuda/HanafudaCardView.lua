slot0 = class("HanafudaCardView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	if slot0.btn_ then
		slot0:AddBtnListener(slot0.btn_, nil, function ()
			slot0 = HanafudaData:GetGameState()

			if uv0.data_.placeType == HanafudaData.CARD_PLACE_TYPE.COLLECTION then
				if uv0.clickPlayerCallBack then
					uv0:clickPlayerCallBack()
				end
			elseif slot0 == HanafudaData.GAME_STATE.PLAYER_TURN then
				if uv0.data_.placeType == HanafudaData.CARD_PLACE_TYPE.PLAYER then
					if uv0.clickPlayerCallBack then
						uv0:clickPlayerCallBack()
					end
				elseif uv0.data_.placeType == HanafudaData.CARD_PLACE_TYPE.PLACE and uv0.clickPlaceCallBack then
					uv0:clickPlaceCallBack()
				end
			end
		end)
	end

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.faceUpController_ = ControllerUtil.GetController(slot0.transform_, "faceup")
	slot0.hasCardController_ = ControllerUtil.GetController(slot0.transform_, "hasCard")
end

function slot0.SetPlayerClickCallBack(slot0, slot1)
	slot0.clickPlayerCallBack = slot1
end

function slot0.SetPlaceClickCallBack(slot0, slot1)
	slot0.clickPlaceCallBack = slot1
end

function slot0.SetFlipCallBack(slot0, slot1)
	slot0.flipCallBack = slot1
end

function slot0.PlayFlipCardAni(slot0)
	if slot0.isFlipping then
		return
	end

	slot0.isFlipping = true
	slot0.rotateLeanTween_ = LeanTween.rotateAroundLocal(slot0.gameObject_, Vector3.up, -180, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.flipCallBack then
			uv0.flipCallBack()
		end

		uv0.isFlipping = false

		uv0:RefreshUI()
	end))
	slot0.timer_ = Timer.New(function ()
		uv0:RefreshUI()
	end, 0.25, 2, true)

	slot0.timer_:Start()
end

function slot0.FlipToFaceUp(slot0)
	slot0.gameObject_.transform.localEulerAngles = Vector3(0, 0, 0)

	slot0:RefreshUI()
end

function slot0.FlipToBackUp(slot0)
	slot0.gameObject_.transform.localEulerAngles = Vector3(0, 180, 0)

	slot0:RefreshUI()
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.data_ = slot2
	slot0.hasCard_ = slot3

	if slot0.hasCardController_ then
		slot0.hasCardController_:SetSelectedState(tostring(slot0.hasCard_))
	end

	slot0.nameText_.text = RareFishCfg[slot0.data_.desc].name
	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/Hanafuda/" .. slot0.data_.id)
	slot0.rarityImg_.sprite = getSprite("Atlas/Common", "star_" .. KagutsuchiFishingEventData:GetRarity(slot0.data_.id).order)
	slot0.raceImg_.sprite = getSprite("Atlas/CampItemAtlas", string.format("icon_group_%d_c", slot0.data_.race))

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.isFaceUp_ = slot0.gameObject_.transform.localEulerAngles.y < 90

	if slot0.isFaceUp_ then
		slot0.faceUpController_:SetSelectedState("yes")
	else
		slot0.faceUpController_:SetSelectedState("no")
	end

	if slot0.selectController_ then
		if slot0.index_ == slot1 then
			if not slot2 then
				slot0.selectController_:SetSelectedState("selected")
			else
				slot0.selectController_:SetSelectedState("canselect")
			end
		else
			slot0.selectController_:SetSelectedState("unselected")
		end
	end

	if slot0.pointText_ then
		if slot0.index_ == slot1 and slot2 and HanafudaData:GetGameState() == HanafudaData.GAME_STATE.PLAYER_TURN then
			slot10 = false

			for slot10, slot11 in ipairs(HanafudaData:GetNewCombineList(HanafudaData.CARD_PLACE_TYPE.PLAYERCOMBINE, {
				slot1,
				slot3
			}, slot10)) do
				slot6 = 0 + HanafudaCardCombineCfg[slot11].score
			end

			slot0.pointText_.text = "+" .. slot6

			SetActive(slot0.pointText_.gameObject, slot6 ~= 0)
		else
			SetActive(slot0.pointText_.gameObject, false)
		end
	end
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
