return function (slot0)
	return function (slot0)
		return function (slot0)
			if type(slot0) == "function" then
				print("debugAction(function):", slot0)
			else
				print("debugAction(action):", slot0.type)
			end

			return uv0(slot0)
		end
	end
end
