<%@ Page Title="" Language="C#" MasterPageFile="~/Account/UserPage.Master" AutoEventWireup="true"
    CodeBehind="detailContent.aspx.cs" Inherits="nocutAR.Account.detailContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="/Scripts/detailcontents_opt.js" type="text/javascript"></script>
    <script src="/Scripts/init_obj.js" type="text/javascript"></script>
    <script src="/Scripts/edit_obj.js" type="text/javascript"></script>
    <script src="/Scripts/toolbar.js" type="text/javascript"></script>
    <link href="style.css" rel="stylesheet" type="text/css" />

    <asp:Literal ID="ltlScript" runat="server" Text=""></asp:Literal>
    <link href="/Styles/Account.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        var objName = "";
        var imgList = new Array();
        var slideList = new Array();
        var webList = new Array();
        var videoList = new Array();
        var captureList = new Array();
        var threeList = new Array();
        var telList = new Array();
        var googlemapList = new Array();
        var notepadList = new Array();
        var audioList = new Array();
        var chromakeyList = new Array();
        counter = 0;
        video_counter = 0;
        web_counter = 0;
        img_counter = 0;
        slide_counter = 0;
        capture_counter = 0;
        three_counter = 0;
        tel_counter = 0;
        googlemap_counter = 0;
        notepad_counter = 0;
        audio_counter = 0;
        chromakey_counter = 0;
        capprev_counter = 0;
        var addIndex = 0;
        var prevIndex = 0;
        var capCount = 0;
        var capprevIndex = 0;

        function addLoyaltyPlan()
        {
            document.getElementById("addLoyaltyPlan").innerHTML += "Plan <input type='text' name='loyalPlanTxt' style='width:300px;height:25px;' /><br />";
        }

        function leaveLoyaltyPlan()
        {
            closePopup();
        }

        function OnChangeSelType() {
            if (document.getElementById("select_type").value == '1')
            {
                document.getElementById("show_Type_content").innerHTML = "<table cellpadding='0' cellspacing='0' align='center' width='485' style='padding-left:80px'><tbody><tr>"
                + "<td width='366' height='250'>"
                + "<textarea rows='10' cols='10' id='inspireTxt' style='width:300px;height:250px;'></textarea>"
                + "</td></tr></tbody></table>";
            }
            else if (document.getElementById("select_type").value == '2')
            {
                document.getElementById("show_Type_content").innerHTML = "<table cellpadding='0' cellspacing='0' align='center' width='485' style='padding-left:80px'><tbody><tr>"
                + "<td width='366' height='250'>"
                + "<center>Loyalty Plan :</center>"
                + "<br /><div id='addLoyaltyPlan' > </div><br />"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<a onclick='addLoyaltyPlan()' style='cursor:pointer'><img src='IMG/bt_add_plan.png' alt=''> </a>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<a onclick='leaveLoyaltyPlan()' style='cursor:pointer'><img src='IMG/bt_leave_plan.png' alt=''> </a>"
                + "</td></tr></tbody></table>";
            }
            else if(document.getElementById("select_type").value == '3')
            {
                document.getElementById("show_Type_content").innerHTML = "<table cellpadding='0' cellspacing='0' align='center' width='485' style='padding-left:80px'><tbody><tr>"
                + "<td width='366' height='250'>"
                + "<textarea rows='10' cols='10' id='advertisementTxt' style='width:300px;height:250px;'></textarea>"
                + "</td></tr></tbody></table>";
            }
        }

        $(document).ready(function () {
            //selTopMenu(4);
            $("#txtTitle").val(CAMPAIN_NAME);
            $.ajax({
                url: "getUseProduct.aspx",
                dataType: 'json',
                async: false,
                type: 'POST',
                success: function (data) {
                    HideProgress();
                    var iVideo_obj = data.video_obj;
                    var iWeb_obj = data.web_obj;
                    var iImage_obj = data.image_obj;
                    var iSlide_obj = data.slide_obj;
                    var iCapture_obj = data.capture_obj;
                    var iThree_model_obj = data.three_model_obj;
                    var iTel_obj = data.tel_obj;
                    var iGooglemap_obj = data.googlemap_obj;
                    var iNotepad_obj = data.notepad_obj;
                    var iBgm_obj = data.bgm_obj;
                    var iChromakey = data.chromakey_obj;
                    var iThreeTemplate = data.three_template;
                    onShowTrMenu("trLeftmenu1", iVideo_obj);
                    onShowTrMenu("trLeftmenu2", iImage_obj);
                    onShowTrMenu("trLeftmenu3", iWeb_obj);
                    onShowTrMenu("trLeftmenu4", iTel_obj);
                    onShowTrMenu("trLeftmenu5", iGooglemap_obj);
                    onShowTrMenu("trLeftmenu6", iNotepad_obj);
                    onShowTrMenu("trLeftmenu7", iBgm_obj);
                    onShowTrMenu("trLeftmenu8", iSlide_obj);
                    onShowTrMenu("trLeftmenu9", iCapture_obj);
                    onShowTrMenu("trLeftmenu10", iChromakey);
                    onShowTrMenu("trLeftmenu11", iThree_model_obj);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    HideProgress();
                    alert("No userful product");
                    document.location = "CampainList.aspx";
                }
            });

            $('#fileImg').bind('change', function () {

                $('#fileimage_text').val(this.value.replace('C:\\fakepath\\', ''));
                $('#fileimage_text1').val(this.value.replace('C:\\fakepath\\', ''));
                $('#fileimage_text11').val(this.value.replace('C:\\fakepath\\', ''));

                var files = document.getElementById('fileImg').files;

                var file, img;
                if ((file = this.files[0])) {
                    img = new Image();
                    img.src = URL.createObjectURL(file);

                    img.onload = function () {
                        marker_width = this.width;
                        marker_height = this.height;
                    };
                }

                //File Reader Support
                if (FileReader && files && files.length) {
                    var fr = new FileReader();
                    fr.onload = function () {
                        $('#img_marker').attr("src", fr.result);
                    }
                    fr.readAsDataURL(files[0]);
                }
            });


            $.ajax({
                url: "getContentData.aspx?id=" + CONTENT_ID,
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    title = data.title;
                    $("#txtTitle").html(title);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("An error occurs while reading VI name");
                }

            });
            init_mark();
            selLeftMenu(0);
            capprevdrop();

            if (document.getElementById("select_type").value == '1') {
                document.getElementById("show_Type_content").innerHTML = "<table cellpadding='0' cellspacing='0' align='center' width='485' style='padding-left:80px'><tbody><tr>"
                + "<td width='366' height='250'>"
                + "<textarea rows='10' cols='10' id='inspireTxt' style='width:300px;height:250px;'></textarea>"
                + "</td></tr></tbody></table>";
            }
            else if (document.getElementById("select_type").value == '2') {
                document.getElementById("show_Type_content").innerHTML = "<table cellpadding='0' cellspacing='0' align='center' width='485' style='padding-left:80px'><tbody><tr>"
                + "<td width='366' height='250'>"
                + "<center>Loyalty Plan :</center>"
                + "<br /><div id='addLoyaltyPlan' > </div><br />"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<a onclick='addLoyaltyPlan()' style='cursor:pointer'><img src='IMG/bt_add_plan.png' alt=''> </a>"
                + "&nbsp;&nbsp;&nbsp;&nbsp;<a onclick='leaveLoyaltyPlan()' style='cursor:pointer'><img src='IMG/bt_leave_plan.png' alt=''> </a>"
                + "</td></tr></tbody></table>";
            }
            else if (document.getElementById("select_type").value == '3') {
                document.getElementById("show_Type_content").innerHTML = "<table cellpadding='0' cellspacing='0' align='center' width='485' style='padding-left:80px'><tbody><tr>"
                + "<td width='366' height='250'>"
                + "<textarea rows='10' cols='10' id='advertismentTxt' style='width:300px;height:250px;'></textarea>"
                + "</td></tr></tbody></table>";
            }
        });

        function onToggleGrid() {
            if ($("#dvGrid").css("display") == "none")
                $("#dvGrid").css("display", "");
            else
                $("#dvGrid").css("display", "none");
        }
        
        function OnBack() {
            document.location = "CampainList.aspx";
        }

        function OnAddCustomUploadVideo() {
            document.getElementById("addCustomUploadVideo").style="";
        }

        function OnHideCustomUploadVideo()
        {
            document.getElementById("addCustomUploadVideo").style = "display:none;";
        }
        function onVideo()
        {
            document.getElementById("viewObject").innerHTML=
                "<table cellpadding='0' cellspacing='0' width='200' align='center'>"
                + "<tbody>"
                + " <tr>"
                + "     <td width='200' height='153' bgcolor='#EBEBEB'>"
                + "         <p align='center'><b><font face='돋움' color='#999999'>"
                + "             <span style='font-size:12pt;'>VIDEO</span></font></b></p>"
                + "     </td></tr><tr>"
                + "     <td width='200' height='37' bgcolor='#A5A5A5'>"
                + "         <table cellpadding='0' cellspacing='0' align='center' width='175'>"
                + "             <tbody><tr>"
                + "                 <td width='59' height='28'>"
                + "                     <a onclick='DeleteVideo()' onmouseout='cursor:normal;' onmouseover='cursor:hand;' style='cursor:pointer;'>"
                + "                         <img src='IMG/bt_trash.png' width='18' height='21' border='0' alt='' />"
                + "                     </a>"
                + "                 </td>"
                + "                 <td width='59' height='28'>&nbsp;</td>"
                + "                 <td width='57' height='28'>"
                + "                     <a onclick='EditVideo()' onmouseout='cursor: normal;' onmouseover='cursor: hand;' style='cursor: pointer;'>"
                + "                        <p align='right'>"
                + "                         <img src='IMG/bt_pen.png' width='19' height='19' border='0' alt='' />"
                + "                         </p>"
                + "                     </a>"
                + "                 </td>"                    
                + "             </tr>"
                + "            </tbody></table>"
                + "      </td>"
                + "    </tr>"
                + "</tbody></table>";
        }

        function on3DObject()
        {
            document.getElementById("viewObject").innerHTML =
                "<table cellpadding='0' cellspacing='0' width='200' align='center'>"
                + "<tbody>"
                + " <tr>"
                + "     <td width='200' height='153' bgcolor='#EBEBEB'>"
                + "         <p align='center'><b><font face='돋움' color='#999999'>"
                + "             <span style='font-size:12pt;'>3DObject</span></font></b></p>"
                + "     </td></tr><tr>"
                + "     <td width='200' height='37' bgcolor='#A5A5A5'>"
                + "         <table cellpadding='0' cellspacing='0' align='center' width='175'>"
                + "             <tbody><tr>"
                + "                 <td width='59' height='28'>"
                + "                     <a onclick='Delete3DObject()' style='cursor:pointer;'>"
                + "                         <img src='IMG/bt_trash.png' width='18' height='21' border='0' alt='' />"
                + "                     </a>"
                + "                 </td>"
                + "                 <td width='59' height='28'>&nbsp;</td>"
                + "                 <td width='57' height='28'>"
                + "                     <a onclick='Edit3DObject()' style='cursor: pointer;'>"
                + "                        <p align='right'>"
                + "                         <img src='IMG/bt_pen.png' width='19' height='19' border='0' alt='' />"
                + "                         </p>"
                + "                     </a>"
                + "                 </td>"
                + "             </tr>"
                + "            </tbody></table>"
                + "      </td>"
                + "    </tr>"
                + "</tbody></table>";
        }

        function setMarkerImg(marker_url) {
            $.ajax({
                url: "setMarkerData.aspx?marker_url=" + encodeURI(marker_url) + "&id=" + CONTENT_ID,
                type: 'POST',
                success: function (data) {
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("error");
                }
            });
        }
        function onShowTrMenu(ctrl, value) {
            $("#" + ctrl).css("display", value == 1 ? "" : "none");
        }

        function onRegMarker() {
            showPopup("dvRegMarker");
        }

        function selLeftMenu(id) {
            if (id == 0) {
                $("#trMenu1r").css("display", "");
                $("#trMenu1").css("display", "none");
                $("#trMenu2r").css("display", "none");
                $("#trMenu2").css("display", "");
                $("#tblMenu2").css("display", "none");
            }
            else {
                if ($("#markImg").attr("src") == "") {
                    alert("You must register marker.");
//                    $("#showmenu").attr("style") = "display:none";
                    return;
                }
                $("#trMenu1r").css("display", "none");
                $("#trMenu1").css("display", "");
                $("#trMenu2r").css("display", "");
                $("#trMenu2").css("display", "none");
                $("#tblMenu2").css("display", "");
            }
        }

        function na_restore_img_src(name, nsdoc)
        {
          var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc+'.'+name : 'document.all.'+name);
          if (name == '')
            return;
          if (img && img.altsrc) {
            img.src    = img.altsrc;
            img.altsrc = null;
          } 
        }

        function na_preload_img()
        { 
          var img_list = na_preload_img.arguments;
          if (document.preloadlist == null) 
            document.preloadlist = new Array();
          var top = document.preloadlist.length;
          for (var i=0; i < img_list.length-1; i++) {
            document.preloadlist[top+i] = new Image;
            document.preloadlist[top+i].src = img_list[i+1];
          } 
        }

        function na_change_img_src(name, nsdoc, rpath, preload)
        { 
          var img = eval((navigator.appName.indexOf('Netscape', 0) != -1) ? nsdoc+'.'+name : 'document.all.'+name);
          if (name == '')
            return;
          if (img) {
            img.altsrc = img.src;
            img.src    = rpath;
          } 
        }

        function uploadFile(target) {
            document.getElementById("file-name").innerHTML = target.files[0].name;
        }


        function RenameCampain() {
            showPopup("dvRenameCampaign");
        }

        function onChangeMarker() {
            showPopup("dvChangeMarker");
        }

        function onChangeMarkerImg() {
            //File 유무체크
            if ($("#fileImg11").val() == "") {
                "Please select marker image.";
                return false;
            }
            //확장자체크
            if (!checkImgExtention("fileImg11", "img")) {
                return false;
            }
            //용량체크
            /***확장자체크***/
            var file = document.getElementById("fileImg11");
            if (file.files[0] != null) {
                /*용량제한*/
                if ((file.files[0].size / 1053317.6) > 5) {
                    alert("Cannot register image larger than 5MB size");
                    return false;
                }

                $("#dvChangeMarker").css("display", "none");
                showPopupUpload();

                //create new FormData instance to transfer as Form Type
                var data = new FormData();
                // add the file intended to be upload to the created FormData instance
                data.append("upfile", file.files[0]);
                //                setTimeout(function () {
                $.ajax({
                    url: 'PostUpload.aspx?type=0&content_id=' + CONTENT_ID,
                    type: "post",
                    data: data,
                    // cache: false,
                    processData: false,
                    contentType: false,
                    async: false,
                    success: function (data, textStatus, jqXHR) {
                        $("#markImg").attr("src", data);
                        $("#editframe").css("display", "");
                        $("#req_cover").css("display", "none");
                        $("#markImg").one("load", function () {
                            $(".markdiv").css({ "width": document.getElementById("markImg").width });
                            hidePopupUpload();
                            closePopup();
                            selLeftMenu(1);
                            //                                location.reload();
                        }).each(function () {
                            if (this.complete) $(this).load();
                        });
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        HideProgress();
                        alert("Error while registering marker.");
                    }
                });
                hidePopupUpload();
                //                }, 500);
            }
        }

        function onRegMarkerImg() {
            //File 유무체크
            if ($("#fileImg").val() == "") {
                "Please select marker image";
                return false;
            }
            //확장자체크
            if (!checkImgExtention("fileImg", "img")) {
                return false;
            }
            //용량체크
            /***확장자체크***/
            var file = document.getElementById("fileImg");
            if (file.files[0] != null) {
                /*용량제한*/
                if ((file.files[0].size / 1053317.6) > 5) {
                    alert("Cannot register image larger than 5MB size");
                    return false;
                }
                
                $("#dvRegMarker").css("display", "none");
                showPopupUpload();

                var data = new FormData();
                data.append("upfile", file.files[0]);
                    $.ajax({
                        url: 'PostUpload.aspx?type=0&content_id=' + CONTENT_ID,
                        type: "post",
                        data: data,
                        // cache: false,
                        processData: false,
                        contentType: false,
                        async: false,
                        success: function (data, textStatus, jqXHR) {
                            $("#markImg").attr("src", data);
                            $("#editframe").css("display", "");
                            $("#req_cover").css("display", "none");
                            $("#markImg").one("load", function () {
                                $(".markdiv").css({ "width": document.getElementById("markImg").width });
                                hidePopupUpload();
                                closePopup();
                                selLeftMenu(1);
//                                location.reload();
                            }).each(function () {
                                if (this.complete) $(this).load();
                            });
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            HideProgress();
                            alert("Error while registering marker image.");
                        }
                    });
            }
        }

        function onRegGMap()
        {
            showPopup("dvGMap");
            initMap();
        }

        function onSelType() {
            showPopup("dvSelType");
        }

        function onSelTypeOK()
        {
            var select_type = document.getElementById("select_type").value;
            if(select_type == '1')
            {
                var content = document.getElementById("inspireTxt").value;
                document.getElementById("select_type_content").value = content;
            }
            else if(select_type == '2')
            {
                for(var i = 0; i < document .getElementsByName('loyalPlanTxt').length; i ++)
                {
                    var content = document .getElementsByName('loyalPlanTxt')[i].value;
                    document.getElementById("select_type_content").value += content + ',';
                }
            }
            else if (select_type == '3') {
                var content = document.getElementById("advertisementTxt").value;
                document.getElementById("select_type_content").value = content;
            }

            closePopup();
        }

        function onSaveGMap()
        {            
            var input = document.getElementById('latlng').value;
            var latlngStr = input.split(',', 2);
            var latlng = { lat: parseFloat(latlngStr[0]), lng: parseFloat(latlngStr[1]) };
            document.getElementById("viewGP").value = latlng.lat + ", " + latlng.lng;
            closePopup();
        }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <input type="hidden" id="edtObjID" />
        <table cellpadding="0" cellspacing="0" width="1199" align="center" background="img/top_bg02.png">
            <tr>
                <td width="1240" height="71" align="left">
                    <table cellpadding="0" cellspacing="0" width="1240">
                        <tr>
                            <td width="1240" height="71" align="left">
                                <table cellpadding="0" cellspacing="0" width="1200">
                                    <tr>
                                        <td width="250" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="center"><font face="돋움" color="#555555"><span style="font-size:12pt;"><b>Edit VI</b></span></font></p>
                                        </td>
                                        <td width="250" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="center">&nbsp;</p>
                                        </td>

                                        <td width="363" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="center">   
                                            </p>
                                        </td>

                                        <td width="180" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="right">
                                                <a onclick="OnSave();" style="cursor:pointer">
                                                    <img src="IMG/_0011_save.png" width="122" height="37" border="0" name="image3" alt="" />
                                                </a>
                                            </p>
                                        </td>

                                        <td width="151" height="70" style="border-top-width:1;border-right-width:1;border-bottom-width:2;border-left-width:1;border-top-color:black;border-right-color:black;border-bottom-color:rgb(235,235,235);border-left-color:black;border-top-style:none;border-right-style:none;border-bottom-style:solid;border-left-style:none;">
                                            <p align="center">
                                                <a onclick="OnBack();" style="cursor:pointer">
                                                    <img src="IMG/_0013_out.png" width="122" height="37" border="0" name="image2" alt=""/>
                                                </a>
                                            </p>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" align="center" width="1240" style="border-collapse: collapse;">
            <tr>
                <td width="240" valign="top" bgcolor="#F9FAFE"  style="border-width:1; border-right-color:rgb(235,235,235); border-top-style:none; border-right-style:solid; border-bottom-style:none; border-left-style:none;">
                    <table cellpadding="0" cellspacing="0" align="center" width="226">
                        <tbody>
                            <tr>
                                <td width="226" height="50">
                                    <p align="center"><b><font face="돋움" color="#555555"><span style="font-size:11pt;">Object</span></font></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="226" height="200">
                                    <table cellpadding="0" cellspacing="0" width="200" align="center" id="showmenu">
                                        <tbody>
                                            <tr>
                                                <td id="leftmenu1">
                                                    <div class="clsImagechange" id="imgEditMenu1" onclick="onSelItem(1)">
                                                        <p align="center"><a style="cursor: pointer;">
                                                            <img src="IMG/bt_video.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu2">
                                                    <div class="clsImagechange" id="imgEditMenu2" onclick="onSelItem(2)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_image.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu11">
                                                    <div class="clsImagechange" id="imgEditMenu11" onclick="onSelItem(11)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_3dobj.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu3">
                                                    <div class="clsImagechange" id="imgEditMenu3" onclick="onSelItem(3)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_website.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu5">
                                                    <div class="clsImagechange" id="imgEditMenu5" onclick="onSelItem(5)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_googlemap.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu6">
                                                    <div class="clsImagechange" id="imgEditMenu6" onclick="onSelItem(6)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_text.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td id="leftmenu7">
                                                    <div class="clsImagechange" id="imgEditMenu7" onclick="onSelItem(7)">
                                                        <p align="center">
                                                            <a style="cursor: pointer;">
                                                            <img src="IMG/bt_audio.png" width="161" height="43" border="0" alt="" /></a></p>
                                                    </div>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </td>

                <td width="960" valign="top">
                    <table cellpadding="0" cellspacing="0" width="948">
                        <tbody><tr>
                            <td width="948" height="90" style="border-top-width:1; border-right-width:1; border-bottom-width:2; border-left-width:1; border-bottom-color:rgb(235,235,235); border-top-style:none; border-right-style:none; border-bottom-style:solid; border-left-style:none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="916">
                                    <tbody><tr>
                                        <td width="158" height="37" style="padding-left:50px; font-weight: bold; font-family: 돋음; color: #666666;">
                                            <input type="text" id="txtTitle" style="border-style: none; background: transparent; font-size: 15pt" />
                                        </td>

                                        <td width="178" height="42">
                                            <p align="right"><a onclick="onSelType();" style="cursor: pointer;">
                                                <img src="IMG/bt_select_type.png" width="122" height="37" border="0" alt="" /></a></p>
                                            <input type="hidden" id="select_type_content" />
                                        </td>
                                        <td width="158" height="37" style="padding-left:50px; font-weight: bold; font-family: 돋음; color: #666666;
                                            font-size: 12pt;">
                                            <input type="text" id="viewGP" style="border-style: none; background: transparent; font-size: 12pt" />                                                        
                                        </td>

                                        <td width="178" height="42">
                                            <p align="right"><a onclick="onRegGMap();" style="cursor: pointer;">
                                                <img src="IMG/bt_gmap.png" width="122" height="37" border="0" alt="" /></a></p>
                                        </td>
                                        <td width="178" height="42">
                                            <p align="right"><a onclick="onRegMarker();" style="cursor: pointer;">
                                                <img src="IMG/bt_marker.png" width="122" height="37" border="0" alt="" /></a></p>
                                        </td>
                                    </tr>
                                </tbody></table>
                            </td>
                        </tr>
                        <tr>
                            <td id="tdWorkArea" width="1088" height="617" align="center" valign="middle" style="background-repeat: repeat;
                                border-width: 1px; border-top-color: rgb(229,233,235); border-right-color: black;
                                border-bottom-color: black; border-left-color: black; border-top-style: solid;
                                border-right-style: none; border-bottom-style: none; border-left-style: none;position:relative">
                                <div id="dvGrid" style="width:1088px;height:617px;background:url(img/gridback.png); position:absolute;top:0px;z-index:2;display:none" >
                                </div>
                                <div id="editframe" class="markdiv" style="margin-left: auto; margin-right: auto;
                                    z-index: 1px; display: none; position: relative;">
                                    <img id="markImg" src="" class="clsMarkerImg" alt="markerImg" />
                                </div>
                                <div id="req_cover" class="req_cover" style="display: none;">
                                    <table id="tblRegMarker" cellpadding="0" cellspacing="0" width="760" align="center">
                                        <tr>
                                            <td width="760" height="113">
                                                <table cellpadding="0" cellspacing="0" width="411" align="center">
                                                    <tr>
                                                        <td width="411" height="41" align="center">
                                                            <b><font face="돋움" color="#666666"><span style="font-size: 12pt;">Please register marker.<br><br></span></font></b>
                                                            <div id="req_cover_warning" class="req_cover" style="display: none;">
                                                                <b><font face="돋움" color="#FFOOOO"><span style="font-size: 10pt;"></span></font></b>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="411" height="50" align="center">
                                                            <a onclick="onRegMarker()" style="cursor:pointer">
                                                                <img src="IMG/bt_marker.png" alt="" />
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </tbody></table>
                </td>
            </tr>
            <tr></tr>
            <tr>
                <td colspan="2" width="1200" height="40" bgcolor="#595959">
                        <p align="right" style="margin-top: 0px;margin-bottom: 0px;"><b><font face="돋움" color="#FFE4F2"  style="padding-right: 10px;">
                            <span style="font-size:10pt;"></span></font><span style="font-size:10pt;">
                                <font face="돋움" color="#CCCCCC"> </font></span></b><font face="돋움" color="#CCCCCC"><span style="font-size:10pt;">&nbsp;&nbsp;</span></font></p>
                </td>
            </tr>

        </table>


        <div id="dvChangeMarker" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="199" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="114">
                                <p align="center"><b><span style="font-size:13pt;"><font face="돋움" color="#666666">Change Marker</font></span></b></p>
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tbody><tr>
                                        <td width="119" height="44">
                                            <a onclick="javascript:OnBrowse('fileImg11')" style="cursor: pointer;">
                                                <img id="btnSelectFile11" class="" src="IMG/bt_file.png" alt="" />
                                            </a>     
                                            <input id="fileImg11" type="file" name="img_path" accept="image/png, image/jpeg"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text11').value=this.value" />

                                        </td>
                                        <td width="366" height="44">
                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="347">
                                                <tbody><tr>
                                                    <td width="345" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                        <input type="text" id="fileimage_text11" placeholder="jpg,jpeg,png file" readonly="readonly" style="font-size:20px;width:100%" />
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
                                            <p align="center"><a style="cursor: pointer;" onclick="onChangeMarkerImg()" >
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



    <div id="dvRegMarker" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="199" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="114">
                                <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Register Marker</font></span></b></p>
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tbody><tr>
                                        <td width="119" height="44">
                                            <a onclick="javascript:OnBrowse('fileImg')" style="cursor: pointer;">
                                                <img id="btnSelectFile" class="" src="IMG/bt_file.png" alt="" />
                                            </a>     
                                            <input id="fileImg" type="file" name="img_path" accept="image/png, image/jpeg"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text').value=this.value" />

                                        </td>
                                        <td width="366" height="44">
                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="347">
                                                <tbody><tr>
                                                    <td width="345" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                        <input type="text" id="fileimage_text" placeholder="jpg,jpeg,png file" readonly="readonly" style="font-size:20px;width:100%" />
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
                                            <p align="center"><a style="cursor: pointer;" onclick="onRegMarkerImg()" >
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



    <div id="dvRegVideo" class="clspopup">
                <table cellpadding="0" cellspacing="0" width="550" align="center">
                <tbody><tr>
                    <td width="550" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="550" height="360" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="499" align="center">
                            <tbody><tr>
                                <td width="499" height="79" style="padding-left: 0px;">
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Edit Video</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="60"  style="padding-left: 50px;" >
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="100" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Upload</font></span></b></p>
                                            </td>
                                            <td width="398" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="119" height="44">
                                                            <input id="video_file1" type="file" name="video_path" accept="video/mp4, video/x-ms-wmv, video/x-msvideo, video/avi" class="clsBrowser" style="display: none" 
                                                                size="35" onchange="document.getElementById('video_file_text1').value=this.value"/>
                                                            <a onclick="javascript:OnBrowse('video_file1')" style="cursor: pointer;">
                                                                <img id="btnSelectFile1" class="" src="IMG/bt_file.png" alt="" />
								                                <input type="file" id="fileUpload1" style="display: none" />
                                                            </a>     
                                                        </td>
                                                        <td width="263" height="44">
                                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="249">
                                                                <tbody><tr>
                                                                    <td width="247" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                        <input type="text" style="font-size:20px;width:100%" id="video_file_text1" size="30" placeholder="wmv, mp4, avi" readonly="readonly" />
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="100" style="padding-left: 50px;" >
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="100" height="142">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Option<br /></font></span></b></p>
                                            </td>
                                            <td width="398" height="142">
                                                <table cellpadding="0" cellspacing="0" width="370" align="center">
                                                    <tbody><tr>
                                                        <td width="27" height="33">
                                                            <p><input id="videorun_rd1" onclick="OnHideCustomUploadVideo();" type="radio" name="videorun_rd" checked="checked" /></p>
                                                        </td>
                                                        <td width="343" height="33">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#666666">Autoplay</font></span></p>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td width="27" height="33">                        
                                                            <p><input id="videorun_rd2" onclick="OnHideCustomUploadVideo();" type="radio" name="videorun_rd" /></p>
                                                        </td>
                                                        <td width="343" height="33">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#666666">Play when touch video</font></span></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr align="center">
                                <td  height="36" style="display:inline-flex;margin-bottom:20px;margin-top:30px;">
                                    <div align="left">
                                        <a onclick="OnVideoApply1()" style="cursor:pointer">
                                            <img src="IMG/bt_confirm.png" border="0" width="122" height="37" alt="" /></a>
                                    </div>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <div align="right"><a onclick="closePopup();" style="cursor:pointer">
                                        <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2" alt="" /></a>
                                    </div>
                                </td>
                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>
    </div>
 
    <div id="dv3DObj" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
                <tbody><tr>
                    <td width="550" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="550" height="629" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="100" align="center">
                            <tbody><tr>
                                <td width="499" height="79" style="padding-left: 0px;" >
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Edit 3D Object</font></span></b></p>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="111" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="98" rowspan="2">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Upload<br /><br /><br />&nbsp;</font></span></b></p>
                                            </td>
                                            <td width="391" height="51">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="119" height="44">
                                                            <a style="cursor: pointer;" onclick="javascript:OnBrowse('three_file1')">
                                                                <img id="btnSelectFile4" class="" src="IMG/bt_file.png" alt="" />
                                                            </a>     
								                            <input id="three_file1"  type="file" name="three_file1" accept="application/unity3d"
                                                            class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileunity3d_text').value=this.value" />
                                                        </td>
                                                        <td width="263" height="44">
                                                            <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="249">
                                                                <tbody><tr>
                                                                    <td width="247" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                        <input type="text" id="fileunity3d_text" size="30" placeholder="unity3d zip File" readonly="readonly" style="font-size:11pt;width:100%;height:30px" />
                                                                    </td>
                                                                </tr>
                                                            </tbody></table>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="70" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Object Direction</font></span></b></p>
                                            </td>
                                            <td width="391" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="97" height="44">
                                                            <div align="right">
                                                                <table cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="82">
                                                                    <tbody><tr>
                                                                        <td width="80" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                            <input type="text" id="front_angle" name="front_angle" onkeypress="num_only()" style="float: left;font-size:11pt;width:95%;height:30px;" size="28" />
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </div>
                                                        </td>
                                                        <td width="25" height="44">
                                                            <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">angle</font></span></b></p>
                                                        </td>
                                                        <td width="260" height="44">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#999999">&nbsp;(1~360)</font></span></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="70" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Light</font></span></b></p>
                                            </td>
                                            <td width="391" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="380">
                                                    <tbody><tr>
                                                        <td width="50" height="40">
                                                            <div align="right">
                                                                <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">Light</font></span></b></p>
                                                            </div>
                                                        </td>
                                                        <td width="282" height="24" background="IMG/bar_light.png" style="background-position: 0px 4px;background-size: cover;">
                                                        <input type="hidden" id="hdBright" />
                                                        <table cellpadding="0" cellspacing="0" width="282" align="center">
                                                            <tr>
                                                                <td width="5">
                                                                </td>
                                                                <td width="24" id="tdBright1" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(1)"
                                                                    style="cursor: pointer" >
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="39">
                                                                </td>
                                                                <td width="24" id="tdBright25" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(25)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="40">
                                                                </td>
                                                                <td width="24" id="tdBright50" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(50)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="38">
                                                                </td>
                                                                <td width="24" id="tdBright75" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(75)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="35">
                                                                </td>
                                                                <td width="24" id="tdBright100" align="center" style="padding-top: 6px;" class="brightless" onclick="onSelBrightLess(100)"
                                                                    style="cursor: pointer">
                                                                    <img src="IMG/bar_light_circle.png" width="24" height="25" border="0">
                                                                </td>
                                                                <td width="5">
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                        <td width="63" height="40">
                                                            <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">Dark</font></span></b></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="70" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="107" height="49">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Runing time</font></span></b></p>
                                            </td>
                                            <td width="391" height="49">
                                                <table cellpadding="0" cellspacing="0" align="center" width="382">
                                                    <tbody><tr>
                                                        <td width="97" height="44">
                                                            <div align="right">
                                                                <table cellpadding="0" cellspacing="0" style="border-collapse:collapse;" width="82">
                                                                    <tbody><tr>
                                                                        <td width="80" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                                            <input type="text" id="run_times" name="run_times" onkeypress="num_only()" style="font-size:11pt; width:78px;height:30px" size="28"/>
                                                                        </td>
                                                                    </tr>
                                                                </tbody></table>
                                                            </div>
                                                        </td>
                                                        <td width="25" height="44">
                                                            <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#999999">time</font></span></b></p>
                                                        </td>
                                                        <td width="260" height="44">
                                                            <p><span style="font-size:11pt;"><font face="돋움" color="#999999">&nbsp;(unlimited: 0)</font></span></p>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="499" height="140" style="padding-left: 50px;">
                                    <table cellpadding="0" cellspacing="0" width="498">
                                        <tbody><tr>
                                            <td width="100" height="118">
                                                <p><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Option<br /><br /><br /><br /><br /></font></span></b></p>
                                            </td>
                                            <td width="398" height="118">

                                                <table cellpadding="0" cellspacing="0" width="361" align="center">
                                                    <tbody><tr>
                                                        <td width="377" height="113" valign="top">
                                                            <asp:RadioButtonList ID="RadioButtonList1" CssClass="rdoBtnList rdbThree" runat="server"
                                                                BackColor="#FBFBFB">
                                                                <asp:ListItem Value="0" Selected>General : place on the marker</asp:ListItem>
                                                                <asp:ListItem Value="1">TopBottom: place when top - bottom</asp:ListItem>
                                                                <asp:ListItem Value="2">Face : place coloring</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </td>
                                                    </tr>
                                                </tbody></table>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr align="center">
                                <td  height="36" style="display:inline-flex">
                                    <div align="left">
                                        <a onclick="OnThreeApply()" style="cursor:pointer">
                                            <img src="IMG/bt_confirm.png" border="0" width="122" height="37" alt="" /></a>

                                    </div>&nbsp;&nbsp;&nbsp;&nbsp;
                                    <div align="right"><a onclick="closePopup();" onmouseout="na_restore_img_src('image2', 'document')" onmouseover="na_change_img_src('image2', 'document', 'IMG/bt_cancel_r.png', true)">
                                        <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2" alt="" /></a>
                                    </div>
                                </td>

                            </tr>
                        </tbody></table>
                    </td>
                </tr>
            </tbody></table>
    </div>

    <div id="dvCopyCampaignAlert" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="451" style="border-collapse:collapse;" bgcolor="#F0F0F0">
            <tr>
                <td width="449" height="163" style="border-width:1; border-color:rgb(216,216,216); border-style:solid;" bgcolor="#F6F6F6">
                    <table cellpadding="0" cellspacing="0" align="center" width="387">
                        <tr>
                            <td width="387" height="77" valign="bottom" align="center">
                                <b><font face="돋움" color="#FFOOOO"><span style="font-size: 10pt;"></span></font></b>
                            </td>
                        </tr>
                        <tr>
                            <td width="387" height="77" align="center">
                               <input name="confirm" type="button" value="OK" onclick="closePopup()" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvRenameCampaign" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
                <tbody><tr>
                    <td width="550" height="10" bgcolor="#5D81EC"></td>
                </tr>
                <tr>
                    <td width="550" height="199" bgcolor="white">
                        <table cellpadding="0" cellspacing="0" width="514" align="center">
                            <tbody><tr>
                                <td width="514" height="114">
                                    <p align="center"><b><span style="font-size:11pt;"><font face="돋움" color="#666666">Change VI Name</font></span></b></p>
                                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse:collapse;" width="475">
                                        <tbody><tr>
                                            <td width="473" height="32" style="border-width:1; border-color:rgb(235,235,235); border-style:solid;">
                                                <asp:TextBox runat="server" ID="RenameCampainText" Width="473" Height="32" Font-Size="12" MaxLength="20" CssClass="control"></asp:TextBox>
                                            </td>
                                        </tr>
                                    </tbody></table>
                                </td>
                            </tr>
                            <tr>
                                <td width="514" height="49">
                                    <table cellpadding="0" cellspacing="0" align="center" width="290">
                                        <tbody><tr>
                                            <td width="145" height="36">
                                                <p align="center">
                                                    <asp:ImageButton runat="server" ID="btnRegCampain" ValidationGroup="vGroup01" onclick="btnRenameCampain_Click" OnClientClick="return checkCampain();" ImageUrl="IMG/bt_confirm.png"/>
                                                </p>
                                            </td>

                                            <td width="145" height="36">
                                                <p align="center"><a onclick="closePopup();" onmouseout="na_restore_img_src('image2', 'document')" onmouseover="na_change_img_src('image2', 'document', 'IMG/bt_cancel_r.png', true)">
                                                    <img src="IMG/bt_cancel.png" border="0" width="122" height="37" name="image2"></a></p>
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
    
    <div id="dvVideo3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="251" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Video - 3D&nbsp;Template</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="137" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="127">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd1" type="radio" name="video_rd" value="0" checked />Not Applying
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd2" type="radio" name="video_rd" value="1" />3D Classic TV
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="video_rd3" type="radio" name="video_rd" value="2" />
                                                        3D Wide Plane TV
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="Apply" onclick="OnVideoApply2()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvWeb" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="border-width: 1px; border-color: rgb(255,102,0);
            border-style: solid; background-color: White">
            <tr>
                <td width="520" valign="top">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="54">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit &nbsp;Website</span></font></b>
                                        </td>
                                        <td width="91" height="54" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            URL
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" id="web_url" name="web_url" style="width: 300px" maxlength="100" placeholder="http://xxx.xxx.xxx/xxxx."
                                                class="control" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="88" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        VIEW Option
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="88" valign="top" align="left">
                                            <asp:RadioButtonList ID="rdbWeb2" CssClass="rdbWeb2 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">Link</asp:ListItem>
                                                <asp:ListItem Value="1">Brower</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button type
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" valign="top">
                                            <asp:RadioButtonList ID="rdbWeb1" CssClass="rdbWeb1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">Default button</asp:ListItem>
                                                <asp:ListItem Value="1">Custom Button</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorWebMode">
                                        <td>
                                        </td>
                                        <td width="361" height="119" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdWebModeBtn1" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Web" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('Website',1)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Website</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdWebModeBtn2" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_App" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('APP Download',2)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">APP Download</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdWebModeBtn3" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Direct" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('Goto',3)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Goto</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdWebModeBtn4" class="clsModeBtn">
                                                        <table class="btnDefaultWebMode_Buy" cellpadding="0" cellspacing="0" align="center"
                                                            onclick="onChangeDefaultWebBtn('Buy',4)" style="cursor: pointer; border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Buy</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button Color
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdWebColorBtn11" class="clsColorBtn" onclick="onChangeWebColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn1" class="clsColorBtn" onclick="onChangeWebColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn2" class="clsColorBtn" onclick="onChangeWebColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn3" class="clsColorBtn" onclick="onChangeWebColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn4" class="clsColorBtn" onclick="onChangeWebColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn5" class="clsColorBtn" onclick="onChangeWebColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn6" class="clsColorBtn" onclick="onChangeWebColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn7" class="clsColorBtn" onclick="onChangeWebColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn8" class="clsColorBtn" onclick="onChangeWebColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn9" class="clsColorBtn" onclick="onChangeWebColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebColorBtn10" class="clsColorBtn" onclick="onChangeWebColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button Font Format
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdWebTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FFFFFF','tdWebTextColorBtn',11,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#DDDDDD','tdWebTextColorBtn',1,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#999999','tdWebTextColorBtn',2,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','black','tdWebTextColorBtn',3,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#079DEC','tdWebTextColorBtn',4,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#1234AB','tdWebTextColorBtn',5,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','red','tdWebTextColorBtn',6,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FF7700','tdWebTextColorBtn',7,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#FFDD00','tdWebTextColorBtn',8,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#33AA22','tdWebTextColorBtn',9,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdWebTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spWebPreviewText','#BB33AA','tdWebTextColorBtn',10,'hdWebTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>


                                    <tr class="trNorWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Preview Button
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblWebPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon03.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spWebPreviewText">Website</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomWebMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Upload
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="webbtn_path" type="file" name="webbtn_path" accept="image/png" class="clsBrowser"
                                                            size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="520" height="45" valign="top">
                                <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                    width="502">
                                    <tr>
                                        <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                            border-right-color: black; border-bottom-color: black; border-left-color: black;
                                            border-style: none;">
                                            <table cellpadding="0" cellspacing="0" align="center" width="466">
                                                <tr>
                                                    <td width="466" height="44" align="right">
                                                        <input type="hidden" id="hdWebModeIndex" value="1" />
                                                        <input type="hidden" id="hdWebColorIndex" value="1" />
                                                        <input type="hidden" id="hdWebTextColorIndex" value="1" />
                                                        <input type="button" id="btnWebApply" onclick="OnWebApply()" class="clsButton" value="Apply"
                                                            style="font-weight: bold; width: 124px; height: 30px;" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvPhone" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" valign="top" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="38">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit&nbsp;Postphone&nbsp;</span></font></b>
                                        </td>
                                        <td width="91" height="38" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="37" valign="top" class="clsLabel">
                                        </td>
                                        <td width="91" height="37" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            Input Postphone
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" onkeypress="num_only()" id="tel_no" name="tel_no" maxlength="13" placeholder="'-' omission"
                                                class="control" style="width: 90%; ime-mode: disabled;" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button Type
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" valign="top">
                                            <asp:RadioButtonList ID="rdbTel1" CssClass="rdbTel1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">Default Button</asp:ListItem>
                                                <asp:ListItem Value="1">Custom Button</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td>
                                        </td>
                                        <td width="361" height="108" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdTelModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('Phone Number',1)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Phone Number</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdTelModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('Office phone',2)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Office phone</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdTelModeBtn3" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('연락처',3)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Contact</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdTelModeBtn4" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultTelBtn('Order',4)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Order</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button Color
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdTelColorBtn11" class="clsColorBtn" onclick="onChangeTelColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn1" class="clsColorBtn" onclick="onChangeTelColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn2" class="clsColorBtn" onclick="onChangeTelColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn3" class="clsColorBtn" onclick="onChangeTelColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn4" class="clsColorBtn" onclick="onChangeTelColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn5" class="clsColorBtn" onclick="onChangeTelColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn6" class="clsColorBtn" onclick="onChangeTelColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn7" class="clsColorBtn" onclick="onChangeTelColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn8" class="clsColorBtn" onclick="onChangeTelColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn9" class="clsColorBtn" onclick="onChangeTelColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelColorBtn10" class="clsColorBtn" onclick="onChangeTelColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button Font Format
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdTelTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FFFFFF','tdTelTextColorBtn',11,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD;">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#DDDDDD','tdTelTextColorBtn',1,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#999999','tdTelTextColorBtn',2,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','black','tdTelTextColorBtn',3,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#079DEC','tdTelTextColorBtn',4,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#1234AB','tdTelTextColorBtn',5,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','red','tdTelTextColorBtn',6,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FF7700','tdTelTextColorBtn',7,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#FFDD00','tdTelTextColorBtn',8,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#33AA22','tdTelTextColorBtn',9,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdTelTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spTelPreviewText','#BB33AA','tdTelTextColorBtn',10,'hdTelTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorTelMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Preview Button
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblTelPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon04.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spTelPreviewText">Phone Number</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomTelMode">
                                        <td height="25">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr class="trCustomTelMode">
                                        <td width="115" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Upload
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="telbtn_path" type="file" name="telbtn_path" accept="image/jpeg, image/png"
                                                            class="clsBrowser" size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="466">
                                    <tr>
                                        <td width="466" height="44" align="right">
                                            <input type="hidden" id="hdTelColorIndex" value="1" />
                                            <input type="hidden" id="hdTelModeIndex" value="1" />
                                            <input type="hidden" id="hdTelTextColorIndex" value="1" />
                                            <input type="button" id="btnTelApply" onclick="OnTelApply1()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 124px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

        <div id="dvImage" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="195" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit Image</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="61" align="center" class="clsTitleLabel">
                                            Upload
                                        </td>
                                        <td width="377" height="61" align="center">
                                            <input type="text" id="fileimage_text1" size="30" placeholder="jpg,jpeg,png File" readonly="readonly" />
                                            <input type="button" value="Find..." onclick="javascript: OnBrowse('image_file')" />
                                            <input id="image_file" type="file" name="img_path" accept="image/png, image/jpeg"
                                                class="clsBrowser" style="display: none" size="31" onchange="document.getElementById('fileimage_text1').value=this.value">
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" style="width: 103px; height: 30px; font-weight: bold;" class="clsButton"
                                                value="Apply" onclick="OnImageApply1()" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvImage3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="210" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Image - 3D&nbsp;template</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="88">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="imgview_rd1" type="radio" name="imgview_rd" title="Not Apply" checked>
                                                        Not Apply
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="imgview_rd2" type="radio" name="imgview_rd" title="3D Stand Type">
                                                        3D Stand Type
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button14" onclick="OnImageApply2()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvPhone3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="210" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Postphone - 3D&nbsp;template</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="88">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="rdTel1" type="radio" name="rdTel" title="Not Applying" value="twoD" checked />
                                                        Not Applying
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="rdTel2" type="radio" name="rdTel" title="3D Classic Phone" value="threeD" />
                                                        3D Classic Phone
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button3" onclick="OnTelApply2()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
        <div id="dvText" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="620" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="60">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit Text</span></font></b>
                                        </td>
                                        <td width="91" height="60" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="105" align="center" class="clsTitleLabel">
                                            Text String
                                        </td>
                                        <td width="361" height="105">
                                            <table cellpadding="0" cellspacing="0" width="349" align="center">
                                                <tr>
                                                    <td width="327" height="69" align="left">
                                                        <textarea id="notepad_content" cols="20" rows="4" maxlength="60" style="width: 325px;"></textarea>
                                                    </td>
                                                    <td width="22" height="69" align="right" class="clsLabel" valign="top">
                                                        <span id="spLimitCharacters" style="font-family:돋움; color:666666; font-size: 10pt;">60</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="70" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Text Color
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdNotepadColorBtn11" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn1" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn2" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn3" class="clsColorBtnCopy" onclick="onChangeNotepadColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn4" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn5" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn6" class="clsColorBtnCopy" onclick="onChangeNotepadColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn7" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn8" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn9" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadColorBtn10" class="clsColorBtnCopy" onclick="onChangeNotepadColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="72" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="46" align="center" class="clsTitleLabel">
                                                        Text Border
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="72" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="69" height="47" id="tdNotepadTypeBtn1" class="clsLabel clsBoardType" onclick="onChangeBoardType(0);">
                                                        None
                                                    </td>
                                                    <td width="71" height="47" id="tdNotepadTypeBtn2" class="clsLabel clsBoardType" onclick="onChangeBoardType(1);">
                                                        <img src="img/icon_text01.png" width="38" height="33" border="0">
                                                    </td>
                                                    <td width="71" height="47" id="tdNotepadTypeBtn3" class="clsLabel clsBoardType" onclick="onChangeBoardType(2);">
                                                        <img src="img/icon_text02.png" width="38" height="33" border="0">
                                                    </td>
                                                    <td width="70" height="47" id="tdNotepadTypeBtn4" class="clsLabel clsBoardType" onclick="onChangeBoardType(3);">
                                                        <img src="img/icon_text03.png" width="38" height="33" border="0">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="70" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="37" align="left" class="clsTitleLabel">
                                                        Text Border Color
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn11" class="clsColorBtn" onclick="onChangeBoardColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn1" class="clsColorBtn" onclick="onChangeBoardColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn2" class="clsColorBtn" onclick="onChangeBoardColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn3" class="clsColorBtn" onclick="onChangeBoardColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn4" class="clsColorBtn" onclick="onChangeBoardColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn5" class="clsColorBtn" onclick="onChangeBoardColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn6" class="clsColorBtn" onclick="onChangeBoardColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn7" class="clsColorBtn" onclick="onChangeBoardColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn8" class="clsColorBtn" onclick="onChangeBoardColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn9" class="clsColorBtn" onclick="onChangeBoardColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdNotepadTextColorBtn10" class="clsColorBtn" onclick="onChangeBoardColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="110" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="37" align="left" class="clsTitleLabel">
                                                        Text Play Method
                                                    </td>
                                                </tr>
                                            </table>
                                            &nbsp;
                                        </td>
                                        <td width="361" height="110" valign="top">
                                            <asp:RadioButtonList ID="rdoTextPlayMode" CssClass="rdoTextPlayMode rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">None</asp:ListItem>                                                
                                                <asp:ListItem Value="1">Fade effect</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="100" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="26" align="left" class="clsTitleLabel">
                                                        &nbsp;&nbsp;&nbsp;Preview
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="100" valign="top">
                                            <table id="tblNotepadPreviewBtn" width="323" height="100" cellpadding="0" cellspacing="0" background="" style="background-repeat:no-repeat">
                                                <tr>
                                                    <td width="351" class="clsLabel" style="padding-left:20px; padding-right:20px" >
                                                        <span id="spNotepadPreview" style="word-break:break-word"></span><span id="spBorderPreview" style="display: none;
                                                            color: #999999;">0</span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="78" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="466">
                                    <tr>
                                        <td width="466" height="44" align="right">
                                            <input type="hidden" id="hdNotepadTextColorIndex" value="1"/>
                                            <input type="hidden" id="hdNotepadColorIndex" value="1"/>
                                            <input type="text" id="hdNotepadColor" value="#FFFFFF"/>
                                            <input type="hidden" id="hdNotepadType" value="1"/>
                                            <input type="button" id="Button6" onclick="OnNotepadApply1()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 124px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvText3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="210" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">TEXT - 3D&nbsp;template</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="88">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="notepad_rd1" type="radio" name="notepad_rd" title="Note Apply" value="common"
                                                            checked />
                                                        Not Apply
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="notepad_rd2" type="radio" name="notepad_rd" title="3D Desk Memo" value="3dmodel" />
                                                        3D Desk Memo
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button7" onclick="OnNotepadApply2()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvBGM" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" style="border-width: 1px; border-color: rgb(255,102,0); border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit BGM</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="182" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="487">
                                    <tr>
                                        <td width="110" height="30" align="center" class="clsTitleLabel">
                                            Upload
                                        </td>
                                        <td width="377" height="61" align="center">
                                            <input type="button" value="File Selection" onclick="javascript: OnBrowse('audio_file')" />
                                            <input type="text" id="audio_file_text" size="30" placeholder="wma, mp3 File" readonly="readonly" />
                                            <input type="file" id="audio_file" name="audio_file" accept="audio/mp3" class="clsBrowser"
                                                style="display: none" size="49" onchange="document.getElementById('audio_file_text').value=this.value" />                                            
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="110" height="105" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button Type
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="377" height="105" valign="top">
                                            <asp:RadioButtonList ID="rdbBGM1" CssClass="rdbBGM1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">None Button</asp:ListItem>
                                                <asp:ListItem Value="1">Default Button</asp:ListItem>
                                                <asp:ListItem Value="2">Custom Button</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trShowBGMMode">
                                        <td width="115" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="46" align="center" class="clsTitleLabel">
                                                        Button Shape
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" valign="top">
                                            <table class="tblNorBGMMode" cellpadding="0" cellspacing="0" width="359">
                                                <tr>
                                                    <td width="180" height="47" id="tdBGMModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" width="169" align="center" onclick="onChangeBGMType(1);"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7">
                                                            <tr>
                                                                <td width="167" height="35" bgcolor="#F7F7F7" style="border-width: 1px; border-color: rgb(193,193,193);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="161">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon07.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="126" height="27" align="center">
                                                                                <b><span style="font-size: 10pt;"><font face="돋움" color="#8C959A">BGM</font></span></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="179" height="47" id="tdBGMModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" width="169" align="center" onclick="onChangeBGMType(2);"
                                                            style="cursor: pointer; border-collapse: collapse;">
                                                            <tr>
                                                                <td width="167" height="35" bgcolor="#F7F7F7" style="border-width: 1px; border-color: rgb(193,193,193);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="161">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon07.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="126" height="27" align="center">
                                                                                <b><span style="font-size: 10pt;"><font face="돋움" color="#8C959A">Sound</font></span></b>
                                                                            </td>
                                                                        </tr>                                                                        
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="60" id="tdBGMModeBtn3" class="clsModeBtn" align="center" onclick="onChangeBGMType(3);" style="cursor: pointer;" >
                                                        <img src="img/icon_bgm01.png" width="50" height="42" border="0">
                                                    </td>
                                                    <td width="179" height="60" id="tdBGMModeBtn4" class="clsModeBtn" align="center" onclick="onChangeBGMType(4);" style="cursor: pointer;">
                                                        <img src="img/icon_bgm02.png" width="33" height="42" border="0">
                                                    </td>
                                                </tr>
                                            </table>                                            
                                        </td>
                                        <td width="361" height="36">
                                        </td>
                                    </tr>
                                    <tr class="trShowBGMMode">
                                        <td width="115" height="70" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="37" align="center" class="clsTitleLabel">
                                                        Button Color
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdBGMColorBtn11" class="clsColorBtn" onclick="onChangeBGMColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn1" class="clsColorBtn" onclick="onChangeBGMColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn2" class="clsColorBtn" onclick="onChangeBGMColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn3" class="clsColorBtn" onclick="onChangeBGMColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn4" class="clsColorBtn" onclick="onChangeBGMColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn5" class="clsColorBtn" onclick="onChangeBGMColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn6" class="clsColorBtn" onclick="onChangeBGMColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn7" class="clsColorBtn" onclick="onChangeBGMColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn8" class="clsColorBtn" onclick="onChangeBGMColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn9" class="clsColorBtn" onclick="onChangeBGMColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMColorBtn10" class="clsColorBtn" onclick="onChangeBGMColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trShowBGMMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button text color
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#FFFFFF','tdBGMTextColorBtn',11,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#DDDDDD','tdBGMTextColorBtn',1,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#999999','tdBGMTextColorBtn',2,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','black','tdBGMTextColorBtn',3,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#079DEC','tdBGMTextColorBtn',4,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#1234AB','tdBGMTextColorBtn',5,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','red','tdBGMTextColorBtn',6,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#FF7700','tdBGMTextColorBtn',7,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#FFDD00','tdBGMTextColorBtn',8,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#33AA22','tdBGMTextColorBtn',9,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdBGMTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spNorBGMLabel','#BB33AA','tdBGMTextColorBtn',10,'hdBGMTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>

                                    <tr class="trShowBGMMode">
                                        <td width="115" height="63" valign="center">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="26" align="center" class="clsTitleLabel">
                                                        Preview
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="63" valign="center">                                            
                                            <table id="tblBGMNorPreviewBtn" class="tblNorBGMMode" cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="center">
                                                        <table id="tblBGMPreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon07.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A" id="spNorBGMLabel">
                                                                                    BGM</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tblBGMCustomPreviewBtn" class="tblCustomBGMMode" cellpadding="0" cellspacing="0" width="180" style="display:none">
                                                <tr>
                                                    <td width="180" height="60" align="center">
                                                        <img id="imgCustomBGM" src="img/icon_bgm01.png" border="0">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomBGMMode">
	                                    <td width="115" height="65" valign="top">
		                                    <table cellpadding="0" cellspacing="0" width="105" align="center">
			                                    <tr>
				                                    <td width="105" height="32" align="center" class="clsTitleLabel">
					                                    Upload
				                                    </td>
			                                    </tr>
		                                    </table>
	                                    </td>
	                                    <td width="361" height="65" valign="top">
		                                    <table cellpadding="0" cellspacing="0">
			                                    <tr>
				                                    <td width="367" height="32">
					                                    <input id="bgmbtn_path" type="file" name="bgmbtn_path" accept="image/jpeg, image/png"
						                                    class="clsBrowser" size="30">
				                                    </td>
			                                    </tr>
		                                    </table>
	                                    </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="44" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="hidden" id="hdBGMColorIndex" value="1"/>
                                            <input type="hidden" id="hdBGMModeIndex" value="1"/>
                                            <input type="hidden" id="hdBGMTextColorIndex" value="1"/>
                                            <input type="button" id="Button8" onclick="OnAudioApply1()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvBGM3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="232" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit BGM</span>
                                            </font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="111">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="audiobtn_rd1" type="radio" name="audiobtn_rd" title="General" value="0" checked />
                                                        Not Apply
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="audiobtn_rd2" type="radio" name="audiobtn_rd" title="3D Sound Play" value="1" />
                                                        3D Sound Play
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="367" height="32" class="clsLabel">
                                                        <input id="audiobtn_rd3" type="radio" name="audiobtn_rd" title="3D Classic Sound Play"
                                                            value="2" />
                                                        3D Classic Sound Play
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="54" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button10" onclick="OnAudioApply2()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvSlide" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="635" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="96" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit Image Slide</span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="43" class="clsLabel">
                                        </td>
                                        <td width="91" height="43" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="264" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <input type="hidden" id="addSlideImgID" />
                                <input id="slide_file" type="file" name="img_path" accept="image/png, image/jpeg"
                                    style="display: none;" />
                                <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black"
                                    align="center" width="475">
                                    <tr>
                                        <td width="95" height="100">
                                            <table id="tdSlide1Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(1)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide1Empty" class="clsSlideEmpty" onclick="onAddSlideImage(1)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide2Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(2)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide2Empty" class="clsSlideEmpty" onclick="onAddSlideImage(2)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide3Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(3)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide3Empty" class="clsSlideEmpty" onclick="onAddSlideImage(3)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide4Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(4)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide4Empty" class="clsSlideEmpty" onclick="onAddSlideImage(4)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide5Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(5)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide5Empty" class="clsSlideEmpty" onclick="onAddSlideImage(5)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="95" height="100">
                                            <table id="tdSlide6Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(6)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide6Empty" class="clsSlideEmpty" onclick="onAddSlideImage(6)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide7Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(7)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide7Empty" class="clsSlideEmpty" onclick="onAddSlideImage(7)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide8Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(8)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide8Empty" class="clsSlideEmpty" onclick="onAddSlideImage(8)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide9Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(9)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide9Empty" class="clsSlideEmpty" onclick="onAddSlideImage(9)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="95" height="100">
                                            <table id="tdSlide10Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                                border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                                        border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                                        border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                                        border-left-style: solid;" align="center">
                                                        <img class="slideImg" src="" width="80" height="57" border="0">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                                        border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                                        border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                                        bgcolor="#CCCCCC" align="center">
                                                        <img class="image-btn" onclick="onRemoveSlideImage(10)" src="img/cam_icon_trash.png"
                                                            width="18" height="21" border="0" name="image3">
                                                    </td>
                                                </tr>
                                            </table>
                                            <table id="tdSlide10Empty" class="clsSlideEmpty" onclick="onAddSlideImage(10)" cellpadding="0"
                                                cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                                <tr>
                                                    <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                                        border-style: solid;" align="center">
                                                        <span style="font-size: 24pt; color: #999999"></span>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="25">
                                            &nbsp;
                                        </td>
                                        <td width="91" height="25" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="38" align="left" class="clsTitleLabel">
                                                        Image
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="123" valign="top">
                                            <asp:RadioButtonList ID="rdoSlideShowType" CssClass="rdoSlideShowType rdoBtnList"
                                                runat="server">
                                                <asp:ListItem Value="0" Selected="True">None</asp:ListItem>
                                                <asp:ListItem Value="1">Fade In/Out</asp:ListItem>
                                                <asp:ListItem Value="2">Slide</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="88" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="35" align="left" class="clsTitleLabel">
                                                        Image Play
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="88" valign="top">
                                            <asp:RadioButtonList ID="rdoSlidePlayType" CssClass="rdoSlidePlayType rdoBtnList"
                                                runat="server">
                                                <asp:ListItem Value="0" Selected="True">auto play per 3 second period</asp:ListItem>
                                                <asp:ListItem Value="1">play when touch image</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="79" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button11" onclick="OnSlideApply1()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvSlide3D" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" height="208" style="border-width: 1px; border-color: rgb(255,102,0);
                    border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="31">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Image&nbsp;-&nbsp;3D Template
                                            </span></font></b>
                                        </td>
                                        <td width="91" height="31" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="98" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="469">
                                    <tr>
                                        <td width="469" height="87">
                                            <asp:RadioButtonList ID="rdoSlideViewType" CssClass="rdoSlideViewType rdoBtnList"
                                                runat="server">
                                                <asp:ListItem Value="0" Selected="True">Not Apply</asp:ListItem>
                                                <asp:ListItem Value="1">3D Stand Type</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="54" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="485">
                                    <tr>
                                        <td width="485" height="41" align="right">
                                            <input type="button" id="Button12" onclick="OnSlideApply2()" class="clsButton" value="Apply"
                                                style="font-weight: bold; width: 103px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    <div id="dvCapture" class="clspopup">
        <table cellpadding="0" cellspacing="0" align="center" style="background-color: White;
            border-collapse: collapse;" width="502">
            <tr>
                <td width="500" height="96" style="border-width: 1px; border-top-color: black; border-right-color: black;
                    border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                    <table cellpadding="0" cellspacing="0" align="center" width="475">
                        <tr>
                            <td width="384" height="31">
                                <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit Chromakey&nbsp;Photo&nbsp;</span></font></b>
                            </td>
                            <td width="91" height="31" align="right">
                                <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                    height="16" border="0" name="image1" />
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" align="center" width="475">
                        <tr>
                            <td width="421" height="43">
                                <span style="font-size: 10pt;"><font face="돋움" color="#4C4C4C"></font></span>
                            </td>
                            <td width="54" height="43" align="right">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="500" height="264" align="center" style="border-width: 1px; border-top-color: rgb(229,233,235);
                    border-right-color: black; border-bottom-color: black; border-left-color: black;
                    border-style: none;">
                    <input type="hidden" id="addCaptureImgID" />
                    <input id="capture_file" type="file" name="capture_file" accept="image/png" style="position: absolute;
                        height: 46px; width: 260px; display: none;" />
                    <table cellpadding="0" cellspacing="0" bordercolordark="black" bordercolorlight="black"
                        align="center" width="475">
                        <tr>
                            <td width="95" height="100">
                                <table id="tdCapture1Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev1" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(11)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture1Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(1)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture2Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev2" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(12)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture2Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(2)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture3Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev3" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(13)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture3Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(3)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture4Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev4" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(14)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture4Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(4)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="95" height="100">
                                <table id="tdCapture5Image" cellpadding="0" cellspacing="0" align="center" style="display: none;
                                    border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="69" style="border-width: 1px; border-top-color: rgb(153,153,153);
                                            border-right-color: rgb(153,153,153); border-bottom-color: black; border-left-color: rgb(153,153,153);
                                            border-top-style: solid; border-right-style: solid; border-bottom-style: none;
                                            border-left-style: solid;" align="center">
                                            <img class="clscapprev" id="capimgPrev5" src="" width="80" height="57" border="0">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="85" height="24" style="border-width: 1px; border-top-color: black; border-right-color: rgb(153,153,153);
                                            border-bottom-color: rgb(153,153,153); border-left-color: rgb(153,153,153); border-top-style: none;
                                            border-right-style: solid; border-bottom-style: solid; border-left-style: solid;"
                                            bgcolor="#CCCCCC" align="center">
                                            <img class="image-btn" onclick="onRemoveSlideImage(15)" src="img/cam_icon_trash.png"
                                                width="18" height="21" border="0" name="image3">
                                        </td>
                                    </tr>
                                </table>
                                <table id="tdCapture5Empty" class="clsCaptureEmpty" onclick="onAddCaptureImage(5)"
                                    cellpadding="0" cellspacing="0" align="center" style="cursor: pointer; border-collapse: collapse;">
                                    <tr>
                                        <td width="85" height="93" style="border-width: 1px; border-color: rgb(153,153,153);
                                            border-style: solid;" align="center">
                                            <span style="font-size: 24pt; color: #999999"></span>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <div id="capture_detail_div" style="position: relative; width: 475px; height: 250px;
                        background-color: #CCCCCC; z-index: 1">
                    </div>
                    <table cellpadding="0" cellspacing="0" align="center" width="475">
                        <tr>
                            <td width="384" height="25">
                                &nbsp;
                            </td>
                            <td width="91" height="25" align="right">
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" align="center" width="476">
                        <tr>
                            <td width="115" height="86" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="38" align="left" class="clsTitleLabel">
                                            Button Type
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="86" valign="top" align="left">
                                <asp:RadioButtonList ID="rdbCapture" CssClass="rdbCapture rdoBtnList" runat="server">
                                    <asp:ListItem Value="0" Selected="True">Default Button</asp:ListItem>
                                    <asp:ListItem Value="1">Custom Button</asp:ListItem>
                                </asp:RadioButtonList>
                            </td>
                        </tr>
                        <tr class="clsCustomCaptureMode">
                            <td width="115" height="35" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="35" align="left" class="clsTitleLabel">
                                            Upload
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="35" valign="top">
                                <table cellpadding="0" cellspacing="0" width="356">
                                    <tr>
                                        <td width="180" height="35">
                                            <input id="capturebtn_path" type="file" name="capturebtn_path" accept="image/jpeg, image/png"
                                                class="clsBrowser" size="35" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr class="clsNorCaptureMode">
                            <td width="115" height="55" valign="center">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="35" align="left" class="clsTitleLabel">
                                            Button Type
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="55" valign="center">
                                <table cellpadding="0" cellspacing="0" width="356">
                                    <tr>
                                        <td width="180" height="47" valign="center" id="tdCaptureModeBtn1" class="clsModeBtn" >
                                            <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeCaptureType(0);"
                                                style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <div align="left">
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon09.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Chroma-key photo</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="176" height="47" valign="center" id="tdCaptureModeBtn2" class="clsModeBtn">
                                            <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeCaptureType(1);"
                                                style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <div align="left">
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon09.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">PhototakenWith</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table class="clsNorCaptureMode" cellpadding="0" cellspacing="0" align="center" width="476">
                        <tr>
                            <td width="115" height="10" valign="center">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            Color
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="center">
                                <table cellpadding="0" cellspacing="0" width="350">
                                    <tr>
                                        <td width="35" height="35" id="tdCaptureColorBtn11" class="clsColorBtn" onclick="onChangeCaptureColor('#FFFFFF',11);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                <tr>
                                                    <td width="25" height="25" style="border:1px solid #DDDDDD">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn1" class="clsColorBtn" onclick="onChangeCaptureColor('#DDDDDD',1);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn2" class="clsColorBtn" onclick="onChangeCaptureColor('#999999',2);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn3" class="clsColorBtn" onclick="onChangeCaptureColor('black',3);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="black">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn4" class="clsColorBtn" onclick="onChangeCaptureColor('#079DEC',4);">
                                            <table cellpadding="0" cellspacing="0" align="center">
                                                <tr>
                                                    <td width="25" height="25" bgcolor="#079DEC">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn5" class="clsColorBtn" onclick="onChangeCaptureColor('#1234AB',5);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn6" class="clsColorBtn" onclick="onChangeCaptureColor('red',6);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn7" class="clsColorBtn" onclick="onChangeCaptureColor('#FF7700',7);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn8" class="clsColorBtn" onclick="onChangeCaptureColor('#FFDD00',8);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn9" class="clsColorBtn" onclick="onChangeCaptureColor('#33AA22',9);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="35" height="35" id="tdCaptureColorBtn10" class="clsColorBtn" onclick="onChangeCaptureColor('#BB33AA',10);">
                                            <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                <tr>
                                                    <td width="25" height="25">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                    <table class="clsNorCaptureMode" cellpadding="0" cellspacing="0" align="center" width="476">
                        <tr>
                            <td width="115" height="10" valign="top">
                                <table cellpadding="0" cellspacing="0" width="105" align="center">
                                    <tr>
                                        <td width="105" height="32" align="center" class="clsTitleLabel">
                                            Preview
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td width="361" height="61" valign="top">
                                <table cellpadding="0" cellspacing="0" width="355">
                                    <tr>
                                        <td width="180" height="47" valign="top">                                            
                                            <table id="tblCapturePreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                bgcolor="#F7F7F7" width="169">
                                                <tr>
                                                    <td width="167" height="35" style="border-width: 1px; border-color: rgb(187,187,187);
                                                        border-style: solid;">
                                                        <div align="left">
                                                            <table cellpadding="0" cellspacing="0" width="161">
                                                                <tr>
                                                                    <td width="35" height="27" align="right">
                                                                        <img src="img/cam_icon09.png" width="19" height="19" border="0">
                                                                    </td>
                                                                    <td width="126" height="27" align="center">
                                                                        <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spCapture">Chroma-key photo</span></font></b>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="175" height="47">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td width="500" height="69" style="border-width: 1px; border-top-color: rgb(229,233,235);
                    border-right-color: black; border-bottom-color: black; border-left-color: black;
                    border-style: none;">
                    <div align="right">
                        <table cellpadding="0" cellspacing="0" align="center" width="485">
                            <tr>
                                <td align="right" width="485" height="41">
                                    <input type="hidden" id="hdCaptureType" value="0" />
                                    <input type="hidden" id="hdCaptureColorIndex" value="0" />
                                    <input type="button" id="Button1" onclick="OnCaptureApply()" class="clsButton" value="Apply"
                                        style="font-weight: bold; width: 103px; height: 30px;" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
            </tr>
        </table>
    </div>

        <div id="dvGoogleMap" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="522" style="background-color: White">
            <tr>
                <td width="520" style="border-width: 1px; border-color: rgb(255,102,0); border-style: solid;">
                    <table cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                        width="502">
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="38" style="border-width: 1px; border-top-color: black; border-right-color: black;
                                border-bottom-color: rgb(229,233,235); border-left-color: black; border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="384" height="38">
                                            <b><font face="돋움" color="#4C4C4C"><span style="font-size: 12pt;">Edit Googlemap</span></font></b>
                                        </td>
                                        <td width="91" height="38" align="right">
                                            <img class="image-btn" onclick="closePopup()" src="img/popup_close.png" width="16"
                                                height="16" border="0" name="image1" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="475">
                                    <tr>
                                        <td width="413" height="37" valign="top" class="clsLabel">
                                            Please input position point that you want to show by using google-map points
                                        </td>
                                        <td width="62" height="37" align="right">
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="86" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="476">
                                    <tr>
                                        <td width="115" height="70" align="center" class="clsTitleLabel">
                                            Input points
                                        </td>
                                        <td width="361" height="70" align="left">
                                            <input type="text" id="coordinate" name="coordinate" onkeypress="googlepos_only()" placeholder="X,Y"
                                                size="49" style="font-family: 돋움; font-size: 10pt; color: rgb(153,153,153);">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="115" height="64" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        ButtonType
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="64" align="left" valign="top">
                                            <asp:RadioButtonList ID="rdbGoogle1" CssClass="rdbGoogle1 rdoBtnList" runat="server">
                                                <asp:ListItem Value="0" Selected="True">Default Button</asp:ListItem>
                                                <asp:ListItem Value="1">Custom Button</asp:ListItem>
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td>
                                        </td>
                                        <td height="116" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="360">
                                                <tr>
                                                    <td width="180" height="47" id="tdGoogleModeBtn1" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('Google Map',1)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Google Map</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="47" id="tdGoogleModeBtn2" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('ViewMap',2)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">ViewMap</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="180" height="46" id="tdGoogleModeBtn3" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('Place',3)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Place</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="180" height="46" id="tdGoogleModeBtn4" class="clsModeBtn">
                                                        <table cellpadding="0" cellspacing="0" align="center" onclick="onChangeDefaultGoogleBtn('Position',4)"
                                                            style="cursor: pointer; border-collapse: collapse;" bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움" color="#8C959A"><span style="font-size: 10pt;">Position</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        ButtonColor
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdGoogleColorBtn11" class="clsColorBtn" onclick="onChangeGoogleColor('#FFFFFF',11);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn1" class="clsColorBtn" onclick="onChangeGoogleColor('#DDDDDD',1);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn2" class="clsColorBtn" onclick="onChangeGoogleColor('#999999',2);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn3" class="clsColorBtn" onclick="onChangeGoogleColor('black',3);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn4" class="clsColorBtn" onclick="onChangeGoogleColor('#079DEC',4);">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn5" class="clsColorBtn" onclick="onChangeGoogleColor('#1234AB',5);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn6" class="clsColorBtn" onclick="onChangeGoogleColor('red',6);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn7" class="clsColorBtn" onclick="onChangeGoogleColor('#FF7700',7);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn8" class="clsColorBtn" onclick="onChangeGoogleColor('#FFDD00',8);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn9" class="clsColorBtn" onclick="onChangeGoogleColor('#33AA22',9);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleColorBtn10" class="clsColorBtn" onclick="onChangeGoogleColor('#BB33AA',10);">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Button Font Color
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="350">
                                                <tr>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn11" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#FFFFFF','tdGoogleTextColorBtn',11,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFFFFF">
                                                            <tr>
                                                                <td width="23" height="23" style="border:1px solid #DDDDDD" >
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn1" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#DDDDDD','tdGoogleTextColorBtn',1,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#DDDDDD">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn2" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#999999','tdGoogleTextColorBtn',2,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#999999">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn3" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','black','tdGoogleTextColorBtn',3,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="black">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn4" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#079DEC','tdGoogleTextColorBtn',4,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center">
                                                            <tr>
                                                                <td width="25" height="25" bgcolor="#079DEC">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn5" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#1234AB','tdGoogleTextColorBtn',5,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#1234AB">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn6" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','red','tdGoogleTextColorBtn',6,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="red">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn7" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#FF7700','tdGoogleTextColorBtn',7,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FF7700">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn8" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#FFDD00','tdGoogleTextColorBtn',8,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#FFDD00">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn9" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#33AA22','tdGoogleTextColorBtn',9,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#33AA22">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="35" height="35" id="tdGoogleTextColorBtn10" class="clsTextColorBtn" onclick="onChangeTextColor('spGooglePreviewText','#BB33AA','tdGoogleTextColorBtn',10,'hdGoogleTextColorIndex');">
                                                        <table cellpadding="0" cellspacing="0" align="center" bgcolor="#BB33AA">
                                                            <tr>
                                                                <td width="25" height="25">
                                                                    &nbsp;
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trNorGoogleMode">
                                        <td width="115" height="10" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Preview
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="61" align="left" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="316">
                                                <tr>
                                                    <td width="180" height="47" valign="top">
                                                        <table id="tblGooglePreviewBtn" cellpadding="0" cellspacing="0" align="center" style="border-collapse: collapse;"
                                                            bgcolor="#F7F7F7" width="169">
                                                            <tr>
                                                                <td width="167" height="35" align="left" style="border-width: 1px; border-color: rgb(187,187,187);
                                                                    border-style: solid;">
                                                                    <table cellpadding="0" cellspacing="0" width="159">
                                                                        <tr>
                                                                            <td width="35" height="27" align="right">
                                                                                <img src="img/cam_icon05.png" width="19" height="19" border="0">
                                                                            </td>
                                                                            <td width="124" height="27" align="center">
                                                                                <b><font face="돋움"><span style="font-size: 10pt; color: #8C959A;" id="spGooglePreviewText">Google Map</span></font></b>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td width="136" height="47">
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr class="trCustomGoogleMode">
                                        <td height="25">
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr class="trCustomGoogleMode">
                                        <td width="115" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0" width="105" align="center">
                                                <tr>
                                                    <td width="105" height="32" align="center" class="clsTitleLabel">
                                                        Upload
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td width="361" height="65" valign="top">
                                            <table cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td width="367" height="32">
                                                        <input id="googlebtn_path" type="file" name="googlebtn_path" accept="image/jpeg, image/png"
                                                            class="clsBrowser" size="30">
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td width="500" height="45" align="right" style="border-width: 1px; border-top-color: rgb(229,233,235);
                                border-right-color: black; border-bottom-color: black; border-left-color: black;
                                border-style: none;">
                                <table cellpadding="0" cellspacing="0" align="center" width="466">
                                    <tr>
                                        <td width="466" height="44" align="right">
                                            <input type="hidden" id="hdGoogleColorIndex" value="1" />
                                            <input type="hidden" id="hdGoogleTextColorIndex" value="1" />
                                            <input type="hidden" id="hdGoogleModeIndex" value="1" />
                                            <input type="button" id="Button4" onclick="OnGoogleMapApply()" class="clsButton"
                                                value="Apply" style="font-weight: bold; width: 124px; height: 30px;" />
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td height="33">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvMarkerRegistered" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="592" align="center" background="img/10_popup/pop_bg_small.png">
            <tr>
                <td width="592" height="286">
                    <p>&nbsp;</p>
                    <table cellpadding="0" cellspacing="0" width="402" align="center">
                        <tr>
                            <td width="402" height="100">
                                <p><font face="돋움" color="#848484"><span style="font-size:11pt;"><b>Successful registeration marker.</b></span></font></p>
                                <p><font face="돋움" color="#848484"><span style="font-size:11pt;"><b>Please register object when you saved marker.</b></span></font></p>
                            </td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" width="253" align="center">
                        <tr>
                            <td width="253" height="76">
                                <p align="center"><a onclick="onClickMarkerReg();" onmouseout="na_restore_img_src('image15', 'document')" onmouseover="na_change_img_src('image15', 'document', 'img/04_studio_2/studio_2 (7)_r.png', true)"><img src="img/04_studio_2/studio_2 (7).png" width="107" height="32" border="0" name="image15"></a></p>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="dvTooLargeObject" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="592" align="center" background="img/10_popup/pop_bg_small.png">
            <tr>
                <td width="592" height="286">
                    <p>&nbsp;</p>
                    <table cellpadding="0" cellspacing="0" width="402" align="center">
                        <tr>
                            <td width="402" height="92">
                                <p align="center"><font face="돋움" color="#848484"><span style="font-size:11pt;"><b>You cannot register object more than 100MB size.</b></span></font></p>
                            </td>
                        </tr>
                     </table>
                     <table cellpadding="0" cellspacing="0" width="253" align="center">
                        <tr>
                            <td width="253" height="76">
                                <p align="center"><a onclick="hidePopup();" onmouseout="na_restore_img_src('image2', 'document')" onmouseover="na_change_img_src('image2', 'document', 'img/04_studio_2/studio_2 (7)_r.png', true)"><img src="img/04_studio_2/studio_2 (7).png" width="107" height="32" border="0" name="image2"></a></p>
                            </td>
                        </tr>
                     </table>
                </td>
            </tr>
        </table>
    </div>

    <div id="progressUpload" class="clspopup" style="width:100%; height:100%; opacity:0.8; z-index:4000; background-color:#000000">
        <table cellpadding="0" cellspacing="0" style="width:100%; height:100%" align="center" >
            <tr>
                <td align="center">
                    <img src="img/ajax-loader.gif" />
                    <h1 style="color:#ffffff">Now anlayzing and loading image. Please wait a minute.</h1>
                </td>                
            </tr>
        </table>
    </div>
    <div id="progressUploadVideo" class="clspopup" style="width:100%; height:100%; opacity:0.8; z-index:4000; background-color:#000000">
        <table cellpadding="0" cellspacing="0" style="width:100%; height:100%" align="center" >
            <tr>
                <td align="center">
                    <img src="img/ajax-loader.gif" />
                    <h1 style="color:#ffffff">Now uploading videofile. Please wait a minute.</h1>
                </td>                
            </tr>
        </table>
    </div>

    <div id="dvGMap" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="450" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="450">
                                <table>
                                    <tr>
                                        <td width="50%">
                                            <p align="center"><b><span style="font-size:13pt;"><font face="돋움" color="#666666">Register GoogleMap</font></span></b></p>
                                        </td>
                                        <td  width="50%">
                                            <input id="latlng" type="text" value="40.714224,-73.961452" style="height:22px;width:155px;padding-left:75px" />
                                        </td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" align="center" width="514" height="350">
                                    <tbody><tr>
                                        <td width="514" height="350">
                                            <div style="width:514;height:350" id="map"></div>
                                            <script src= "script.js" type="text/javascript"></script>
                                            <script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDmd-eb-yFdxMmJFm165liceg2qTnLwjDg&callback=initMap">
                                            </script>                                                                            
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
                                            <p align="center"><a style="cursor: pointer;" onclick="onSaveGMap()" >
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

    <div id="dvSelType" class="clspopup">
        <table cellpadding="0" cellspacing="0" width="550" align="center">
            <tbody><tr>
                <td width="550" height="10" bgcolor="#5D81EC"></td>
            </tr>
            <tr>
                <td width="550" height="199" bgcolor="white">
                    <table cellpadding="0" cellspacing="0" width="514" align="center">
                        <tbody><tr>
                            <td width="514" height="114">
                                <table>
                                    <tr>
                                        <td style="padding-left:100px">
                                            <p align="center"><b><span style="font-size:13pt;"><font face="돋움" color="#666666">Select VI Type</font></span></b></p>
                                        </td>
                                        <td style="padding-left:50px" width="100" height="30">
                                            <asp:Literal ID="select_type" runat="server" Text=""></asp:Literal>
                                        </td>
                                    </tr>
                                </table>
                                <div id="show_Type_content">
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td width="514" height="49">
                                <table cellpadding="0" cellspacing="0" align="center" width="290">
                                    <tbody><tr>
                                        <td width="290" height="36">
                                            <p align="center"><a style="cursor: pointer;" onclick="onSelTypeOK()" >
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
