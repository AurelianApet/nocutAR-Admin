using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using DataAccess;
using System.Text;
using System.Data;
using System.Xml;

namespace nocutAR.Account
{
    public partial class getXML : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            long IID = 0;
            string server_id;
            //if (string.IsNullOrEmpty(Request.Params["server_id"]) && string.IsNullOrEmpty(Request.Params["content_id"]))
            //{
            //    return;
            //}
            //if (string.IsNullOrEmpty(Request.Params["server_id"]))
            //    IID = Int32.Parse(Request.Params["content_id"]);
            string uid = "";
            if (!string.IsNullOrEmpty(Request.Params["uid"]))
                uid = Request.Params["uid"];

            float lat = 0.0f;
            if (!string.IsNullOrEmpty(Request.Params["lat"]))
                lat = (float)(Convert.ToDouble(Request.Params["lat"]));

            float lng = 0.0f;
            if (!string.IsNullOrEmpty(Request.Params["lng"]))
                lng = (float)(Convert.ToDouble(Request.Params["lng"]));

            if(lat != 0.0f && lng != 0.0f)
            {
                string sid = GetFindGMP(lat, lng);
                if (sid != "")
                {
                    StringBuilder responseXml = new StringBuilder();
                    responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                    responseXml.Append("<contents>");
                    responseXml.Append("<apis_over>1</apis_over>");
                    responseXml.Append("<server_id>" + sid + "</server_id>");
                    responseXml.Append("</contents>");
                    Response.Write(responseXml.ToString());
                }
                else
                {
                    if (string.IsNullOrEmpty(Request.Params["content_id"]))
                        return;
                    server_id = Request.Params["content_id"];

                    ProcessResponse(server_id, uid, IID);
                }
            }
            else
            {
                if (string.IsNullOrEmpty(Request.Params["content_id"]))
                    return;
                server_id = Request.Params["content_id"];

                ProcessResponse(server_id, uid, IID);
            }

        }

        private string GetFindGMP(float g_lat, float g_lng)
        {
            DataSet dsContent = null;

            try
            {
                dsContent = DBConn.RunSelectQuery("SELECT contents.xml FROM contents");
                if (!DataSetUtil.IsNullOrEmpty(dsContent))
                {
                    for(int i = 0; i < dsContent.Tables[0].Rows.Count; i ++)
                    {
                        string xml = dsContent.Tables[0].Rows[0][i].ToString();

                        XmlDocument xmlDoc = new XmlDocument();
                        xmlDoc.LoadXml(xml);

                        XmlNodeList GMP_node = xmlDoc.SelectNodes("contents/GMP");
                        float lat = (float)Convert.ToDouble(GMP_node[0].SelectSingleNode("lat").InnerText);
                        float lng = (float)Convert.ToDouble(GMP_node[0].SelectSingleNode("lng").InnerText);

//                        if(Math.Round(lat, 5) == Math.Round(g_lat,5) && Math.Round(lng, 5) == Math.Round(g_lng, 5))
                        {
                            string query = "select contents.server_id from contents where xml like '" + xml + "'";
                            DataSet dsContent1 = DBConn.RunSelectQuery(query);
                            if(!DataSetUtil.IsNullOrEmpty(dsContent1))
                            {
                                return dsContent1.Tables[0].Rows[0][0].ToString();
                            }
                            else
                            {
                                return "";
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                return "";
            }
            return "";
        }

        private void ProcessResponse(string server_id, string uid, long IID)
        {

            DataSet dsContent = null;
            DataSet dsUsedStatus = null;
            DataSet dsUsedProduct = null;
            DataSet dsContent1 = null;

            try
            {
                dsContent1 = DBConn.RunSelectQuery("SELECT id FROM users WHERE loginid='" + uid + "'");
                if (!DataSetUtil.IsNullOrEmpty(dsContent1))
                    uid = dsContent1.Tables[0].Rows[0][0].ToString();

                dsContent = DBConn.RunSelectQuery("SELECT contents.xml, contents.userid FROM contents WHERE server_id={0}",
                    new string[] { "@server_id" },
                    new object[] { server_id });
                if (!DataSetUtil.IsNullOrEmpty(dsContent))
                {
                    IID = DataSetUtil.RowLongValue(dsContent, "userid", 0);
                    StringBuilder responseXml = new StringBuilder();
                    dsUsedStatus = DBConn.RunSelectQuery("SELECT SUM(api_requests) AS api_requests, SUM(size) AS usedhard, COUNT(*) AS markers FROM contents WHERE userid = {0}",
                    new string[] { "@userid" },
                    new object[] { IID });
                    dsUsedProduct = DBConn.RunSelectQuery("SELECT products.* FROM products INNER JOIN users ON users.use_product = products.id WHERE users.id = {0}",
                        new string[] { "@id" },
                        new object[] { IID });
                    if (DataSetUtil.RowIntValue(dsUsedProduct, "api_requests", 0) <= DataSetUtil.RowIntValue(dsUsedStatus, "api_requests", 0))
                    {

                        responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                        responseXml.Append("<contents>");
                        responseXml.Append("<apis_over>1</apis_over>");
                        responseXml.Append("</contents>");

                    }
                    else
                    {
                        responseXml.Append(DataSetUtil.RowStringValue(dsContent, "xml", 0));
                    }
                    Response.Write(responseXml.ToString());
                }
            }
            catch (Exception)
            {
                StringBuilder responseXml = new StringBuilder();
                responseXml.Append("<?xml version=\"1.0\" encoding=\"utf-8\"?>");
                responseXml.Append("<contents >");
                responseXml.Append("</contents>");

                Response.Write(responseXml.ToString());
            }

            if (!string.IsNullOrEmpty(Request.Params["isscan"]) && Request.Params["isscan"] == "1")
            {
                DBConn.RunUpdateQuery("UPDATE contents SET api_requests=api_requests+1 WHERE server_id={0}",
                new string[] { "@server_id" },
                new object[] { server_id });

                string query = "SELECT id FROM contents WHERE server_id='" + server_id + "'";
                string contentid = DBConn.RunSelectQuery(query).Tables[0].Rows[0][0].ToString();

                query = "INSERT INTO contentsusehist (userid, contentid) values('" + uid + "', '" + contentid + "')";
                DBConn.RunInsertQuery(query);

            }
        }

        protected override void Page_Init(object sender, EventArgs e)
        {

        }
    }
}