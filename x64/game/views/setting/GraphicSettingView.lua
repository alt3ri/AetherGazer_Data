slot0 = class("GraphicSettingView", ReduxView)

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.info_ = slot3

	slot0:Init()
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.fps120go_.transform, RedPointConst.HIGH_FPS_DEVICE_SURRPORT)
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.fps120go_.transform, RedPointConst.HIGH_FPS_DEVICE_SURRPORT)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.picQualityList_ = {
		6,
		2,
		3,
		4,
		5,
		7
	}
	slot0.picQualityNum_ = #slot0.picQualityList_
	slot0.picToggle_ = {}
	slot0.picToggleController_ = {}

	for slot4 = 1, slot0.picQualityNum_ do
		slot5 = slot0.picQualityList_[slot4]
		slot0.picToggle_[slot5] = slot0["pic" .. slot5 .. "Btn_"]
		slot0.picToggleController_[slot5] = ControllerUtil.GetController(slot0.picToggle_[slot5]:GetComponent(typeof(RectTransform)), "name")
	end
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, slot0.picQualityNum_ do
		slot0:AddBtnListener(slot0.picToggle_[slot0.picQualityList_[slot4]], nil, function ()
			SettingAction.ChangePicSetting("picOptionId", uv0)
		end)
	end

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["fps" .. slot4 .. "Tgl_"], nil, function ()
			if uv0.settingData_.frame ~= uv1 - 1 then
				if uv1 == 3 then
					manager.redPoint:setTip(RedPointConst.HIGH_FPS_DEVICE_SURRPORT, 0)

					if GameLocalData:GetCommonModule("highFps").isFirstSet == nil == true then
						ShowMessageBox({
							isTop = true,
							content = GetTips("WARN_HIGH_FPS_TIPS"),
							OkCallback = function ()
								SettingAction.ChangePicSetting("frame", uv0 - 1)
								GameLocalData:SaveToCommonModule("highFps", "isFirstSet", false)
							end,
							CancelCallback = function ()
							end
						})
					else
						SettingAction.ChangePicSetting("frame", uv1 - 1)
					end

					GameLocalData:SaveToCommonModule("highFps", "checkDevice", true)
				else
					SettingAction.ChangePicSetting("frame", uv1 - 1)
				end
			end
		end)
	end

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["resolution" .. slot4 .. "Tgl_"], nil, function ()
			if uv0.settingData_.resolution ~= uv1 then
				SettingAction.ChangePicSetting("resolution", uv1)
			end
		end)
	end

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["teammate" .. slot4 .. "Tgl_"], nil, function ()
			if uv0.settingData_.teammate_effect ~= uv1 then
				SettingAction.ChangePicSetting("teammate_effect", uv1)
			end
		end)
	end

	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["user" .. slot4 .. "Tgl_"], nil, function ()
			if uv0.settingData_.user_effect ~= uv1 then
				SettingAction.ChangePicSetting("user_effect", uv1)
			end
		end)
	end

	slot0:AddBtnListener(slot0.antialiasTgl_, nil, function ()
		if uv0.settingData_.anti_aliasing ~= (uv0.settingData_.anti_aliasing == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("anti_aliasing", slot0)
		end
	end)
	slot0:AddBtnListener(slot0.hdrTgl_, nil, function ()
		if uv0.settingData_.hdr ~= (uv0.settingData_.hdr == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("hdr", slot0)
		end
	end)
	slot0:AddBtnListener(slot0.reflectTgl_, nil, function ()
		if uv0.settingData_.reflection_effect ~= (uv0.settingData_.reflection_effect == 1 and 0 or 1) then
			SettingAction.ChangePicSetting("reflection_effect", slot0)
		end
	end)
end

function slot0.RefreshPicOption(slot0)
	for slot5, slot6 in pairs(slot0.picToggleController_) do
		if slot5 == slot0.settingData_.picOptionId then
			slot6:SetSelectedIndex(0)
		else
			slot6:SetSelectedIndex(1)
		end
	end
end

function slot0.RefreshFPS(slot0)
	for slot5 = 1, 3 do
		SetActive(slot0[string.format("fps%dCheck_", slot5)], slot0.settingData_.frame + 1 == slot5)
	end
end

function slot0.RefreshResolution(slot0)
	for slot5 = 1, 3 do
		SetActive(slot0[string.format("resolution%dCheck_", slot5)], slot0.settingData_.resolution == slot5)
	end
end

function slot0.RefreshTeamMateEffect(slot0)
	for slot5 = 1, 3 do
		SetActive(slot0[string.format("teammate%dCheck_", slot5)], slot0.settingData_.teammate_effect == slot5)
	end
end

function slot0.RefreshUserEffect(slot0)
	for slot5 = 1, 3 do
		SetActive(slot0[string.format("user%dCheck_", slot5)], slot0.settingData_.user_effect == slot5)
	end
end

function slot0.RefreshAntiAlias(slot0)
	slot0.antialiasTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(slot0.settingData_.anti_aliasing)
end

function slot0.RefreshHDR(slot0)
	slot0.hdrTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(slot0.settingData_.hdr)
end

function slot0.RefreshReflect(slot0)
	slot0.reflectTgl_.transform:GetComponent("ControllerExCollection"):GetController("default0"):SetSelectedIndex(slot0.settingData_.reflection_effect)
end

function slot0.CheckDataChange(slot0, slot1)
	slot2 = ""

	if slot0.tmpSettingData_ and not table.equal(slot0.tmpSettingData_, slot0.settingData_, "all") then
		print("CheckDataChange, 新旧数据不同！！！")

		return true
	end

	return false
end

function slot0.SaveData(slot0)
	if slot0:CheckDataChange() then
		slot0.json_ = require("cjson")

		if deepClone(slot0.settingData_).picOptionId ~= 7 then
			slot1.pic = {
				quality = "quality_" .. slot1.picOptionId
			}
		end

		slot1.type = 1
		slot2 = slot0.json_.encode(slot1)
		slot5 = 0

		if table.indexof({
			6,
			2,
			3,
			4,
			5,
			7
		}, slot1.picOptionId) > 0 then
			slot5 = slot4 - 1
		end

		SDKTools.SendMessageToSDK("graphics_setting", {
			graphics = slot5,
			fps_setting = slot0.settingData_.frame == 0 and 30 or slot0.settingData_.frame == 1 and 60 or 120,
			dpi_setting = slot0.settingData_.resolution,
			teammate_effect_setting = slot0.settingData_.teammate_effect,
			anti_aliasing_setting = slot0.settingData_.anti_aliasing == 0 and "false" or "true",
			reflect_setting = slot0.settingData_.reflection_effect == 0 and "false" or "true",
			HDR_setting = slot0.settingData_.hdr == 0 and "false" or "true",
			user_effect_setting = slot0.settingData_.user_effect
		})

		slot6 = slot0.json_.encode(slot1)
	end

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
end

function slot0.RecoverTmpData(slot0)
	if slot0:CheckDataChange() then
		SettingAction.ChangePicSetting("allData", slot0.tmpSettingData_)
	end
end

function slot0.OnPicSettingChange(slot0, slot1, slot2)
	slot0:RefreshPicOption()

	if slot2.key == "picOptionId" or slot2.key == "allData" then
		slot0:RefreshResolution()
		slot0:RefreshTeamMateEffect()
		slot0:RefreshUserEffect()
		slot0:RefreshFPS()
		slot0:RefreshHDR()
		slot0:RefreshAntiAlias()
		slot0:RefreshReflect()
	elseif slot2.key == "resolution" then
		slot0:RefreshResolution()
	elseif slot2.key == "teammate_effect" then
		slot0:RefreshTeamMateEffect()
	elseif slot2.key == "frame" then
		slot0:RefreshFPS()
	elseif slot2.key == "hdr" then
		slot0:RefreshHDR()
	elseif slot2.key == "anti_aliasing" then
		slot0:RefreshAntiAlias()
	elseif slot2.key == "reflection_effect" then
		slot0:RefreshReflect()
	elseif slot2.key == "user_effect" then
		slot0:RefreshUserEffect()
	end
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.OnEnter(slot0)
	slot0.settingData_ = SettingData:GetPicSettingData()

	slot0:RefreshPicOption()
	slot0:RefreshFPS()
	slot0:RefreshResolution()
	slot0:RefreshTeamMateEffect()
	slot0:RefreshUserEffect()
	slot0:RefreshAntiAlias()
	slot0:RefreshHDR()
	slot0:RefreshReflect()

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)

	slot0:BindRedPointUI()
end

function slot0.OnExit(slot0)
	slot0:UnBindRedPointUI()
end

function slot0.Dispose(slot0)
	slot0.hander_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
