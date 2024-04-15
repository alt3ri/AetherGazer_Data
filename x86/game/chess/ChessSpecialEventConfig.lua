return {
	[20601] = {
		[9] = function (slot0, slot1)
			if manager.ChessManager:GetExecutingChess().status == 0 then
				-- Nothing
			elseif slot3 == 1 then
				slot4[1] = {
					eventID = 10104,
					params = {
						slot1
					}
				}
			end

			manager.ChessManager:InsertEventQueue({
				{
					eventID = 10104,
					params = {
						slot0
					}
				}
			})
			manager.ChessManager:DoNextEvent()
		end
	}
}
