Create procedure usp_GetAllTimeSchedule
AS
BEGIN

	SELECT * FROM TimeScheduleAux where Active = 1

END