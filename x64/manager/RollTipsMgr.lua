slot0 = singletonClass("RollTipsMgr")

function slot0.Ctor(slot0)
	slot0.viewGo_ = nil
	slot0.viewLua_ = nil
	slot0.cachePop_ = false
end

function slot0.CreatTips(slot0, slot1, slot2)
	if slot0.viewGo_ == nil then
		slot0.viewGo_ = Object.Instantiate(Asset.Load("UI/BulletinBoardTips"), manager.ui.dontDestroyCanvas.transform)
		slot0.viewLua_ = RollTipsView.New(slot0.viewGo_)

		slot0.viewLua_:Play(slot1)
	else
		SetActive(slot0.viewGo_, true)
		slot0.viewLua_:Play(slot1)
	end
end

function slot0.CreateTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			slot0, slot1 = BulletinData.GetCurCacheStringAndID()

			uv0:CountTipsAndCreateWithoutTimer(slot0, slot1)
		end, 300, 2)

		slot0.timer_:Start()
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.SetCachePop(slot0, slot1)
	slot0.cachePop_ = slot1
end

function slot0.OnLogout(slot0)
	slot0:StopTimer()
	slot0:Dispose()
end

function slot0.CountTipsAndCreate(slot0, slot1, slot2)
	if BulletinData.GetCacheStringIsShowByID(slot2) == false then
		slot0:CreatTips(slot1, slot2)
		BulletinData.SetCacheStringIsShowByID(slot2)
		slot0:CreateTimer()
	end
end

function slot0.CountTipsAndCreateWithoutTimer(slot0, slot1, slot2)
	if BulletinData.GetCacheStringIsShowByID(slot2) == false then
		slot0:CreatTips(slot1, slot2)
		BulletinData.SetCacheStringIsShowByID(slot2)
	end
end

function slot0.TryToCreatTips(slot0)
	if slot0.cachePop_ == true and BulletinData.GetIslogin() then
		slot1, slot2 = BulletinData.GetCurCacheStringAndID()

		if slot1 then
			slot0:SetCachePop(false)
			slot0:CountTipsAndCreate(slot1, slot2)
		end
	end
end

function slot0.Dispose(slot0)
	slot0.cachePop_ = false

	if slot0.viewGo_ then
		Object.Destroy(slot0.viewGo_)

		slot0.viewGo_ = nil
	end

	if slot0.viewLua_ then
		slot0.viewLua_:Dispose()

		slot0.viewLua_ = nil
	end
end

return slot0
