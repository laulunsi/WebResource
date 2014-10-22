namespace HC.Model.CodeView
{
    public class SearchSum : BaseModel
    {
        public int Id { get; set; }
        public string Keyword { get; set; }
        public int SearchCount { get; set; }
    }
}