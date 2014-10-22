using System;

namespace HC.Model.CodeView
{
    public class SerachKeyword : BaseModel
    {
        public int Id { get; set; }
        public int KeywordId { get; set; }
        public string Keyword { get; set; }
        public DateTime SearchDateTime { get; set; }
        public string ClinetAddress { get; set; }
    }
}