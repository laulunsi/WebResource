/*
 * Copyright © 2009-2011 万户网络技术有限公司
 * 文 件 名：ModelFactory.cs
 * 文件描述：构建实体对象的工厂类, 用于实例化并且初始化一个实体
 * 
 * 创建标识: lixin 2012-07-30 09:35 
 * 
 * 修改标识：
 */


using System;
using System.Globalization;
using System.Reflection;

namespace HC.Model
{
    public class ModelFactory<TM> where TM : class, new()
    {
        /// <summary>
        ///     实例化并且初始化
        /// </summary>
        /// <returns></returns>
        public static TM Insten()
        {
            var m = new TM();
            var model = m as BaseModel;
            if (model != null)
            {
                model.State = 0;
                model.IsDel = false;
                model.Sort = Convert.ToInt64(DateTime.Now.ToString("yyMMddHHmmssff", DateTimeFormatInfo.InvariantInfo));
                model.CreateDate = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                model.UpdateDate = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                model.CreateUser = "";
                model.UpdateUser = "";
            }

            return model as TM;
        }

        /// <summary>
        ///     克隆一个实体,并重新初始化固有字段
        /// </summary>
        /// <param name="source"></param>
        /// <returns></returns>
        public static TM Clone(TM source)
        {
            var m = new TM();
            var entity = m as BaseModel;
            if (entity != null)
            {
                Type type = source.GetType();
                PropertyInfo[] properties = type.GetProperties();

                foreach (PropertyInfo p in properties)
                {
                    object value = p.GetValue(source, null);
                    p.SetValue(entity, value, null);
                }

                entity.State = 0;
                entity.IsDel = false;
                entity.Sort = Convert.ToInt64(DateTime.Now.ToString("yyMMddHHmmssff", DateTimeFormatInfo.InvariantInfo));
                entity.CreateDate = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                entity.UpdateDate = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                entity.CreateUser = "";
                entity.UpdateUser = "";
            }
            return entity as TM;
        }


        /// <summary>
        ///     克隆一个表单实体,并重新初始化固有字段
        /// </summary>
        /// <param name="source"></param>
        /// <returns></returns>
        public static TM CloneForm(TM source)
        {
            var m = new TM();
            var entity = m as BaseModel;
            if (entity != null)
            {
                Type type = source.GetType();
                PropertyInfo[] properties = type.GetProperties();

                foreach (PropertyInfo p in properties)
                {
                    object value = p.GetValue(source, null);
                    p.SetValue(entity, value, null);
                }

                entity.State = 0;
                entity.IsDel = false;
                entity.UpdateDate = DateTime.Parse(DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"));
                entity.CreateUser = "";
                entity.UpdateUser = "";
            }
            return entity as TM;
        }
    }
}