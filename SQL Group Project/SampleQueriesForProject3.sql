--SAPMLE QUERIES
-- =========================================================
-- Author:	Nahiyan Ahmed

SELECT I.Instructor
FROM Faculty.Instructor as I
INNER JOIN Faculty.Department as D
ON I.InstructorID = D.DepartmentID
WHERE I.Instructor in (
SELECT D2.DepartmentID
FROM Faculty.Department as D2
WHERE D2.DepartmentName = 'Physics'
)

SELECT c3.DepartmentName
	,c2.CourseCode
	,COUNT(c1.ClassID) AS NumClasses
	,SUM(c1.Enrolled) AS TotalEnrollment
	,SUM(c1.Limit) AS TotalLimit
	,CAST(100. * SUM(c1.Enrolled) / SUM(c1.Limit) AS NUMERIC(6, 2)) AS PercentageEnrollment
FROM Education.Class AS c1
INNER JOIN Education.Course AS c2 ON c1.CourseID = c2.CourseID
INNER JOIN Faculty.Department AS c3 ON c2.DepartmentID = c3.DepartmentID
GROUP BY c3.DepartmentName
	,c2.CourseCode
HAVING SUM(c1.Limit) <> 0
ORDER BY c3.DepartmentName;

SELECT SUM(DATEDIFF(minute, c.StartTime, c.EndTime)) / COUNT(c.ClassID) AS AverageTime
FROM Education.Class AS c
INNER JOIN [Location].Room AS r ON c.RoomID = r.RoomID
WHERE r.RoomID = 'KY'

SELECT d.DepartmentName
	,COUNT(DISTINCT InstructorID) AS NumOfInstructors
FROM Faculty.Department AS d
INNER JOIN Faculty.InstructorDepartment AS id ON id.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY d.DepartmentName;

SELECT DISTINCT d.DepartmentName, c2.CourseCode, c2.CourseDescription
FROM Education.Class as c
	INNER JOIN Education.Course as c2
		ON c.CourseID = c2.CourseID
	INNER JOIN Faculty.Department as d
		ON c2.DepartmentID= d.DepartmentID
	INNER JOIN Time.ClassDay as cd
		ON c.ClassID = cd.ClassID
	INNER JOIN Time.Day as t
		ON cd.DayID = t.DayID
WHERE d.DepartmentName = 'Physics' AND t.Day = 'Friday'