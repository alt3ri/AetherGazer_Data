slot0 = class("ScenePreviewItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.selectCon_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickFunc_ then
			uv0.clickFunc_()
		end
	end)
end

function slot0.RefreshData(slot0, slot1, slot2, slot3)
	slot0.id_ = slot1
	slot0.cfg_ = HomeSceneSettingCfg[slot0.id_]
	slot0.title_.text = slot0.cfg_.title
	slot0.source_.text = slot0.cfg_.obtain_word
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/SceneChangeUI/item/" .. slot0.id_)

	slot0:RefreshType(slot2, slot3)
	manager.redPoint:bindUIandKey(slot0.transform_, RedPointConst.SCENE .. "_" .. slot0.id_)
end

function slot0.RefreshType(slot0, slot1, slot2)
	slot0.selectCon_:SetSelectedState(slot2 and "true" or "false")

	slot3 = HomeSceneSettingData:GetCurScene()

	if slot1 == 0 then
		if #slot0.cfg_.obtain_way > 0 and not JumpTools.NeedHide(slot0.cfg_.obtain_way, slot0.id_) then
			slot0.typeCon_:SetSelectedState("get")
		else
			slot0.typeCon_:SetSelectedState("ban")
		end
	elseif slot3 == slot0.id_ then
		if slot1 == 1 then
			slot0.typeCon_:SetSelectedState("trial")
		elseif slot1 == 2 then
			slot0.typeCon_:SetSelectedState("using")
		end
	else
		slot0.typeCon_:SetSelectedState("normal")
	end
end

function slot0.RegistClickFunc(slot0, slot1)
	slot0.clickFunc_ = slot1
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.transform_)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
