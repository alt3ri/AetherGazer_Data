slot0 = class("SectionSelectRaceDescriptionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerExCollection_:GetController("stage")
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.raceID_ = slot1
	slot0.isActive_ = slot2
	slot0.sameCamp_ = slot3
	slot4 = RaceEffectCfg[slot0.raceID_]
	slot0.raceIcon_.sprite = HeroTools.GetRaceIcon(slot0.raceID_)
	slot0.raceName_.text = slot4.name
	slot0.battleDesc_.text = slot4.battle_desc
	slot0.desc_.text = slot4.desc

	if slot0.isActive_ then
		if slot0.sameCamp_ then
			slot0.stateController_:SetSelectedState("max")
		else
			slot0.stateController_:SetSelectedState("active")
		end
	else
		slot0.stateController_:SetSelectedState("none")
	end
end

return slot0
