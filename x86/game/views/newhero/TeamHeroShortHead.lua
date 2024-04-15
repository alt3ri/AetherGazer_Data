slot0 = class("TeamHeroShortHead", HeroShortHead)

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.clickListener_ ~= nil then
			uv0.clickListener_(uv0.heroCfg_.id)
		end
	end)
end

return slot0
