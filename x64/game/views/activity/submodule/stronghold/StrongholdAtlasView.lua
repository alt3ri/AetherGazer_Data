slot0 = class("StrongholdAtlasView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdAtlasUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, StrongholdAtlasItem)
	slot0.typeController = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.atlasType1Btn, function ()
		uv0:SelectAtlas(0)
	end)
	slot0:AddBtnListener(nil, slot0.atlasType2Btn, function ()
		uv0:SelectAtlas(1)
	end)
	slot0:AddBtnListener(nil, slot0.atlasType3Btn, function ()
		uv0:SelectAtlas(2)
	end)
	slot0:AddBtnListener(nil, slot0.atlasType4Btn, function ()
		uv0:SelectAtlas(3)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.activity_id

	slot0:SelectAtlas(0, true)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.SelectAtlas(slot0, slot1, slot2)
	if slot1 == slot0.curIndex_ and not slot2 then
		return
	end

	slot0.curIndex_ = slot1

	slot0.typeController:SetSelectedIndex(slot1)

	slot0.atlas = ActivityStrongholdArtifactCfg.get_id_list_by_type[slot1] or {}

	table.sort(slot0.atlas, function (slot0, slot1)
		if (StrongholdData:GetAtlasUseCount(uv0.activity_id, slot0) == 0 and 0 or 1) == (StrongholdData:GetAtlasUseCount(uv0.activity_id, slot1) == 0 and 0 or 1) then
			return ActivityStrongholdArtifactCfg[slot1].rare < ActivityStrongholdArtifactCfg[slot0].rare
		else
			return slot3 < slot2
		end
	end)

	for slot7, slot8 in ipairs(slot0.atlas) do
		if StrongholdData:GetAtlasUseCount(slot0.activity_id, slot8) ~= 0 then
			slot3 = 0 + 1
		end
	end

	slot4 = #slot0.atlas
	slot0.m_processLab.text = slot3 .. "/" .. slot4

	slot0.list:StartScroll(slot4)
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.atlas[slot1], slot0.activity_id)
end

return slot0
