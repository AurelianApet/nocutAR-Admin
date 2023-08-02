using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using nocutAR.Common;
using DataAccess;
using System.Net;

namespace nocutAR.Account
{
    public partial class detailContent : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            base.Page_Load(sender, e);
            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(Request.Params["id"]))
                {
                    ShowMessageBox("Unpermitted Access.", "CampainList.aspx");
                    return;
                }
                int id = Int32.Parse(Request.Params["id"]);
                
                PageDataSource = DBConn.RunSelectQuery("SELECT * FROM contents WHERE userid={0} AND id={1}",
                    new string[] { "@userid", "@id" },
                    new object[] { AuthUser.ID, id }
                    );
                if (DataSetUtil.IsNullOrEmpty(PageDataSource))
                {
                    ShowMessageBox("Unpermitted Access.", "CampainList.aspx");
                    return;
                }

                outputRes2JS(
                    new string[] {
                        "USER_ID",
                        "CONTENT_ID",
                        "SERVER_ID",
                        "CAMPAIN_NAME"
                    },
                    new string[] {
                        AuthUser.ID.ToString(),
                        id.ToString(),
                        DataSetUtil.RowStringValue(PageDataSource,"server_id",0),
                        DataSetUtil.RowStringValue(PageDataSource,"title",0)
                    }
                );

                string query = "SELECT ulevel FROM users WHERE id='" + AuthUser.ID + "'";
                PageDataSource = DBConn.RunSelectQuery(query);

                int ulevel = Convert.ToInt16(PageDataSource.Tables[0].Rows[0][0].ToString());
                if (ulevel == 10)
                {
                    select_type.Text = "<select id = 'select_type' onchange='OnChangeSelType()' style = 'height:30px;background:transparent;font-size:11pt' >"
                        + "<option value = '1' > Inspire </option>"
                        + "<option value = '2' > Loyality </option>"
                        + "<option value = '3' > Advertisement </option>"
                        + "</select>";
                }
            }
        }

        protected void btnRenameCampain_Click(object sender, EventArgs e)
        {
            string name = RenameCampainText.Text.Trim();
            if (name.Length == 0)
            {
                ShowMessageBox("Input the campagin name.");
                return;
            }

            if (string.IsNullOrEmpty(Request.Params["id"]))
            {
                ShowMessageBox("Unpermitted Access.", "CampainList.aspx");
                return;
            }
            int id = Int32.Parse(Request.Params["id"]);
            try
            {
                string query = "Update contents set title='" + Convert.ToString(name) + "' WHERE id='" + Convert.ToString(id) + "'";
                DBConn.RunSelectQuery(query);
            }
            catch(Exception)
            {

            }

            Response.Redirect("detailContent.aspx?id=" + Convert.ToString(id));
        }

        public void outputRes2JS(string[] strNames, string[] strValues)
        {
            if (strNames.Length != strValues.Length)
                return;

            string strRet = "<script language=\"javascript\" type=\"text/javascript\">\n";
            for (int i = 0; i < strNames.Length; i++)
            {
                strRet += "var " + strNames[i] + " = \"" + strValues[i] + "\";\n";
            }
            strRet += "</script>";

            ltlScript.Text += strRet;
        }
    }
}