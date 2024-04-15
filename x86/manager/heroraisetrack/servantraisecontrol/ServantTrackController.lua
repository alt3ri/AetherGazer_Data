slot0 = class("ServantTrackController")

function slot0.Init(slot0, slot1)
	slot0.animation = {
		Fade = "WeaponServant_end_02",
		Back = "WeaponServant_end_01",
		Light = "WeaponServant_star_02",
		Gray = "WeaponServant_star_01"
	}
	slot0.context = {
		isFirstHide = true,
		servantID = -1,
		animFadeTime = 0.1,
		curAnimName = "",
		obj = slot1
	}

	SetActive(slot1, false)

	if not isNil(slot1) then
		slot0.context.animator = slot1:GetComponent("Animator")
		slot0.context.adaptiveSpriteComps = slot1:GetComponent(typeof(AdaptiveServantSprite))

		slot0:InitServantTrans()
	end
end

function slot0.InitServantTrans(slot0)
	if isNil(slot0.context.obj) then
		return
	end
end

function slot0.SetServantID(slot0, slot1)
	if isNil(slot0.context.adaptiveSpriteComps) then
		return
	end

	slot2 = false
	slot3 = slot0.context.obj.activeInHierarchy

	if slot1 ~= slot0.context.servantID then
		slot0.context.servantID = slot1 or -1

		if slot1 then
			slot4, slot5, slot6 = nil

			if WeaponServantCfg[slot1] then
				pcall(function ()
					if uv0.show_offset_x and uv0.show_offset_x ~= "" and tonumber(uv0.show_offset_x) then
						uv1 = tonumber(uv0.show_offset_x)
					end

					if uv0.show_offset_y and uv0.show_offset_y ~= "" and tonumber(uv0.show_offset_y) then
						uv2 = tonumber(uv0.show_offset_y)
					end

					if uv0.show_tiling_scale and uv0.show_tiling_scale ~= "" and tonumber(uv0.show_tiling_scale) then
						uv3 = tonumber(uv0.show_tiling_scale)
					end
				end)
			end

			slot8 = false

			if slot6 then
				slot8 = true
			end

			slot0.context.adaptiveSpriteComps:SetSprite(getSpriteWithoutAtlas("TextureConfig/WeaponServant/Portrait/" .. slot1), slot4 ~= nil, slot5 ~= nil, slot4 or 0, slot5 or 0, slot8, slot6 or 1)
			SetActive(slot0.context.obj, true)

			slot2 = true
		else
			SetActive(slot0.context.obj, false)
		end
	else
		SetActive(slot0.context.obj, slot1 ~= nil)

		slot2 = slot1 ~= nil
	end

	if slot2 and not slot3 then
		slot0:PlayCurrentAnim()
	end
end

function slot0.PlayCurrentAnim(slot0)
	if not slot0.animation[slot0.context.curAnimName] then
		return
	end

	if isNil(slot0.context.animator) then
		return
	end

	slot0.context.animator:CrossFade(slot0.animation[slot1], slot0.context.animFadeTime)
end

function slot0.PlayAnim(slot0, slot1, slot2)
	if slot1 == "Gray" and slot0.context.curAnimName == "Light" then
		slot1 = "Back"
	end

	if slot1 == "Fade" and slot0.context.isFirstHide then
		return
	elseif slot0.context.isFirstHide then
		SetActive(slot0.context.obj, true)

		slot0.context.isFirstHide = false
	end

	if not slot0.animation[slot1] then
		return
	end

	if isNil(slot0.context.animator) then
		return
	end

	if slot0.context.curAnimName ~= slot1 or slot2 or false then
		slot0.context.animator:CrossFade(slot0.animation[slot1], slot0.context.animFadeTime)

		if slot1 == "Back" then
			slot1 = "Gray"
		end

		slot0.context.curAnimName = slot1
	end
end

function slot0.CheckValid(slot0)
	if isNil(slot0.context.obj) then
		return false
	end

	return true
end

function slot0.Dispose(slot0)
	slot0.context.animator = nil
	slot0.context.adaptiveSpriteComps = nil

	if not isNil(slot0.context.obj) then
		Object.Destroy(slot0.context.obj)

		slot0.context.obj = nil
	end
end

return slot0
