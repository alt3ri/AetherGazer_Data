slot0 = class("CombineGameRoleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.data = slot1
	slot0.lv = slot2
	slot0.type = slot3

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	SetActive(slot0.maskGo_, slot0.lv < slot0.data.lv)

	slot0.LvTxt_.text = "等级" .. slot0.data.lv .. "解锁"

	if slot0.type == 1 then
		slot2 = ActivityCombineSkillCfg[ActivityCombineFactorCfg[slot0.data.id].effect[1]]
		slot0.descTxt_.text = GetI18NText(slot2.description)
		slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot2.icon)
	else
		slot0.descTxt_.text = GetI18NText(slot1.description)
		slot0.iconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot1.icon)
	end
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
