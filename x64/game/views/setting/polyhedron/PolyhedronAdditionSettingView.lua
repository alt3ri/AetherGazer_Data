slot0 = class("PolyhedronAdditionSettingView", ReduxView)

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.stageData = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0.clickTerminalHandler_ = handler(slot0, slot0.PopInfo)

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_beaconTrs, function ()
		uv0:Select(3)
		SetActive(uv0.m_terminalDescGo, false)
	end)
	slot0:AddBtnListener(nil, slot0.m_artifaceTrs, function ()
		uv0:Select(1)
		SetActive(uv0.m_terminalDescGo, false)
	end)
	slot0:AddBtnListener(nil, slot0.m_talentTrs, function ()
		uv0:Select(2)
		SetActive(uv0.m_terminalDescGo, false)
	end)
	slot0:AddBtnListener(slot0.m_infoMask, nil, function ()
		SetActive(uv0.m_terminalDescGo, false)
	end)
end

function slot0.PopInfo(slot0, slot1, slot2, slot3)
	SetActive(slot0.m_terminalDescGo, true)

	slot0.m_terminalDescTrans.position = slot3
	slot0.m_terminalDescTitle.text = GetI18NText(slot1)
	slot0.m_terminalDesc.text = GetI18NText(slot2)
end

function slot0.Select(slot0, slot1)
	slot0.toggleController_1:SetSelectedIndex(slot1 == 1 and 1 or 0)
	slot0.toggleController_2:SetSelectedIndex(slot1 == 2 and 1 or 0)
	slot0.toggleController_3:SetSelectedIndex(slot1 == 3 and 1 or 0)

	if slot1 == 1 then
		slot0:RefreshArtifact()
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.beaconList = {}
	slot0.toggleController_3 = ControllerUtil.GetController(slot0.m_beaconTrs, "name")
	slot0.toggleController_1 = ControllerUtil.GetController(slot0.m_artifaceTrs, "name")
	slot0.toggleController_2 = ControllerUtil.GetController(slot0.m_talentTrs, "name")
	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()
	slot0.beacon_id_list = slot0.polyhedronInfo:GetBeaconList()

	for slot5 = 1, #slot0.beacon_id_list do
		if not slot0.beaconList[slot5] then
			slot0.beaconList[slot5] = PolyhedronSetBeaconItem.New(slot0.m_beaconTemplate, slot0.m_beaconContentTrs)
		end

		slot0.beaconList[slot5]:SetData(slot0.beacon_id_list[slot5])
	end

	for slot5 = slot1 + 1, #slot0.beaconList do
		slot0.beaconList[slot5]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_beaconContentTrs)

	if slot1 > 0 then
		SetActive(slot0.m_beaconEmpty, false)
	else
		SetActive(slot0.m_beaconEmpty, true)
	end

	slot0.artifactGroupList = {}

	slot0:RefreshArtifact()

	slot0.terminalGroupList = {}
	slot0.terminal_id_list = slot0.polyhedronInfo:GetTerminalIdList()
	slot0.terminal_group_data = {}

	for slot5, slot6 in ipairs(slot0.terminal_id_list) do
		if not slot0.terminal_group_data[PolyhedronTerminalCfg[slot6].classify] then
			slot0.terminal_group_data[slot7.classify] = {}
		end

		table.insert(slot0.terminal_group_data[slot7.classify], slot6)
	end

	slot2 = 1

	for slot6, slot7 in pairs(slot0.terminal_group_data) do
		if not slot0.terminalGroupList[slot2] then
			slot0.terminalGroupList[slot2] = PolyhedronSetTerminalGroup.New(Object.Instantiate(slot0.m_termianlGroup, slot0.m_termianlContent))
		end

		slot0.terminalGroupList[slot2]:SetActive(true)
		slot0.terminalGroupList[slot2]:SetData(slot6, slot7)
		slot0.terminalGroupList[slot2]:RegistCallBack(slot0.clickTerminalHandler_)

		slot2 = slot2 + 1
	end

	for slot7 = slot2, #slot0.terminalGroupList do
		slot0.terminalGroupList[slot7]:SetActive(false)
	end

	if table.length(slot0.terminal_group_data) > 0 then
		SetActive(slot0.m_terminalEmpty, false)
	else
		SetActive(slot0.m_terminalEmpty, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_termianlContent)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.transform_)

	slot0.data = clone(PolyhedronData:GetTerminalGift())
	slot0.allPoint = PolyhedronTerminalLevelCfg[PolyhedronData:GetTerminalLevel()].point
	slot5 = PolyhedronData:GetTerminalLevel()
	slot6 = PolyhedronData:GetTerminalExp()
	slot0.m_levelLab.text = "" .. slot5

	if slot5 == #PolyhedronTerminalLevelCfg.all then
		slot0.m_expSlider.fillAmount = 1
		slot7 = PolyhedronTerminalLevelCfg[slot5].exp - PolyhedronTerminalLevelCfg[slot5 - 1].exp
		slot0.m_expLab.text = slot7 .. "/" .. slot7
	else
		slot7 = PolyhedronTerminalLevelCfg[slot5 + 1].exp - PolyhedronTerminalLevelCfg[slot5].exp
		slot0.m_expSlider.fillAmount = slot6 / slot7
		slot0.m_expLab.text = slot6 .. "/" .. slot7
	end

	slot0.m_pointLab.text = slot0.allPoint - slot0:GetUsePoint()
	slot0.clickhandler = handler(slot0, slot0.PopInfo)

	slot0:Select(1)
end

function slot0.OnEnter(slot0)
	SetActive(slot0.m_terminalDescGo, false)

	slot0.polyhedronInfo = PolyhedronData:GetPolyhedronInfo()

	slot0:RefreshArtifact()
end

function slot0.RefreshArtifact(slot0)
	slot0.artifact_list = slot0.polyhedronInfo:GetArtifactList()
	slot0.artifact_group_data = {}

	for slot4, slot5 in ipairs(slot0.artifact_list) do
		if not slot0.artifact_group_data[PolyhedronArtifactCfg[slot5.id].sub_type] then
			slot0.artifact_group_data[slot7.sub_type] = {}
		end

		table.insert(slot0.artifact_group_data[slot7.sub_type], slot5)
	end

	slot1 = table.keys(slot0.artifact_group_data)

	table.sort(slot1, PolyhedronTools.ArtifactSubTypeSorter)

	slot2 = 1

	for slot6, slot7 in ipairs(slot1) do
		slot8 = slot0.artifact_group_data[slot7]

		if not slot0.artifactGroupList[slot2] then
			slot0.artifactGroupList[slot2] = PolyhedronSetArtifactGroup.New(Object.Instantiate(slot0.m_artifactGroup, slot0.m_artifactContent))
		end

		slot0.artifactGroupList[slot2]:SetActive(true)
		slot0.artifactGroupList[slot2]:SetData(slot7, slot8)
		slot0.artifactGroupList[slot2]:RegistCallBack(slot0.clickhandler)

		slot2 = slot2 + 1
	end

	for slot7 = slot2, #slot0.artifactGroupList do
		slot0.artifactGroupList[slot7]:SetActive(false)
	end

	if table.length(slot0.artifact_group_data) > 0 then
		SetActive(slot0.m_artifactEmpty, false)
	else
		SetActive(slot0.m_artifactEmpty, true)
	end

	slot0:RebuildArtifactLayout()
end

function slot0.RebuildArtifactLayout(slot0)
	if slot0.artifactRebuildTimer_ then
		slot0.artifactRebuildTimer_:Stop()

		slot0.artifactRebuildTimer_ = nil
	end

	slot0.artifactRebuildTimer_ = FrameTimer.New(function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.m_artifactContent)

		if uv0.artifactRebuildTimer_ then
			uv0.artifactRebuildTimer_:Stop()

			uv0.artifactRebuildTimer_ = nil
		end
	end, 1, 1)

	slot0.artifactRebuildTimer_:Start()
end

function slot0.GetUsePoint(slot0)
	for slot5, slot6 in pairs(slot0.data) do
		slot1 = 0 + PolyhedronTerminalCfg[slot6].cost
	end

	return slot1
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.artifactGroupList) do
		slot5:Dispose()
	end

	slot0.artifactGroupList = nil

	for slot4, slot5 in ipairs(slot0.terminalGroupList) do
		slot5:Dispose()
	end

	slot0.terminalGroupList = nil

	for slot4, slot5 in ipairs(slot0.beaconList) do
		slot5:Dispose()
	end

	slot0.beaconList = nil

	if slot0.artifactRebuildTimer_ then
		slot0.artifactRebuildTimer_:Stop()

		slot0.artifactRebuildTimer_ = nil
	end

	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
