local var_0_0 = require("cjson")
local var_0_1 = import("manager.share.ShareLogoView")
local var_0_2 = class("ShareMgr")

function var_0_2.Ctor(arg_1_0)
	arg_1_0:InitUI()
	arg_1_0:AddListeners()
	SetActive(arg_1_0.gameObject_, false)

	arg_1_0.shareCallbackHandler_ = handler(arg_1_0, arg_1_0.ShareCallback)

	manager.notify:RegistListener(SHARE_CALLBACK, arg_1_0.shareCallbackHandler_)
end

function var_0_2.InitUI(arg_2_0)
	arg_2_0.screenSnapPath_ = Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"

	local var_2_0 = GameObject.Find("UICamera_DontDestroy/Canvas/UIMessage/Canvas")
	local var_2_1 = "Atlas/Share"
	local var_2_2 = Asset.Load(var_2_1, true)
	local var_2_3 = "UI/Common/ShareUI"
	local var_2_4 = Asset.Load(var_2_3)

	arg_2_0.gameObject_ = GameObject.Instantiate(var_2_4, var_2_0.transform)
	arg_2_0.transform_ = arg_2_0.gameObject_.transform

	ComponentBinder.GetInstance():BindCfgUI(arg_2_0, arg_2_0.gameObject_)

	arg_2_0.shareLogoView_ = var_0_1.New(arg_2_0.goSnapPanel_)

	if not SDKTools.GetIsOverSea() then
		if arg_2_0.buttonTwiiter_ then
			SetActive(arg_2_0.buttonTwiiter_.transform.gameObject, false)
		end
	else
		SetActive(arg_2_0.buttonQQ_.transform.gameObject, false)
		SetActive(arg_2_0.buttonQQZone_.transform.gameObject, false)
		SetActive(arg_2_0.buttonWechat_.transform.gameObject, false)
		SetActive(arg_2_0.buttonWeibo_.transform.gameObject, false)
		SetActive(arg_2_0.buttonWechatMoments_.transform.gameObject, false)

		if arg_2_0.buttonTwiiter_ then
			SetActive(arg_2_0.buttonTwiiter_.transform.gameObject, true)
		end

		if SDKTools.GetIsThisServer({
			"kr"
		}) and arg_2_0.buttonTwiiter_ then
			SetActive(arg_2_0.buttonTwiiter_.transform.gameObject, false)
		end
	end
end

function var_0_2.Share(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	SetActive(arg_3_0.gameObject_, true)

	arg_3_0.shareCallback_ = arg_3_3

	manager.ui:EventEnabled(false)
	manager.tips:Show(false)
	arg_3_1()
	arg_3_0.shareLogoView_:HideLogo()
	manager.ui:ShowScreenTap(false)
	SetActive(arg_3_0.goSharePanel_, false)
	manager.achievementTips:Hide(true)
	WaitRenderFrameUtil.inst.StartScreenShot(function()
		local var_4_0 = tonumber(SettingData:GetSettingData().pic.resolution)
		local var_4_1, var_4_2 = SettingTools.GetSettingScreenSize(var_4_0)

		if not SDKTools.IsSDK() then
			var_4_1, var_4_2 = Screen.width, Screen.height
		end

		if arg_3_4 then
			arg_3_0.screenSnap_ = ScreenSnap.New(var_4_2, var_4_1)
			arg_3_0.screenSnap2_ = ScreenSnap.New(var_4_2, var_4_1)
		else
			arg_3_0.screenSnap_ = ScreenSnap.New(var_4_1, var_4_2)
			arg_3_0.screenSnap2_ = ScreenSnap.New(var_4_1, var_4_2)
		end

		arg_3_0.screenSnap_:Take()

		local var_4_3 = arg_3_0.screenSnap_:GetSprite()

		arg_3_0.imageBg_.sprite = var_4_3

		arg_3_0.shareLogoView_:ShowLogo(arg_3_5)
		WaitRenderFrameUtil.inst.StartScreenShot(function()
			arg_3_0.screenSnap2_:Take()
			arg_3_0.shareLogoView_:HideLogo()
			SetActive(arg_3_0.goSharePanel_, true)
			manager.achievementTips:Hide(false)
			manager.ui:ShowScreenTap(true)
			arg_3_2()
			manager.tips:Show(true)
			manager.ui:EventEnabled(true)

			var_4_3 = arg_3_0.screenSnap2_:GetSprite()
			arg_3_0.imageShot_.sprite = var_4_3
			arg_3_0.screenSnapPath_ = Application.persistentDataPath .. "/screen_snap/picture_for_share" .. manager.time:GetServerTime() .. ".jpg"

			arg_3_0.screenSnap2_:SaveSnap(arg_3_0.screenSnapPath_)
		end)
	end)
end

function var_0_2.AddListeners(arg_6_0)
	arg_6_0.buttonCancel_.onClick:AddListener(function()
		arg_6_0:OnClickClose()
	end)

	if arg_6_0.buttonQQ_ then
		arg_6_0.buttonQQ_.onClick:AddListener(function()
			arg_6_0:OnClickShare("QQ")
		end)
	end

	if arg_6_0.buttonQQZone_ then
		arg_6_0.buttonQQZone_.onClick:AddListener(function()
			arg_6_0:OnClickShare("QZone")
		end)
	end

	if arg_6_0.buttonWechat_ then
		arg_6_0.buttonWechat_.onClick:AddListener(function()
			arg_6_0:OnClickShare("Wechat")
		end)
	end

	if arg_6_0.buttonWechatMoments_ then
		arg_6_0.buttonWechatMoments_.onClick:AddListener(function()
			arg_6_0:OnClickShare("WechatMoments")
		end)
	end

	if arg_6_0.buttonWeibo_ then
		arg_6_0.buttonWeibo_.onClick:AddListener(function()
			arg_6_0:OnClickShare("SinaWeibo")
		end)
	end

	if arg_6_0.buttonTwiiter_ then
		arg_6_0.buttonTwiiter_.onClick:AddListener(function()
			arg_6_0:OnClickShare(nil)
		end)
	end

	arg_6_0.buttonSave_.onClick:AddListener(function()
		if GameToSDK.PLATFORM_ID == 2 then
			ReceiveSavePhotoMessage(true)
		else
			LuaForUtil.SavePhotoToAlbum(arg_6_0.screenSnapPath_)
		end
	end)
end

function var_0_2.RemoveListeners(arg_15_0)
	arg_15_0.buttonCancel_.onClick:RemoveAllListeners()
	arg_15_0.buttonQQ_.onClick:RemoveAllListeners()
	arg_15_0.buttonQQZone_.onClick:RemoveAllListeners()
	arg_15_0.buttonWechat_.onClick:RemoveAllListeners()
	arg_15_0.buttonWechatMoments_.onClick:RemoveAllListeners()
	arg_15_0.buttonWeibo_.onClick:RemoveAllListeners()
	arg_15_0.buttonTwiiter_.onClick:RemoveAllListeners()
	arg_15_0.buttonSave_.onClick:RemoveAllListeners()
end

function var_0_2.OnClickClose(arg_16_0)
	SetActive(arg_16_0.gameObject_, false)

	arg_16_0.screenSnap_ = nil
	arg_16_0.screenSnap2_ = nil
	arg_16_0.shareCallback_ = nil
end

function var_0_2.OnClickShare(arg_17_0, arg_17_1)
	if not SDKTools.IsSDK() then
		ShowTips("USE_MOBILE")

		return
	end

	local var_17_0 = GetTips("SHARE_TITLE")
	local var_17_1 = GetTips("SHARE_CONTENT")
	local var_17_2 = GetTips("SHARE_URL")
	local var_17_3 = {}
	local var_17_4
	local var_17_5 = arg_17_1 == nil and "Share" or "ShareWithPlatform"
	local var_17_6 = {
		imageUrl = "",
		messageType = var_17_5,
		url = var_17_2,
		title = var_17_0,
		content = var_17_1,
		imagePath = arg_17_0.screenSnapPath_,
		platform = arg_17_1
	}

	arg_17_0.paltform_ = arg_17_1

	local var_17_7 = var_0_0.encode(var_17_6)

	SendMessageToSDK(var_17_7)
end

function var_0_2.ShareCallback(arg_18_0, arg_18_1)
	if arg_18_1 == 0 then
		if arg_18_0.shareCallback_ then
			arg_18_0.shareCallback_()
		end
	elseif arg_18_1 == 2 then
		-- block empty
	end
end

function var_0_2.Dispose(arg_19_0)
	if arg_19_0.shareLogoView_ then
		arg_19_0.shareLogoView_:Dispose()

		arg_19_0.shareLogoView_ = nil
	end

	if arg_19_0.gameObject_ then
		manager.notify:RemoveListener(SHARE_CALLBACK, arg_19_0.shareCallbackHandler_)

		arg_19_0.shareCallbackHandler_ = nil

		arg_19_0:RemoveListeners()
		Object.Destroy(arg_19_0.gameObject_)

		arg_19_0.gameObject_ = nil
		arg_19_0.transform_ = nil
	end
end

return var_0_2
