//--------------------------------------------------------------------------------
// 文件描述：管理员业务逻辑类
// 文件作者：张清山 
// 创建日期：2014-05-07 21:14:44
// 修改记录： 
//--------------------------------------------------------------------------------

using System.Collections.Generic;
using HC.Dal;
using HC.Framework.Extension;

namespace HC.Service.Admin.Administrators
{
    /// <summary>
    ///     管理员管理业务类
    /// </summary>
    public class AdministratorsService : DbBase<Model.Admin.Administrators.Administrators>
    {
        private static AdministratorsService _instance;
        private static readonly object SynObject = new object();

        private AdministratorsService()
        {
        }

        /// <summary>
        ///     单例实例
        /// </summary>
        public static AdministratorsService Instance
        {
            get
            {
                //线程安全
                lock (SynObject)
                {
                    return _instance ?? (_instance = new AdministratorsService());
                }
            }
        }

        /// <summary>
        ///     通过管理员名取得管理员信息
        /// </summary>
        /// <param name="name"></param>
        /// <returns></returns>
        public Model.Admin.Administrators.Administrators GetAdminInfoByName(string name)
        {
            const string sql = "SELECT * FROM HC_Administrators WHERE AdminName=@0";
            return SingleOrDefault<Model.Admin.Administrators.Administrators>(sql, name);
        }

        /// <summary>
        ///     通过管理员Id取得管理员信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Model.Admin.Administrators.Administrators GetAdminInfoById(int id)
        {
            const string sql = "SELECT * FROM HC_Administrators WHERE id=@0";
            return SingleOrDefault<Model.Admin.Administrators.Administrators>(sql, id);
        }

        /// <summary>
        /// 更新登录状态信息
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public bool UpdateLoginStatus(int id)
        {
            string sql = "UPDATE HC_Administrators SET LastLoginDateTime=GETDATE() , LoginCount=LoginCount+1 WHERE ID=@0";
            return Execute(sql, id).ToInt() > 0;
        }


        /// <summary>
        ///     获取分页数据
        /// </summary>
        /// <param name="pageIndex">当前页码，从1开始</param>
        /// <param name="pageSize">每页显示数量</param>
        /// <param name="conditions">搜索条件</param>
        /// <param name="orderby"></param>
        /// <returns></returns>
        public Page<Model.Admin.Administrators.Administrators> Page(int pageIndex, int pageSize,
                                                                    Dictionary<string, string> conditions,
                                                                    string orderby)
        {
            string sql = " WHERE IsDel=0 ";
            if (conditions.Count > 0)
            {
                foreach (var condition in conditions)
                {
                    switch (condition.Key)
                    {
                        default:
                            if (!condition.Value.IsEmpty())
                            {
                                sql += string.Format(" AND {0} like '%{1}%' ", condition.Key, condition.Value);
                            }
                            break;
                    }
                }
            }
            sql += orderby;
            return DbHelper.CurrentDb.Page<Model.Admin.Administrators.Administrators>(pageIndex, pageSize, sql);
        }
    }
}