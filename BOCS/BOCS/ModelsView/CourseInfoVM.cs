namespace BOCS.ModelsView
{
    public class CourseInfoVM
    {
        public int Id { get; set; }
        public string Title { get; set; } = "";
        public string? ThumbnailUrl { get; set; }
        public string? LatestYoutubeId { get; set; }   // টপে শো হবে
        public int DurationDays { get; set; } = 180;
        public int PriceBdt { get; set; } = 15000;
        public string? CreatedBy { get; set; } = "Admin";
        public List<OutlineGroupVM> Outlines { get; set; } = new();
    }

    public class OutlineGroupVM
    {
        public string Title { get; set; } = "";
        public List<OutlineItemVM> Items { get; set; } = new();
    }

    public class OutlineItemVM
    {
        public string Label { get; set; } = "";      // e.g. "Embryology 1 — Dr Prosun"
        public string YoutubeId { get; set; } = "";  // e.g. "ysz5S6PUM-U"
    }
}
