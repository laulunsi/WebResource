namespace HC.Model.CodeView
{
    public class SearchResult : BaseModel
    {
        public string Number { get; set; }
        public string Title { get; set; }
        public string FullPath { get; set; }
        public string BodyPreview { get; set; }
    }
}