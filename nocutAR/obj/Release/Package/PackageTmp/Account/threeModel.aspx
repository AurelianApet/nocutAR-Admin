<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajax" %>
<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true"
    CodeBehind="threeModel.aspx.cs" Inherits="nocutAR.Account.threeModel" %>

<asp:Content ID="Content10" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/toolbar.js" type="text/javascript"></script>
    <link href="/Styles/Account.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $("#campain_menu1").html('VI');
            $("#threeModel_menu1").html('<b>3D Model</b>');
            $("#campain_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(235,235,235); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');
            $("#threeModel_menu").attr('style', 'border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-top-color:black; border-right-color:black; border-bottom-color:rgb(93,129,236); border-left-color:black; border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;');          
        });

        var curname;
        function insert()
        {
            showPopup("dvAddThreeModel");
        }

        function del(name)
        {
            $.ajax({
                url: 'delThreeModel.aspx?name=' + name,
                type: "post",
                processData: false,
                contentType: false,
                async: false,
                success: function (data, textStatus, jqXHR) {
                    alert("Successful deleting!");
                    location.reload();
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    HideProgress();
                    alert("Error while deleteing 3D model");
                }
            });
        }

        function change(name)
        {
            showPopup("dvChangeThreeModel");
            curname = name;
        }

        function onAddThreeModel()
        {
            if ($("#fileImg33").val() == "") {
                "Please select 3D model file";
                return false;
            }
            if (!checkImgExtention("fileImg33", "zip")) {
                alert("File Format Error! Please select zip file!");
                return false;
            }
            var file = document.getElementById("fileImg33");
            if (file.files[0] != null) {
                $("#dvAddThreeModel").css("display", "none");
                showPopupUpload();
                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                data.append("upfile", file.files[0]);
                $.ajax({
                    url: 'PostUpload.aspx?type=33',
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        hidePopupUpload();
                        closePopup();
                        alert("Success!");
                        location.reload();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("Error");
                    }
                });
                hidePopupUpload();
                //                }, 500);
            }
        }

        function onChangeThreeModel()
        {
            if ($("#fileImg34").val() == "") {
                "Please select 3D model file.";
                return false;
            }
            if (!checkImgExtention("fileImg34", "zip")) {
                alert("File Format Error! Please select zip file!");
                return false;
            }
            var file = document.getElementById("fileImg34");
            if (file.files[0] != null) {
                $("#dvChangeThreeModel").css("display", "none");
                showPopupUpload();
                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                data.append("upfile", file.files[0]);
                $.ajax({
                    url: 'PostUpload.aspx?type=34&name=' + curname,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        hidePopupUpload();
                        closePopup();
                        alert("Success!");
                        location.reload();
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("Error");
                    }
                });
                hidePopupUpload();
                //                }, 500);
            }
        }

    </script>
</asp:Content>

    <asp:Content ID="Content11" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <table cellpadding="0" cellspacing="0" align="center" width="1240" style="border-collapse: collapse;">
            <tr>
                <td width="1240" height="849" valign="top">
                    <table cellpadding="0" cellspacing="0" width="1240" height="100%">
                        <tbody><tr>
                            <td width="950" valign="top" height="883" style="background-color:#FFFFFF">
                                    <table cellpadding = "0" cellspacing="0" width="891" align="center">
                                        <tbody><tr>
                                            <td width = "891"> &nbsp;</td>
                                        </tr>
                                    </tbody></table>
                                    <p>&nbsp;</p>
                                    <table cellpadding = "0" cellspacing="0" width="770" align="center">
                                        <asp:Literal runat="server" ID="showModels"></asp:Literal>
                                    </table>
                                    <table cellpadding = "0" cellspacing="0" align="center" width="290">
                                        <asp:Literal runat="server" ID="showButton"></asp:Literal>
                                    </table>
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>            
            <tr>
                <td colspan="2" width="1200" height="40" bgcolor="#595959">
                        <p align="right" style="margin-top: 0px;margin-bottom: 0px;"><b><font face="돋움" color="#FFE4F2" style="padding-right: 10px;">
                            <span style="font-size:10pt;"></span></font><span style="font-size:10pt;">
                                <font face="돋움" color="#CCCCCC"> </font></span></b><font face="돋움" color="#CCCCCC"><span style="font-size:10pt;">&nbsp;&nbsp;</span></font></p>
                </td>
            </tr>
        </table>


        <div id="dvAddThreeModel" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="199" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="114">
                                <p align="center"><b><span style="font-size:13pt;"><font face="돋움" color="#666666">Add ThreeModel</font></span></b></p>
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tbody><tr>
                                        <td width="119" height="44">
                                            <a onclick="javascript:OnBrowse('fileImg33')" style="cursor: pointer;">
                                                <img id="btnSelectFile33" class="" src="IMG/bt_file.png" alt="" />
                                            </a>     
                                            <input id="fileImg33" type="file" name="img_path" accept="application/zip"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text33').value=this.value" />
                                        </td>
                                        <td width="366" height="44">
                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="347">
                                                <tbody><tr>
                                                    <td width="345" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                        <input type="text" id="fileimage_text33" placeholder="zip file" readonly="readonly" style="font-size:20px;width:100%" />
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                        <tr>
                            <td width="514" height="49">
                                <table cellpadding="0" cellspacing="0" align="center" width="290">
                                    <tbody><tr>
                                        <td width="290" height="36">
                                            <p align="center"><a style="cursor: pointer;" onclick="onAddThreeModel()" >
                                                <img src="IMG/bt_confirm.png" alt="" /></a></p>
                                        </td>
                                        <td width="190" height="36" style="padding-left:20px">
                                            <p align="center"><a style="cursor: pointer;" onclick="closePopup()" >
                                                <img src="IMG/bt_cancel.png" alt="" /></a></p>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>
        </tbody></table>
    </div>

    <div id="dvChangeThreeModel" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="199" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="114">
                                <p align="center"><b><span style="font-size:13pt;"><font face="돋움" color="#666666">Change ThreeModel</font></span></b></p>
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tbody><tr>
                                        <td width="119" height="44">
                                            <a onclick="javascript:OnBrowse('fileImg34')" style="cursor: pointer;">
                                                <img id="btnSelectFile34" class="" src="IMG/bt_file.png" alt="" />
                                            </a>     
                                            <input id="fileImg34" type="file" name="img_path" accept="application/zip"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text34').value=this.value" />
                                        </td>
                                        <td width="366" height="44">
                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="347">
                                                <tbody><tr>
                                                    <td width="345" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                        <input type="text" id="fileimage_text34" placeholder="zip file" readonly="readonly" style="font-size:20px;width:100%" />
                                                    </td>
                                                </tr>
                                            </tbody></table>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                        <tr>
                            <td width="514" height="49">
                                <table cellpadding="0" cellspacing="0" align="center" width="290">
                                    <tbody><tr>
                                        <td width="290" height="36">
                                            <p align="center"><a style="cursor: pointer;" onclick="onChangeThreeModel()" >
                                                <img src="IMG/bt_confirm.png" alt="" /></a></p>
                                        </td>
                                        <td width="190" height="36" style="padding-left:20px">
                                            <p align="center"><a style="cursor: pointer;" onclick="closePopup()" >
                                                <img src="IMG/bt_cancel.png" alt="" /></a></p>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>
        </tbody></table>
    </div>
    </asp:Content>
