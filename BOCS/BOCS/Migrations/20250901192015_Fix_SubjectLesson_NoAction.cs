using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BOCS.Migrations
{
    /// <inheritdoc />
    public partial class Fix_SubjectLesson_NoAction : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.Sql(@"
IF OBJECT_ID(N'[FK_CourseLessons_Subjects_SubjectId]', N'F') IS NOT NULL
    ALTER TABLE [CourseLessons] DROP CONSTRAINT [FK_CourseLessons_Subjects_SubjectId];
");
            migrationBuilder.DropForeignKey(
                name: "FK_CourseEnrollments_Courses_CourseId",
                table: "CourseEnrollments");

            migrationBuilder.DropForeignKey(
                name: "FK_CourseLessons_Courses_CourseId",
                table: "CourseLessons");

            migrationBuilder.DropForeignKey(
                name: "FK_CourseLessons_Subjects_SubjectId",
                table: "CourseLessons");

            migrationBuilder.DropIndex(
                name: "IX_Subjects_CourseId_SortOrder",
                table: "Subjects");

            migrationBuilder.DropIndex(
                name: "IX_Courses_Title",
                table: "Courses");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CourseLessons",
                table: "CourseLessons");

            migrationBuilder.DropIndex(
                name: "IX_CourseLessons_CourseId_SortOrder",
                table: "CourseLessons");

            migrationBuilder.DropPrimaryKey(
                name: "PK_CourseEnrollments",
                table: "CourseEnrollments");

            migrationBuilder.DropIndex(
                name: "IX_CourseEnrollments_CourseId_IsApproved_IsArchived",
                table: "CourseEnrollments");

            migrationBuilder.DropIndex(
                name: "IX_CourseEnrollments_StudentId_CourseId",
                table: "CourseEnrollments");

            migrationBuilder.RenameTable(
                name: "CourseLessons",
                newName: "Lessons");

            migrationBuilder.RenameTable(
                name: "CourseEnrollments",
                newName: "Enrollments");

            migrationBuilder.RenameIndex(
                name: "IX_CourseLessons_SubjectId",
                table: "Lessons",
                newName: "IX_Lessons_SubjectId");

            migrationBuilder.AlterColumn<int>(
                name: "SortOrder",
                table: "Subjects",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValue: 0);

            migrationBuilder.AlterColumn<int>(
                name: "PriceBdt",
                table: "Courses",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValue: 5000);

            migrationBuilder.AlterColumn<int>(
                name: "DurationDays",
                table: "Courses",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValue: 30);

            migrationBuilder.AlterColumn<int>(
                name: "SortOrder",
                table: "Lessons",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValue: 0);

            migrationBuilder.AlterColumn<bool>(
                name: "IsPublished",
                table: "Lessons",
                type: "bit",
                nullable: false,
                oldClrType: typeof(bool),
                oldType: "bit",
                oldDefaultValue: true);

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedAtUtc",
                table: "Lessons",
                type: "datetime2",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValueSql: "GETUTCDATE()");

            migrationBuilder.AlterColumn<string>(
                name: "StudentId",
                table: "Enrollments",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(450)",
                oldMaxLength: 450);

            migrationBuilder.AlterColumn<int>(
                name: "PriceAtEnrollment",
                table: "Enrollments",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValue: 0);

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedAt",
                table: "Enrollments",
                type: "datetime2",
                nullable: false,
                oldClrType: typeof(DateTime),
                oldType: "datetime2",
                oldDefaultValueSql: "GETUTCDATE()");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Lessons",
                table: "Lessons",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_Enrollments",
                table: "Enrollments",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Subjects_CourseId",
                table: "Subjects",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_Lessons_CourseId",
                table: "Lessons",
                column: "CourseId");

            migrationBuilder.CreateIndex(
                name: "IX_Enrollments_CourseId",
                table: "Enrollments",
                column: "CourseId");

            migrationBuilder.AddForeignKey(
                name: "FK_Enrollments_Courses_CourseId",
                table: "Enrollments",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Lessons_Courses_CourseId",
                table: "Lessons",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            // নতুন FK: NO ACTION
            migrationBuilder.AddForeignKey(
                name: "FK_CourseLessons_Subjects_SubjectId",
                table: "CourseLessons",
                column: "SubjectId",
                principalTable: "Subjects",
                principalColumn: "Id",
                onDelete: ReferentialAction.NoAction   // <- গুরুত্বপূর্ণ
            );
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Enrollments_Courses_CourseId",
                table: "Enrollments");

            migrationBuilder.DropForeignKey(
                name: "FK_Lessons_Courses_CourseId",
                table: "Lessons");

            migrationBuilder.DropForeignKey(
                name: "FK_Lessons_Subjects_SubjectId",
                table: "Lessons");

            migrationBuilder.DropIndex(
                name: "IX_Subjects_CourseId",
                table: "Subjects");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Lessons",
                table: "Lessons");

            migrationBuilder.DropIndex(
                name: "IX_Lessons_CourseId",
                table: "Lessons");

            migrationBuilder.DropPrimaryKey(
                name: "PK_Enrollments",
                table: "Enrollments");

            migrationBuilder.DropIndex(
                name: "IX_Enrollments_CourseId",
                table: "Enrollments");

            migrationBuilder.RenameTable(
                name: "Lessons",
                newName: "CourseLessons");

            migrationBuilder.RenameTable(
                name: "Enrollments",
                newName: "CourseEnrollments");

            migrationBuilder.RenameIndex(
                name: "IX_Lessons_SubjectId",
                table: "CourseLessons",
                newName: "IX_CourseLessons_SubjectId");

            migrationBuilder.AlterColumn<int>(
                name: "SortOrder",
                table: "Subjects",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "PriceBdt",
                table: "Courses",
                type: "int",
                nullable: false,
                defaultValue: 5000,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "DurationDays",
                table: "Courses",
                type: "int",
                nullable: false,
                defaultValue: 30,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<int>(
                name: "SortOrder",
                table: "CourseLessons",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<bool>(
                name: "IsPublished",
                table: "CourseLessons",
                type: "bit",
                nullable: false,
                defaultValue: true,
                oldClrType: typeof(bool),
                oldType: "bit");

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedAtUtc",
                table: "CourseLessons",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()",
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AlterColumn<string>(
                name: "StudentId",
                table: "CourseEnrollments",
                type: "nvarchar(450)",
                maxLength: 450,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AlterColumn<int>(
                name: "PriceAtEnrollment",
                table: "CourseEnrollments",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AlterColumn<DateTime>(
                name: "CreatedAt",
                table: "CourseEnrollments",
                type: "datetime2",
                nullable: false,
                defaultValueSql: "GETUTCDATE()",
                oldClrType: typeof(DateTime),
                oldType: "datetime2");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CourseLessons",
                table: "CourseLessons",
                column: "Id");

            migrationBuilder.AddPrimaryKey(
                name: "PK_CourseEnrollments",
                table: "CourseEnrollments",
                column: "Id");

            migrationBuilder.CreateIndex(
                name: "IX_Subjects_CourseId_SortOrder",
                table: "Subjects",
                columns: new[] { "CourseId", "SortOrder" });

            migrationBuilder.CreateIndex(
                name: "IX_Courses_Title",
                table: "Courses",
                column: "Title");

            migrationBuilder.CreateIndex(
                name: "IX_CourseLessons_CourseId_SortOrder",
                table: "CourseLessons",
                columns: new[] { "CourseId", "SortOrder" });

            migrationBuilder.CreateIndex(
                name: "IX_CourseEnrollments_CourseId_IsApproved_IsArchived",
                table: "CourseEnrollments",
                columns: new[] { "CourseId", "IsApproved", "IsArchived" });

            migrationBuilder.CreateIndex(
                name: "IX_CourseEnrollments_StudentId_CourseId",
                table: "CourseEnrollments",
                columns: new[] { "StudentId", "CourseId" });

            migrationBuilder.AddForeignKey(
                name: "FK_CourseEnrollments_Courses_CourseId",
                table: "CourseEnrollments",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CourseLessons_Courses_CourseId",
                table: "CourseLessons",
                column: "CourseId",
                principalTable: "Courses",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_CourseLessons_Subjects_SubjectId",
                table: "CourseLessons",
                column: "SubjectId",
                principalTable: "Subjects",
                principalColumn: "Id");
        }
    }
}
