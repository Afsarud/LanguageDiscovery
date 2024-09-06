alter table SchoolInfo
add SendPasswordToTeacher bit default(0),
	TeachersEmail nvarchar(50) null