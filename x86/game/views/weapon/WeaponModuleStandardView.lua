WeaponModuleView = import("game.views.weapon.WeaponModuleView")
slot0 = class("WeaponModuleStandardView", WeaponModuleView)

function slot0.AddRedPoint(slot0)
end

function slot0.RemoveRedPoint(slot0)
end

function slot0.GetModuleLevel(slot0)
	return slot0.params_.moduleLevel
end

function slot0.GetModuleMaxLevel(slot0)
	return slot0:GetModuleLevel()
end

return slot0
