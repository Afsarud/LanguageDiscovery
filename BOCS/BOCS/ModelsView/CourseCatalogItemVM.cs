namespace BOCS.ModelsView
{
    public class CourseCatalogItemVM
    {
        public int Id { get; set; }
        public string Title { get; set; } = "";
        public string? ThumbnailUrl { get; set; }

        // UI-only placeholders (DB না থাকলেও দেখাবে)
        public int DurationDays { get; set; } = 180;
        public int PriceBdt { get; set; } = 15000;

        public int NotificationCount { get; set; } = 0; // চাইলে দেখাবে
    }
}
