using System.Linq;

namespace HC.Framework.Extension
{
    /// <summary>
    ///     [扩展类]字符串扩展类
    /// </summary>
    public static class StringExtension
    {
        /// <summary>
        ///     判断路径是不是图片, true 是，false 不是
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static bool IsImage(this string input)
        {
            var extesion = new[] { "jpg", "jpeg", "png", "tiff", "gif", "bmp" };
            return extesion.Any(s => input.ToLower().EndsWith("." + s));
        }
       

        /// <summary>
        ///     判断字符串是否为空
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static bool IsEmpty(this string input)
        {
            return string.IsNullOrEmpty(input);
        } 
        /// <summary>
        /// 判断字符串不为空
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static bool IsNotEmpty(this string input)
        {
            return !string.IsNullOrEmpty(input);
        }
    }
}