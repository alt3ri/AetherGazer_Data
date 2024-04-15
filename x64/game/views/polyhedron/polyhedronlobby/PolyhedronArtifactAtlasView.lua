slot0 = class("PolyhedronArtifactAtlasView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Polyhedron/PolyhedronAtlasUI"
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

	slot0.tree_ = LuaTree.New(slot0.uitreeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect), handler(slot0, slot0.OnItemSelect))

	slot0.itemList_ = {}

	slot0:InitTree()
end

function slot0.InitTree(slot0)
	slot1 = UITreeData.New()
	slot2 = UITreeGroupData.New()
	slot2.id = 1
	slot2.text = GetTips("POLYHEDRON_ARTIFACT_TITLE_1")

	for slot6, slot7 in pairs(PolyhedronArtifactCfg.get_id_list_by_exclusive_hero_id) do
		if slot6 ~= 0 then
			slot8 = UITreeItemData.New()
			slot8.id = slot6
			slot8.text = GetI18NText(HeroCfg[slot6].name)
			slot8.extraData = "exclusive"

			slot2.itemDatas:Add(slot8)
		end
	end

	slot3 = UITreeGroupData.New()
	slot3.id = 2
	slot3.text = GetTips("POLYHEDRON_ARTIFACT_TITLE_2")
	slot4 = {}

	for slot8, slot9 in pairs(PolyhedronArtifactCfg.get_id_list_by_sub_type) do
		slot4[#slot4 + 1] = slot8
	end

	function slot8(slot0, slot1)
		return slot0 < slot1
	end

	table.sort(slot4, slot8)

	for slot8, slot9 in pairs(slot4) do
		if slot9 ~= 3007 then
			slot10 = UITreeItemData.New()
			slot10.id = slot9
			slot10.text = PolyhedronTools.GetPolyhedronArtifactSubTypeDes(slot9)
			slot10.extraData = "common"

			slot3.itemDatas:Add(slot10)
		end
	end

	slot1.groupDatas:Add(slot2)
	slot1.groupDatas:Add(slot3)
	slot0.tree_:SetData(slot1)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
end

function slot0.OnItemSelect(slot0, slot1, slot2, slot3, slot4)
	if slot4 == "exclusive" then
		slot0.array = PolyhedronArtifactCfg.get_id_list_by_exclusive_hero_id[slot2]
	elseif slot4 == "common" then
		slot0.array = PolyhedronArtifactCfg.get_id_list_by_sub_type[slot2]
	else
		slot0.array = {}
	end

	for slot9, slot10 in ipairs(slot0.array) do
		if PolyhedronData:GetArtifaceAtlasState(slot10) == 2 then
			slot5 = 0 + 1
		end
	end

	for slot10 = 1, #slot0.array do
		if not slot0.itemList_[slot10] then
			slot0.itemList_[slot10] = PolyhedronArtifactAtlasIItem.New(slot0.itemTemplate_, slot0.contentTrans_)
		end

		slot0.itemList_[slot10]:SetData(slot0.array[slot10])
	end

	for slot10 = slot6 + 1, #slot0.itemList_ do
		slot0.itemList_[slot10]:SetActive(false)
	end

	slot0.contentTrans_:SetAnchoredPositionY(0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)

	slot0.m_processLab.text = slot5 .. "/" .. slot6
end

function slot0.AddUIListener(slot0)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.tree_:SelectGroup(1)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.array[slot1])
end

function slot0.Dispose(slot0)
	slot0.tree_:Dispose()

	for slot4, slot5 in ipairs(slot0.itemList_) do
		slot5:Dispose()
	end

	slot0.itemList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
