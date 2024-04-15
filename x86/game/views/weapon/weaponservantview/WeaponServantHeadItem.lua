slot0 = class("WeaponServantHeadItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.BuildContext(slot0)
	slot1 = slot0.gameObject_:GetComponent("ControllerExCollection")
	slot0.controller = {
		comps = slot1,
		state = {
			select = {
				False = "false",
				name = "select",
				True = "true",
				comps = slot1:GetController("select")
			},
			mask = {
				False = "false",
				name = "mask",
				True = "true",
				comps = slot1:GetController("mask")
			},
			star = {
				Star1 = "star1",
				name = "star",
				Star4 = "star4",
				Star5 = "star5",
				Star3 = "star3",
				Star2 = "star2",
				comps = slot1:GetController("star")
			}
		}
	}
	slot0.data = {
		info = {}
	}
	slot0.constVar = {
		isShowLock = true,
		lockImg = {
			unlocked = "com_white_icon_26",
			locked = "com_white_icon_25"
		}
	}
end

function slot0.InitContext(slot0)
	slot0.data.info = {}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, function ()
		if uv0.data.clickCallback then
			uv0.data.clickCallback(uv0)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.data.clickCallback = slot1
end

function slot0.OnRender(slot0, slot1)
	slot0:InitContext()

	slot0.data.info = slot1
	slot2 = slot1.id
	slot0.roleIconImg_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponServant/Icon438x238/" .. slot2)
	slot0.levelTxt_.text = slot1.number
	slot4 = ItemCfg[slot2].rare
	slot0.qualityImg_.sprite = getSprite("Atlas/Hero_servantAtlas", string.format("img_servantGrade_0%d", 6 - slot4))

	slot0:SwitchControllerState(slot0.controller.state.star.name, string.format("star%d", slot4))

	slot0.servantGroupImg_.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", WeaponServantCfg[slot2].race))
end

function slot0.RenderEquipStatus(slot0, slot1, slot2)
	SetActive(slot0.avatarObj_, slot1 or false)

	if slot1 then
		slot0.avatarIcon_.sprite = HeroTools.GetSmallHeadSprite(slot2)
	end
end

function slot0.ShowSelect(slot0, slot1)
	slot2 = slot0.controller.state.select.False

	if slot1 then
		slot2 = slot0.controller.state.select.True
	end

	slot0:SwitchControllerState(slot0.controller.state.select.name, slot2)
end

function slot0.ShowMask(slot0, slot1)
	slot2 = slot0.controller.state.mask.False

	if slot1 then
		slot2 = slot0.controller.state.mask.True
	end

	slot0:SwitchControllerState(slot0.controller.state.mask.name, slot2)
end

function slot0.ShowLock(slot0, slot1)
	if slot0.constVar.isShowLock then
		SetActive(slot0.lockRootObj_, slot1)
	end
end

function slot0.ShowLockObj(slot0, slot1)
	slot0.constVar.isShowLock = slot1

	SetActive(slot0.lockRootObj_, slot1 or false)
end

function slot0.ShowRecommendTag(slot0, slot1)
	SetActive(slot0.recommendObj_, slot1 or false)
end

function slot0.GetItemUid(slot0)
	if slot0.data.info then
		return slot0.data.info.uid
	end

	return 0
end

function slot0.GetIndex(slot0)
	if slot0.data.info then
		return slot0.data.info.index
	end

	return nil
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller.state[slot1] then
		slot4.comps:SetSelectedState(slot2)
	end
end

return slot0
