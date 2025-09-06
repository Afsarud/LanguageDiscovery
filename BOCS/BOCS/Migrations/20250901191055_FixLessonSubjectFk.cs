using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BOCS.Migrations
{
    /// <inheritdoc />
    public partial class FixLessonSubjectFk : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CourseLessons_Subjects_SubjectId",
                table: "CourseLessons");

            migrationBuilder.DropIndex(
                name: "IX_Subjects_CourseId",
                table: "Subjects");

            migrationBuilder.AlterColumn<int>(
                name: "SortOrder",
                table: "Subjects",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.CreateIndex(
                name: "IX_Subjects_CourseId_SortOrder",
                table: "Subjects",
                columns: new[] { "CourseId", "SortOrder" });

            migrationBuilder.AddForeignKey(
                name: "FK_CourseLessons_Subjects_SubjectId",
                table: "CourseLessons",
                column: "SubjectId",
                principalTable: "Subjects",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CourseLessons_Subjects_SubjectId",
                table: "CourseLessons");

            migrationBuilder.DropIndex(
                name: "IX_Subjects_CourseId_SortOrder",
                table: "Subjects");

            migrationBuilder.AlterColumn<int>(
                name: "SortOrder",
                table: "Subjects",
                type: "int",
                nullable: false,
                oldClrType: typeof(int),
                oldType: "int",
                oldDefaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Subjects_CourseId",
                table: "Subjects",
                column: "CourseId");

            migrationBuilder.AddForeignKey(
                name: "FK_CourseLessons_Subjects_SubjectId",
                table: "CourseLessons",
                column: "SubjectId",
                principalTable: "Subjects",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }
    }
}
