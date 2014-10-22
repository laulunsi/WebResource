using System.Collections.Generic;

namespace HC.Ajax.Extension
{
    public static class ListExtension
    {
        public static string ToJson<T>(this List<T> list)
        {
            return Serializer.JsonSerialize(list);
        }

        public static string ToJson<T>(this IEnumerable<T> list)
        {
            return Serializer.JsonSerialize(list);
        }

        public static string ToXml<T>(this List<T> list)
        {
            return Serializer.XmlSerialize(list);
        }

        public static string ToXml<T>(this IEnumerable<T> list)
        {
            return Serializer.XmlSerialize(list);
        }
    }
}