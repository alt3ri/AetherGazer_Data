slot0 = class("BaseAstrolabe")

function slot0.Ctor(slot0)
	slot0.animationState = AstrolabeConst.AnimationState.none
	slot0.pathDic = {}

	slot0:CheckLoad()
end

function slot0.LoadAstrolabeByPath(slot0, slot1, slot2)
	slot0:CheckLoad()

	if slot0.heroID then
		slot0.lastHeroID = slot0.heroID
	end

	slot0.heroID = slot2
	slot5 = slot0[string.format("height_%sGo_", HeroPosAndRotCfg[slot2].hero_view_height)]
	slot0.gameObject = slot0:GetPrefab(slot1)

	for slot9, slot10 in pairs(slot0.pathDic) do
		if slot10 then
			slot10:SetActive(false)
		end
	end

	if slot0.gameObject and slot5 then
		slot0.gameObject.transform:SetParent(slot5.transform)

		slot0.gameObject.transform.localPosition = Vector3(0, 0, 0)

		ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject)

		slot0.animator = slot0.gameObject.transform:GetComponent("Animator")

		SetActive(slot0.gameObject, true)
		slot0:InitItem()
	end
end

function slot0.GetPrefab(slot0, slot1)
	if not slot0.pathDic[slot1] then
		slot0.pathDic[slot1] = Object.Instantiate(Asset.Load("UI/HeroGodHood/" .. slot1))

		slot0.pathDic[slot1].transform:SetParent(slot0.baseParent.transform)
	end

	return slot0.pathDic[slot1]
end

function slot0.InitItem(slot0)
end

function slot0.CheckLoad(slot0)
	if isNil(slot0.baseParent) then
		slot0.baseParent = Object.Instantiate(Asset.Load("UI/HeroGodHood/TX_GodHood"))
		slot0.baseParent.transform.localPosition = Vector3(500, 0, 0)

		ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.baseParent)

		slot0.itemS_ = {}
	end
end

function slot0.RefreshAnimationState(slot0, slot1)
	if slot0.animationState == slot1 and slot1 ~= 3 then
		return
	end

	slot0.animationState = slot1

	if slot2 == 5 and slot0.animationState == 1 then
		slot0:SetActive(true)
		slot0:PlayAni("TX_GodHood_01", 0, 0)
	elseif slot2 == 3 and slot0.animationState == 1 then
		slot0:SetActive(true)
		slot0:PlayAni("TX_GodHood_01", 0, 0)
	elseif slot2 == 3 and slot0.animationState == 2 then
		slot0:PlayAni("TX_GodHood_02", 0, 0)

		slot0.ClickAnimaton = false
	elseif slot2 == 6 and slot0.animationState == 2 then
		slot0:PlayAni("TX_GodHood_02", 0, 0)
	elseif slot2 == 2 and slot0.animationState == 1 then
		slot0:PlayAni("TX_GodHood_04", 0, 0)
	elseif slot2 == 1 and slot0.animationState == 3 and not slot0.ClickAnimaton then
		slot0:PlayAni("TX_GodHood_03", 0, 0)
	elseif slot2 == 4 and slot0.animationState == 2 then
		slot0:SetActive(true)
	elseif slot2 == 4 and slot0.animationState == 1 then
		slot0:SetActive(true)
		slot0:PlayAni("TX_GodHood_04", 0, 1)
	elseif slot0.animationState == 5 then
		slot0:SetActive(false)
	end
end

function slot0.SetClickAnimaton(slot0, slot1)
	slot0.ClickAnimaton = slot1
end

function slot0.PlayAni(slot0, slot1, slot2, slot3)
	if slot0.animator and not isNil(slot0.animator) then
		slot0.animator:Play(slot1, slot2 or 0, slot3 or 0)
	end
end

function slot0.PlayAni2(slot0, slot1, slot2)
	if slot0.animator and not isNil(slot0.animator) then
		slot0.animator:CrossFade(slot1, slot2 or 0)
	end
end

function slot0.UpdateAni(slot0, slot1)
	if slot0.animator and not isNil(slot0.animator) then
		slot0.animator:Update(slot1)
	end
end

function slot0.PlayAni1(slot0, slot1)
	if slot0.animator and not isNil(slot0.animator) then
		slot0.animator:Play(slot1)
	end
end

function slot0.SetActive(slot0, slot1)
	if slot0.baseParent then
		slot0.baseParent.gameObject:SetActive(slot1)
	end

	if slot1 then
		if slot0.raycaster == nil then
			slot0.raycaster = manager.ui.mainCamera:AddComponent(typeof(PhysicsRaycaster))
		end
	elseif slot0.raycaster then
		Object.Destroy(slot0.raycaster)

		slot0.raycaster = nil
	end
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1
end

function slot0.OnClick(slot0)
	if slot0.clickFunc then
		slot0:clickFunc()
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.OnExit(slot0)
	if slot0.raycaster then
		Object.Destroy(slot0.raycaster)

		slot0.raycaster = nil
	end
end

function slot0.PlayExitAnimator(slot0)
	AnimatorTools.PlayAnimationWithCallback(slot0.animator, "TX_GodHood_03", function ()
		if uv0.gameObject then
			SetActive(uv0.gameObject, false)
		end

		AnimatorTools.Stop()
	end)
end

function slot0.Dispose(slot0)
	AnimatorTools.Stop()

	slot0.gameObject = nil
	slot0.animator = nil

	slot0:ClearItem()

	for slot4, slot5 in ipairs(slot0.pathDic) do
		Object.Destroy(slot5)
	end

	slot0.pathDic = {}

	if slot0.baseParent then
		Object.Destroy(slot0.baseParent)

		slot0.baseParent = nil
	end

	if slot0.raycaster then
		Object.Destroy(slot0.raycaster)

		slot0.raycaster = nil
	end
end

return slot0
