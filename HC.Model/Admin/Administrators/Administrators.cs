//--------------------------------------------------------------------------------
// 文件描述：管理员实体类
// 文件作者：张清山 
// 创建日期：2014-05-07 21:07:37
// 修改记录： 
//--------------------------------------------------------------------------------

using System;
using HC.Dal;

namespace HC.Model.Admin.Administrators
{
    /// <summary>
    ///     管理员实体类
    /// </summary>
    [TableName("HC_Administrators")]
    [PrimaryKey("Id")] 
    [Serializable]
    public class Administrators : BaseModel
    {
        /// <summary>
        ///     Id
        /// </summary>
        public int Id { get; set; }

        /// <summary>
        ///     管理员姓名
        /// </summary>
        public string AdminName { get; set; }

        /// <summary>
        ///     密码
        /// </summary>
        public string Password { get; set; }

        /// <summary>
        ///     邮箱
        /// </summary>
        public string Email { get; set; }

        /// <summary>
        ///     最后登录时间
        /// </summary>
        public DateTime LastLoginDateTime { get; set; }

        /// <summary>
        ///     登录次数
        /// </summary>
        public int LoginCount { get; set; }
    }
}