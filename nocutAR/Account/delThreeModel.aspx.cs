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
using System.Windows.Forms;
namespace nocutAR.Account
{
    public partial class delThreeModel : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            string name = Request.Params["name"].ToString();

            string query = "delete three_Model WHERE name='" + name + "'";
            try
            {
                DBConn.RunSelectQuery(query);
            }
            catch(Exception)
            {
            }
        }
    }
}