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
    public partial class threeModel : Common.PageBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string query = "SELECT ulevel FROM users WHERE id='" + AuthUser.ID + "'";
                PageDataSource = DBConn.RunSelectQuery(query);

                int ulevel = Convert.ToInt16(PageDataSource.Tables[0].Rows[0][0].ToString());
                if (ulevel == 10)
                {
                    PageDataSource = DBConn.RunSelectQuery("SELECT * FROM three_Model");
                    int count1 = PageDataSource.Tables[0].Rows.Count;
                    if (count1 > 0)
                    {
                        string title = "<tr><td width = '300' height = '42' bgcolor = '#666666' style = 'border-width:1; border-color:white; border-style:solid;' >"
                            + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#CCCCCC' >"
                             + "<center>3D Model Name </center></font></b></span></p></td>"
                             //                     + "<td width = '251' height = '42' bgcolor = '#666666' style = 'border-width:1; border-color:white; border-style:solid;' >"
                             //                    + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#CCCCCC' >"
                             //                     + "<center>Path</center></font></b></span></p></td>"
                             + "<td width = '300' height = '42' bgcolor = '#666666' style = 'border-width:1; border-color:white; border-style:solid;' >"
                            + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#CCCCCC' >"
                             + "<center>RegDate</center></font></b></span></p>"
                             + "</td><td width = '300' height = '42' bgcolor = '#666666' style = 'border-width:1; border-color:white; border-style:solid;' >"
                            + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#CCCCCC' >"
                             + "<center>Control</center></font></b></span></p></td></tr>";
                        showModels.Text = title;
                        for (int i = 0; i < count1; i++)
                        {
                            string name = PageDataSource.Tables[0].Rows[i][1].ToString();
                            string path = PageDataSource.Tables[0].Rows[i][2].ToString();
                            string regdate = PageDataSource.Tables[0].Rows[i][3].ToString();

                            string str = "<tr><td width = '300' height = '42' bgcolor = '#EEEEEE' style = 'border-width:1; border-color:white; border-style:solid;' > "
                                + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#666666' ><center><a href='"
                                + "" + path
                                + "'>"
                                + name
                                + "</a></center></font></b></span></p></td>"
                                //                        + "<td width = '251' height = '42' bgcolor = '#EEEEEE' style = 'border-width:1; border-color:white; border-style:solid;' > "
                                //                        + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#666666' ><center>"
                                //                        + path
                                //                        + "</center></font></b></span></p></td>"
                                + "<td width = '300' height = '42' bgcolor = '#EEEEEE' style = 'border-width:1; border-color:white; border-style:solid;' > "
                                + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#666666' ><center>"
                                + regdate
                                + "</center></font></b></span></p></td>"
                                + "<td width = '300' height = '42' bgcolor = '#EEEEEE' style = 'border-width:1; border-color:white; border-style:solid;' > "
                                + "<center><a onclick='change(\""
                                + name
                                + "\")' style='cursor:pointer'><font face='돋움' color='blue'>Modify</font></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
                                + "<a onclick='del(\""
                                + name
                                + "\")' style='cursor:pointer'><font face='돋움' color='red'>Delete</font></a></center>"
                                + "</td>"
                                + "</tr>";
                            showModels.Text += str;
                        }
                    }
                    showButton.Text = "<tr><td width = '145' height='115'>"
                        + "<p align = 'center' ><a onclick = 'insert()' style = 'cursor:pointer' >"
                        + "<img src = 'IMG/bt_insert.png' border = '0' width = '122' height = '37' alt = '' /></a></p></td></tr>";
                }
                else
                {
                    PageDataSource = DBConn.RunSelectQuery("SELECT * FROM three_Model");
                    int count1 = PageDataSource.Tables[0].Rows.Count;
                    if (count1 > 0)
                    {
                        string title = "<tr><td width = '450' height = '42' bgcolor = '#666666' style = 'border-width:1; border-color:white; border-style:solid;' >"
                            + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#CCCCCC' >"
                             + "<center>3D Model Name </center></font></b></span></p></td>"
                             //                     + "<td width = '251' height = '42' bgcolor = '#666666' style = 'border-width:1; border-color:white; border-style:solid;' >"
                             //                    + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#CCCCCC' >"
                             //                     + "<center>Path</center></font></b></span></p></td>"
                             + "<td width = '450' height = '42' bgcolor = '#666666' style = 'border-width:1; border-color:white; border-style:solid;' >"
                            + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#CCCCCC' >"
                             + "<center>RegDate</center></font></b></span></p>"
                             + "</td></tr>";
                        showModels.Text = title;
                        for (int i = 0; i < count1; i++)
                        {
                            string name = PageDataSource.Tables[0].Rows[i][1].ToString();
                            string path = PageDataSource.Tables[0].Rows[i][2].ToString();
                            string regdate = PageDataSource.Tables[0].Rows[i][3].ToString();

                            string str = "<tr><td width = '450' height = '42' bgcolor = '#EEEEEE' style = 'border-width:1; border-color:white; border-style:solid;' > "
                                + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#666666' ><center><a href='"
                                + "" + path
                                + "'>"
                                + name
                                + "</a></center></font></b></span></p></td>"
                                //                        + "<td width = '251' height = '42' bgcolor = '#EEEEEE' style = 'border-width:1; border-color:white; border-style:solid;' > "
                                //                        + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#666666' ><center>"
                                //                        + path
                                //                        + "</center></font></b></span></p></td>"
                                + "<td width = '450' height = '42' bgcolor = '#EEEEEE' style = 'border-width:1; border-color:white; border-style:solid;' > "
                                + "<p align = 'left' ><span style = 'font-size:11pt;' ><b><font face = '돋움' color = '#666666' ><center>"
                                + regdate
                                + "</center></font></b></span></p></td>"
                                + "</tr>";
                            showModels.Text += str;
                        }
                    }
                }
            }
            catch(Exception)
            {

            }
        }
    }
}