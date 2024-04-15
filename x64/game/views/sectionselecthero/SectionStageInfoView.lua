slot0 = class("SectionStageInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Show(true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.attributeItemList_ = {}
end

function slot0.SetProxy(slot0, slot1)
	slot0.sectionProxy_ = slot1
	slot0.stageType_ = slot0.sectionProxy_.stageType
	slot0.stageID_ = slot0.sectionProxy_.stageID
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshTitle()
	slot0:RefreshRecommend()
	slot0:RefreshRecommendAttribute()
end

function slot0.RefreshTitle(slot0)
	slot0.titleText_.text = BattleStageTools.GetStageName(slot0.stageType_, slot0.stageID_)
end

function slot0.RefreshRecommend(slot0)
	if slot0:GetRecommendLevel() == 0 then
		SetActive(slot0.recommendLevelGo_, false)
	else
		SetActive(slot0.recommendLevelGo_, true)

		slot0.recommendLevel_.text = slot1
	end
end

function slot0.GetRecommendLevel(slot0)
	return BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).recommend_level or 0
end

function slot0.RefreshRecommendAttribute(slot0)
	if #(BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).recommend_attribute_list or {}) > 0 then
		slot6 = true

		SetActive(slot0.attributePanelGo_, slot6)

		for slot6, slot7 in ipairs(slot2) do
			if not slot0.attributeItemList_[slot6] then
				slot0.attributeItemList_[slot6] = SectionAttributeItem.New(slot0.attributeGo_, slot0.attributeContentTrans_)
			end

			slot0.attributeItemList_[slot6]:SetData(slot7)
		end

		for slot6 = #slot2 + 1, #slot0.attributeItemList_ do
			slot0.attributeItemList_[slot6]:Show(false)
		end
	else
		SetActive(slot0.attributePanelGo_, false)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.attributeItemList_) do
		slot5:Dispose()
	end

	slot0.attributeItemList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
