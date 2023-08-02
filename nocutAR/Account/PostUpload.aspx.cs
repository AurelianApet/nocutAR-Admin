using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Drawing.Drawing2D;

namespace nocutAR.Account
{
    public partial class PostUpload : Common.PageBase
    {
        private int WIDTH = 1280;
        public void Resize(string imageFile)
        {
            string strPath = Server.MapPath(imageFile);

            var srcImage = System.Drawing.Image.FromFile(strPath);

            int newWidth = srcImage.Width;
            int newHeight = srcImage.Height;
            if (srcImage.Width > srcImage.Height)
            {
                if (srcImage.Width > WIDTH)
                {
                    newWidth = WIDTH;
                    newHeight = srcImage.Height * WIDTH / srcImage.Width;
                }
            }
            else
            {
                if (srcImage.Height > WIDTH)
                {
                    newHeight = WIDTH;
                    newWidth = srcImage.Width * WIDTH / srcImage.Height;
                }
            }

            var newImage = new Bitmap(newWidth, newHeight);

            var graphics = Graphics.FromImage(newImage);

            graphics.SmoothingMode = SmoothingMode.AntiAlias;
            graphics.InterpolationMode = InterpolationMode.HighQualityBicubic;
            graphics.PixelOffsetMode = PixelOffsetMode.HighQuality;
            graphics.DrawImage(srcImage, new Rectangle(0, 0, newWidth, newHeight));
            try
            {
                srcImage.Dispose();
                newImage.Save(strPath);
            }
            catch (Exception ex)
            {

            }
        }

        protected override void Page_Init(object sender, EventArgs e)
        {
            base.Page_Init(sender, e);
        }
        protected override void Page_Load(object sender, EventArgs e)
        {
            /*  type=0: 마커Upload
                type=1:비디오Upload
                type=2:이미지Upload
                type=3:웹사이트Upload
                type=4:캡쳐오브젝트 Upload
                type=5:전화번호Upload
                type=6:3D 오브젝트Upload */

            base.Page_Load(sender, e);
            int type = -1;
            if (Request.Params["type"] != null)
                type = Int32.Parse(Request.Params["type"]);


            long content_id = -1;
            if (Request.Params["content_id"] != null)
                content_id = Int32.Parse(Request.Params["content_id"]);

            if (type == -1)
                return;
            HttpFileCollection uploadFiles = Request.Files;

            string strIconPath = null;
            if (type == 0)
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/markers", "test_" + content_id.ToString() + System.IO.Path.GetExtension(Request.Files["upfile"].FileName).Replace(".png",".jpg"));
                Resize(strIconPath);

            }
            else if (type == 5)
            {
                strIconPath = uploadFile(Request.Files["upfile1"], "/uploads");
                strIconPath += ":" + uploadFile(Request.Files["upfile2"], "/uploads");
            }
            else if (type == 20)
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/uploads/advers");
            }
            else if (type == 30)
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/uploads/videoButtonImage");
            }
            else if(type == 33)
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/threeModels");
            }
            else if(type == 34)
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/threeModels");
            }
            else
            {
                strIconPath = uploadFile(Request.Files["upfile"], "/uploads", content_id.ToString() + "_" + type.ToString() + "_" + Guid.NewGuid().ToString().Replace("-", "") + System.IO.Path.GetExtension(Request.Files["upfile"].FileName));
            }

            //용량기록
            if (type == 5)
            {
                DBConn.RunInsertQuery("INSERT INTO traffics (objtype, filename, size, userid, content_id) VALUES(@objtype, @filename, @size, @userid, @content_id ) ",
                new string[] {
                    "@objtype",
                    "@filename",
                    "@size",
                    "@userid",
                    "@content_id"
                },
                new object[] {
                    type,
                    Request.Files["upfile1"].FileName,
                    (float)(Request.Files["upfile2"].ContentLength)/1024/1024,
                    AuthUser.ID,
                    content_id
                });
                DBConn.RunInsertQuery("INSERT INTO traffics (objtype, filename, size, userid, content_id) VALUES(@objtype, @filename, @size, @userid, @content_id ) ",
                new string[] {
                    "@objtype",
                    "@filename",
                    "@size",
                    "@userid",
                    "@content_id"
                },
                new object[] {
                    type,
                    Request.Files["upfile2"].FileName,
                    (float)(Request.Files["upfile2"].ContentLength)/1024/1024,
                    AuthUser.ID,
                    content_id
                });
            }
            else if(type == 33)
            {
                string name = Request.Files["upfile"].FileName.Substring(0, Request.Files["upfile"].FileName.Length - 4);
                string path = strIconPath;
                DBConn.RunInsertQuery("insert into three_Model (name, path) values(@name, @path)", new string[] {"@name", "@path" }, new object[] { name, path});
            }
            else if(type == 34)
            {
                string name = "";
                if (Request.Params["name"] != null)
                    name = Request.Params["name"].ToString();
                else
                    return;

                string filename = Request.Files["upfile"].FileName.Substring(0, Request.Files["upfile"].FileName.Length - 4);
                string path = strIconPath;
                DBConn.RunUpdateQuery("update three_Model set name = '" + filename + "', path = '" + path + "' where name = '" + name + "'");
            }
            else
            {
                DBConn.RunInsertQuery("INSERT INTO traffics (objtype, filename, size, userid, content_id) VALUES(@objtype, @filename, @size, @userid, @content_id ) ",
                new string[] {
                    "@objtype",
                    "@filename",
                    "@size",
                    "@userid",
                    "@content_id"
                },
                new object[] {
                    type,
                    strIconPath,
                    (float)(Request.Files["upfile"].ContentLength)/1024/1024,
                    AuthUser.ID,
                    content_id
                });
            }
            Response.Write(strIconPath);
        }
    }
}
