local var_0_0 = singletonClass("SettingData")
local var_0_1 = {}
local var_0_2 = false

function var_0_0.NewDevice(arg_1_0)
	return var_0_2
end

function var_0_0.SetQualitied(arg_2_0)
	var_0_2 = false
end

function var_0_0.InitSetting(arg_3_0)
	local var_3_0 = GameLocalData:GetCommonModule("userSetting")
	local var_3_1
	local var_3_2 = {}
	local var_3_3 = var_3_0.picOptionId == nil

	if var_3_3 then
		var_0_2 = true
		var_3_1 = 5
		var_3_2 = PictureQualitySettingCfg[var_3_1]
	end

	local var_3_4 = AreaDifferenceCfg[GameToSDK.CURRENT_SERVER]
	local var_3_5 = var_3_0.text_language or var_3_4.language_list[1]

	if GameToSDK.Text_Language ~= "" then
		var_3_5 = GameToSDK.Text_Language

		arg_3_0:SaveData("text_language", GameToSDK.Text_Language)
	end

	if not table.indexof(var_3_4.language_list, var_3_5) then
		var_3_5 = var_3_4.language_list[1]
	end

	local var_3_6 = var_3_0.voice_language or var_3_4.voice_list[1]

	if not table.indexof(var_3_4.voice_list, var_3_6) then
		var_3_6 = var_3_4.voice_list[1]
	end

	var_0_1 = {
		pic = {
			picOptionId = var_3_0.picOptionId or var_3_1,
			resolution = var_3_0.resolution or var_3_2.resolution,
			teammate_effect = var_3_0.teammate_effect or var_3_2.teammate_effect,
			frame = var_3_0.frame or var_3_2.frame,
			hdr = var_3_0.hdr or var_3_2.hdr,
			anti_aliasing = var_3_0.anti_aliasing or var_3_2.anti_aliasing,
			reflection_effect = var_3_0.reflection_effect or var_3_2.reflection_effect,
			user_effect = var_3_0.user_effect or var_3_2.user_effect or 3
		},
		sound = {
			music = var_3_0.music or 50,
			effect = var_3_0.effect or 50,
			voice = var_3_0.voice or 50,
			sound_open = var_3_0.sound_open or 1,
			teammate_sound_open = var_3_0.teammate_sound_open or 1,
			voice_language = var_3_6,
			text_language = var_3_5
		},
		push = {
			push_btn = var_3_0.push_btn or 1,
			expedition_success = var_3_0.expedition_success or 1,
			fatigue_recovery_full = var_3_0.fatigue_recovery_full or 1,
			fatigue_receive = var_3_0.fatigue_receive or 1
		},
		game = {
			battle_hit_num_mine = var_3_0.battle_hit_num_mine or 1,
			battle_hit_num_teammate = var_3_0.battle_hit_num_teammate or 1,
			battle_lock_type = var_3_0.battle_lock_type or 0,
			adapter_value = var_3_0.adapter_value or 60,
			moveable_stick = var_3_0.moveable_stick or 1,
			cus_full_play_controlled_type = var_3_0.cus_full_play_controlled_type or 0
		},
		battleUI = {
			battle_ui_cur_type = var_3_0.battle_ui_cur_type or (GameToSDK.PLATFORM_ID == 0 or GameToSDK.PLATFORM_ID == 1) and "" or "DKVTdGlja8rEYgAAysP0GZrKPszMzdkgU2NyZWVuQWRqdXN0Q29udGFpbmVyL1BsYXllckluZm/KAAAAAMrD5QAAyj9MzM3ZMVNjcmVlbkFkanVzdENvbnRhaW5lci9CYXR0bGVCdXR0b25zL0FiaWxpdEJ1dHRvbjDKw6pmZ8pCohmYyj7MzM3ZMVNjcmVlbkFkanVzdENvbnRhaW5lci9CYXR0bGVCdXR0b25zL0FiaWxpdEJ1dHRvbjHKw4QAAMpCohmYyj7MzM3ZMVNjcmVlbkFkanVzdENvbnRhaW5lci9CYXR0bGVCdXR0b25zL0FiaWxpdEJ1dHRvbjLKwztMzcpCohmYyj7MzM3ZKVNjcmVlbkFkanVzdENvbnRhaW5lci9CYXR0bGVCdXR0b25zL01lbGVlysQBmZrKQxAMzMo/AAAA2SlTY3JlZW5BZGp1c3RDb250YWluZXIvQmF0dGxlQnV0dG9ucy9Bdm9pZMrCzzM0ykKiGZjKPszMzdktU2NyZWVuQWRqdXN0Q29udGFpbmVyL0JhdHRsZUJ1dHRvbnMvUVRFQnV0dG9uysLPMzTKQyhZmco/AAAA2S5TY3JlZW5BZGp1c3RDb250YWluZXIvQmF0dGxlQnV0dG9ucy9NYW51YWxsb2NrysPRwADKQoxMzMo+mZma2SpTY3JlZW5BZGp1c3RDb250YWluZXIvVGVhbVBhbmVsL1JvbGUxUGFuZWzKwschRsrCnmZwyj8AAADZKlNjcmVlbkFkanVzdENvbnRhaW5lci9UZWFtUGFuZWwvUm9sZTJQYW5lbMrCxyFAysMtmaDKPwAAANkvU2NyZWVuQWRqdXN0Q29udGFpbmVyL1JpZ2h0VG9wQnV0dG9ucy9idG5fcGF1c2XKwrQzM8rCXHtuyj+AAAA=",
			battle_ui_cur_alpha_value = var_3_0.battle_ui_cur_alpha_value or 1,
			battle_ui_cur_rotate_speed = var_3_0.battle_ui_cur_rotate_speed or 0.5,
			battle_ui_type_0 = var_3_0.battle_ui_type_0 or "",
			battle_ui_alpha_0 = var_3_0.battle_ui_alpha_0 or 1,
			battle_ui_rotate_speed_0 = var_3_0.battle_ui_rotate_speed_0 or 0.5,
			battle_ui_type_1 = var_3_0.battle_ui_type_1 or "",
			battle_ui_alpha_1 = var_3_0.battle_ui_alpha_1 or 1,
			battle_ui_rotate_speed_1 = var_3_0.battle_ui_rotate_speed_1 or 0.5,
			battle_ui_type_2 = var_3_0.battle_ui_type_2 or "",
			battle_ui_alpha_2 = var_3_0.battle_ui_alpha_2 or 1,
			battle_ui_rotate_speed_2 = var_3_0.battle_ui_rotate_speed_2 or 0.5,
			battle_ui_type_3 = var_3_0.battle_ui_type_3 or "",
			battle_ui_alpha_3 = var_3_0.battle_ui_alpha_3 or 1,
			battle_ui_rotate_speed_3 = var_3_0.battle_ui_rotate_speed_3 or 0.5
		},
		remind = {
			activity_sign_reminder = var_3_0.activity_sign_reminder or 1,
			month_card_reminder = var_3_0.month_card_reminder or 1,
			fatigue_full_reminder = var_3_0.fatigue_full_reminder or 1,
			daily_fatigue_reminder = var_3_0.daily_fatigue_reminder or 1,
			cat_explore_reminder = var_3_0.cat_explore_reminder or 1,
			canteen_dispatch_reminder = var_3_0.canteen_dispatch_reminder or 1,
			canteen_full_reminder = var_3_0.canteen_full_reminder or 1,
			diamond_buy_item_reminder = var_3_0.diamond_buy_item_reminder or 1,
			core_equip_buy_item_reminder = var_3_0.core_equip_buy_item_reminder or 1,
			info_badge_top_buy_item_reminder = var_3_0.info_badge_top_buy_item_reminder or 1,
			boss_challenge_s_buy_item_reminder = var_3_0.boss_challenge_s_buy_item_reminder or 1,
			diamond_buy_fatigue_reminder = var_3_0.diamond_buy_fatigue_reminder or 0,
			diamond_buy_gold_reminder = var_3_0.diamond_buy_gold_reminder or 0,
			spirit_refine_reminder = var_3_0.spirit_refine_reminder or 1,
			servant_promote_reminder = var_3_0.servant_promote_reminder or 1,
			refresh_enchantment_times_reminder = var_3_0.refresh_enchantment_times_reminder or 1,
			uninstall_equip_reminder = var_3_0.uninstall_equip_reminder or 1,
			rebuild_hero_equip_reminder = var_3_0.rebuild_hero_equip_reminder or 1,
			battle_low_fps_tips = var_3_0.battle_low_fps_tips or 1
		},
		homeScene = {
			home_scene_sound_effect = var_3_0.home_scene_sound_effect or 1,
			home_scene_camera_follow = var_3_0.home_scene_camera_follow or 1,
			home_scene_scene_bgm = var_3_0.home_scene_scene_bgm or 1
		}
	}

	if var_3_3 then
		arg_3_0:SaveData("pic", var_0_1.pic)
		arg_3_0:SaveData("battle_hit_num_mine", 1)
		arg_3_0:SaveData("battle_hit_num_teammate", 1)
		arg_3_0:SaveData("battle_lock_type", 0)
		arg_3_0:SaveData("moveable_stick", 1)
		arg_3_0:SaveData("cus_full_play_controlled_type", 0)
		arg_3_0:SaveData("battle_ui_cur_type", var_0_1.battleUI.battle_ui_cur_type)
		arg_3_0:SaveData("battle_ui_type_0", "")
		arg_3_0:SaveData("battle_ui_type_1", "")
		arg_3_0:SaveData("battle_ui_type_2", "")
		arg_3_0:SaveData("battle_ui_type_3", "")
		arg_3_0:SaveData("battle_ui_cur_alpha_value", 1)
		arg_3_0:SaveData("battle_ui_alpha_0", 1)
		arg_3_0:SaveData("battle_ui_alpha_1", 1)
		arg_3_0:SaveData("battle_ui_alpha_2", 1)
		arg_3_0:SaveData("battle_ui_alpha_3", 1)
		arg_3_0:SaveData("battle_ui_cur_rotate_speed", 0.5)
		arg_3_0:SaveData("battle_ui_rotate_speed_0", 0.5)
		arg_3_0:SaveData("battle_ui_rotate_speed_1", 0.5)
		arg_3_0:SaveData("battle_ui_rotate_speed_2", 0.5)
		arg_3_0:SaveData("battle_ui_rotate_speed_3", 0.5)
		arg_3_0:SaveData("text_language", var_3_5)
	end

	if var_0_1.sound and var_0_1.sound.voice_language then
		local var_3_7 = VoiceLanguageCfg[var_0_1.sound.voice_language]

		if var_3_7 and not VoicePackageManager.Instance:IsHavePackage(var_3_7.affix) then
			local var_3_8 = VoicePackageManager.Instance:GetValidPackage()
			local var_3_9 = #VoiceLanguageCfg.all

			for iter_3_0 = 1, var_3_9 do
				if VoiceLanguageCfg[iter_3_0].affix == var_3_8 then
					var_0_1.sound.voice_language = iter_3_0
				end
			end
		end
	end
end

function var_0_0.ModifyPicSetting(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 == "picOptionId" and arg_4_2 ~= SettingConst.GRAPHIC_CUSTOM_ID or arg_4_1 == "allData" then
		local var_4_0 = arg_4_1 == "picOptionId" and PictureQualitySettingCfg[arg_4_2] or arg_4_2

		var_0_1.pic.picOptionId = var_4_0.picOptionId or var_4_0.id
		var_0_1.pic.resolution = var_4_0.resolution
		var_0_1.pic.frame = var_4_0.frame
		var_0_1.pic.hdr = var_4_0.hdr
		var_0_1.pic.anti_aliasing = var_4_0.anti_aliasing
		var_0_1.pic.reflection_effect = var_4_0.reflection_effect
		var_0_1.pic.teammate_effect = var_4_0.teammate_effect
		var_0_1.pic.user_effect = var_4_0.user_effect

		arg_4_0:SaveData("pic", var_0_1.pic)
	else
		var_0_1.pic[arg_4_1] = arg_4_2
		var_0_1.pic.picOptionId = SettingConst.GRAPHIC_CUSTOM_ID

		arg_4_0:SaveData(arg_4_1, arg_4_2)
		arg_4_0:SaveData("picOptionId", SettingConst.GRAPHIC_CUSTOM_ID)
	end
end

function var_0_0.ModifySoundSetting(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == "allData" then
		for iter_5_0, iter_5_1 in pairs(var_0_1.sound) do
			var_0_1.sound[iter_5_0] = arg_5_2[iter_5_0]

			arg_5_0:SaveData(iter_5_0, var_0_1.sound[iter_5_0])
		end
	else
		var_0_1.sound[arg_5_1] = arg_5_2

		arg_5_0:SaveData(arg_5_1, arg_5_2)
	end
end

function var_0_0.ModifyPushSetting(arg_6_0, arg_6_1, arg_6_2)
	var_0_1.push[arg_6_1] = arg_6_2

	arg_6_0:SaveData(arg_6_1, arg_6_2)
end

function var_0_0.ModifyGameSetting(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == "allData" then
		for iter_7_0, iter_7_1 in pairs(var_0_1.game) do
			var_0_1.game[iter_7_0] = arg_7_2[iter_7_0]

			arg_7_0:SaveData(arg_7_1, arg_7_2)
		end
	else
		var_0_1.game[arg_7_1] = arg_7_2

		arg_7_0:SaveData(arg_7_1, arg_7_2)
	end
end

function var_0_0.ModifyBattleUISetting(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == "allData" then
		for iter_8_0, iter_8_1 in pairs(var_0_1.battleUI) do
			var_0_1.battleUI[iter_8_0] = arg_8_2[iter_8_0]

			arg_8_0:SaveData(iter_8_0, arg_8_2[iter_8_0])
		end
	else
		var_0_1.battleUI[arg_8_1] = arg_8_2

		arg_8_0:SaveData(arg_8_1, arg_8_2)
	end
end

function var_0_0.ModifyRemindSetting(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == "allData" then
		for iter_9_0, iter_9_1 in pairs(var_0_1.remind) do
			var_0_1.remind[iter_9_0] = arg_9_2[iter_9_0]

			arg_9_0:SaveData(iter_9_0, arg_9_2[iter_9_0])
		end
	else
		var_0_1.remind[arg_9_1] = arg_9_2

		arg_9_0:SaveData(arg_9_1, arg_9_2)
	end
end

function var_0_0.ModifyHomeSceneSetting(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_1 == "allData" then
		for iter_10_0, iter_10_1 in pairs(var_0_1.homeScene) do
			var_0_1.homeScene[iter_10_0] = arg_10_2[iter_10_0]

			arg_10_0:SaveData(iter_10_0, arg_10_2[iter_10_0])
		end
	else
		var_0_1.homeScene[arg_10_1] = arg_10_2

		arg_10_0:SaveData(arg_10_1, arg_10_2)
	end
end

function var_0_0.SaveData(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 == "pic" then
		GameLocalData:SaveToCommonModule("userSetting", "picOptionId", arg_11_2.picOptionId)
		GameLocalData:SaveToCommonModule("userSetting", "resolution", arg_11_2.resolution)
		GameLocalData:SaveToCommonModule("userSetting", "frame", arg_11_2.frame)
		GameLocalData:SaveToCommonModule("userSetting", "hdr", arg_11_2.hdr)
		GameLocalData:SaveToCommonModule("userSetting", "anti_aliasing", arg_11_2.anti_aliasing)
		GameLocalData:SaveToCommonModule("userSetting", "reflection_effect", arg_11_2.reflection_effect)
		GameLocalData:SaveToCommonModule("userSetting", "teammate_effect", arg_11_2.teammate_effect)
		GameLocalData:SaveToCommonModule("userSetting", "user_effect", arg_11_2.user_effect)
	else
		GameLocalData:SaveToCommonModule("userSetting", arg_11_1, arg_11_2)
	end

	arg_11_0:ApplyToBattle(arg_11_1, arg_11_2)
end

function var_0_0.ApplyToBattle(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_1 == "pic" then
		PlayerPrefs.SetInt("allowHDR", arg_12_2.hdr)
		PlayerPrefs.SetInt("frame", arg_12_2.frame)
		PlayerPrefs.SetInt("allowMSAA", arg_12_2.anti_aliasing)
	elseif arg_12_1 == "hdr" then
		PlayerPrefs.SetInt("allowHDR", arg_12_2)
	elseif arg_12_1 == "anti_aliasing" then
		PlayerPrefs.SetInt("allowMSAA", arg_12_2)
	elseif arg_12_1 == "frame" then
		PlayerPrefs.SetInt("frame", arg_12_2)
	elseif arg_12_1 == "battle_hit_num_mine" then
		PlayerPrefs.SetInt("battle_hit_num_mine", arg_12_2)
	elseif arg_12_1 == "battle_hit_num_teammate" then
		PlayerPrefs.SetInt("battle_hit_num_teammate", arg_12_2)
	elseif arg_12_1 == "battle_lock_type" then
		PlayerPrefs.SetInt("battle_lock_type", arg_12_2)
	elseif arg_12_1 == "battle_ui_cur_type" then
		PlayerPrefs.SetString("battle_ui_cur_type", arg_12_2)
	elseif arg_12_1 == "battle_ui_cur_alpha_value" then
		PlayerPrefs.SetFloat("battle_ui_cur_alpha_value", arg_12_2)
	elseif arg_12_1 == "battle_ui_cur_rotate_speed" then
		PlayerPrefs.SetFloat("battle_ui_cur_rotate_speed", arg_12_2)
	elseif arg_12_1 == "moveable_stick" then
		PlayerPrefs.SetInt("moveable_stick", arg_12_2)
	elseif arg_12_1 == "cus_full_play_controlled_type" then
		PlayerPrefs.SetInt("CooperateUniqueSkillFullPlayControlledType", arg_12_2)
	elseif arg_12_1 == "text_language" then
		PlayerPrefs.SetString("text_language", arg_12_2)
	end
end

function var_0_0.GetSettingData(arg_13_0)
	return var_0_1
end

function var_0_0.GetPicSettingData(arg_14_0)
	return var_0_1.pic
end

function var_0_0.GetSoundSettingData(arg_15_0)
	return var_0_1.sound
end

function var_0_0.GetGameSettingData(arg_16_0)
	return var_0_1.game
end

function var_0_0.GetCurrentLanguage(arg_17_0)
	return var_0_1.sound.text_language
end

function var_0_0.GetCurrentLanguageKey(arg_18_0)
	return "@" .. var_0_1.sound.text_language
end

function var_0_0.GetBattleUISettingData(arg_19_0)
	return var_0_1.battleUI
end

function var_0_0.GetRemindSettingData(arg_20_0)
	return var_0_1.remind
end

function var_0_0.GetHomeSceneSettingData(arg_21_0)
	return var_0_1.homeScene
end

function var_0_0.GetDefaultSetting(arg_22_0)
	if GameToSDK.PLATFORM_ID == 1 then
		if UnityEngine.SystemInfo.systemMemorySize > 2048 then
			return 5
		else
			return 4
		end
	end

	if UnityEngine.SystemInfo.systemMemorySize > 4096 and UnityEngine.SystemInfo.processorCount > 4 and UnityEngine.SystemInfo.processorFrequency > 2000 and UnityEngine.SystemInfo.supports2DArrayTextures and UnityEngine.SystemInfo.supports3DTextures and UnityEngine.SystemInfo.supportsComputeShaders and UnityEngine.SystemInfo.graphicsMemorySize > 1024 then
		return 5
	end

	return 4
end

return var_0_0
