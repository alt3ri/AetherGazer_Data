slot0 = class("AdminCatExploreItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.commendController = ControllerUtil.GetController(slot0.gameObject_.transform, "commend")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		if uv0.selectBtn then
			uv0.selectBtn(uv0.index)
		end
	end)
end

function slot0.GetStateController(slot0)
	return slot0.stateController
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.data = slot1
	slot0.isSelect = slot2
	slot0.selectBtn = slot3

	slot0:UpdateView()

	slot0.index = slot4
end

function slot0.UpdateView(slot0)
	if slot0.data == nil then
		slot0.stateController:SetSelectedState("no")
		slot0.commendController:SetSelectedState("off")

		return
	end

	slot1 = ExploreMeowCfg[slot0.data.id]
	slot2 = ExploreMeowSkillCfg[slot1.skill]
	slot3 = ExploreMeowInbornCfg[slot1.inborn]
	slot0.nameTxt_.text = GetI18NText(slot1.meow_name)
	slot0.skillLvTxt_.text = "Lv.<color=#EDF2F7><size=32>" .. AdminCatExploreData:GetDataByPara("skillData")[slot1.skill] .. "</size> </color>"

	slot0.commendController:SetSelectedState(slot0.data.recommend and "on" or "off")

	if slot0.isSelect and slot0.data.canUse then
		slot0.stateController:SetSelectedState("sel")
	else
		slot0.stateController:SetSelectedState(slot0.data.canUse and "normal" or "lock")
	end

	slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Managecat_s/" .. slot1.meow_icon)
	slot0.skillImg1_.sprite = getSpriteWithoutAtlas("TextureConfig/Chip/" .. slot3.inborn_icon)
	slot0.skillImg2_.sprite = getSpriteWithoutAtlas("TextureConfig/Chip/" .. slot2.skill_icon)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.selectBtn = nil

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
