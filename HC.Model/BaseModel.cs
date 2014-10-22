using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace HC.Model
{
    /// <summary>
    /// 所有实体基类
    /// </summary>
    public class BaseModel
    {
        /// <summary>
        /// 状态
        /// </summary>
        public int State { get; set; }

        /// <summary>
        /// 是否删除
        /// </summary>
        public bool IsDel { get; set; }

        /// <summary>
        /// 排序号
        /// </summary>
        public long Sort { get; set; }

        /// <summary>
        /// 创建时间
        /// </summary>
        public DateTime? CreateDate { get; set; }

        /// <summary>
        /// 创建人ID
        /// </summary>
        public string CreateUser { get; set; }

        /// <summary>
        /// 最后更新时间
        /// </summary>
        public DateTime? UpdateDate { get; set; }

        /// <summary>
        /// 最后更新人ID
        /// </summary>
        public string UpdateUser { get; set; }
    }
}
