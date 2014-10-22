using System;
using System.Configuration;
using System.Web;
using System.Web.Caching;

namespace HC.Dal
{
    public class DbHelper
    {
        /// <summary>
        ///     获取数据库类型
        /// </summary>
        private static string CurrentDbType
        {
            get
            {
                if (HttpRuntime.Cache["CurrentDbType"] == null)
                {
                    string dbType = ConfigurationManager.AppSettings.Get("UseDbType");
                    if (!string.IsNullOrEmpty(dbType))
                    {
                        var cdy = new CacheDependency(HttpRuntime.AppDomainAppPath + "web.config");
                        HttpRuntime.Cache.Insert("CurrentDbType", ConfigurationManager.AppSettings.Get("UseDbType"), cdy);
                    }
                    else
                    {
                        throw new ArgumentNullException("找不到数据库配置：请检查web.config节点<appSettings></appSettings>是否存在节点UseDbType");
                    }
                }
                return HttpRuntime.Cache["CurrentDbType"].ToString();
            }
        }

        /// <summary>
        ///     获取当前数据库支持的操作
        /// </summary>
        public static Database CurrentDb
        {
            get
            {
                HttpContext context = HttpContext.Current;

                if (null == context)
                {
                    return NewDb;
                }
                if (HttpContext.Current.Items["CurrentDb"] == null)
                {
                    var db = new Database(CurrentDbType);
                    HttpContext.Current.Items["CurrentDb"] = db;
                    return db;
                }
                return (Database)HttpContext.Current.Items["CurrentDb"];
            }
        }

        /// <summary>
        ///     返回新数据库链接实例
        /// </summary>
        public static Database NewDb
        {
            get { return new Database(CurrentDbType); }
        }

        /// <summary>
        ///     获取当前数据库支持的操作,可定时器调用，没用使用到HttpContext.Current
        /// </summary>
        public static Database RuntimeDb
        {
            get
            {
                return CurrentDb;
            }
        }
    }
}