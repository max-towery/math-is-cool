<%@ Page Title="News" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="MathIsCool.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <script src="//cdn.ckeditor.com/4.5.9/full/ckeditor.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <br />
    <p>
          
        <% if (System.Web.HttpContext.Current.User.IsInRole("Administrator")) {%>
            <input onclick="createEditor();" type="button" value="Edit Contents" class="btn"/>
            <input onclick="removeEditor();" type="button" value="Finish Editing" class="btn"/>                               
        <% } %>
        
      
        
    </p>
    <!-- This div will hold the editor. -->
    <div id="editor">
    </div>
    <div id="contents" >
        <p class="text-center" id="editorcontents"></p>
    </div>

    <script type="text/javascript">
        //create the AJAX PUT wrapper
        $.put = function (url, data, callback, type) {
            if ($.isFunction(data)) {
                type = type || callback,
                        callback = data,
                        data = {}
            }
            return $.ajax({
                url: url,
                type: 'PUT',
                success: callback,
                data: data,
                contentType: type
            });
        }

        var editor;
        var text;

        function createEditor() {
            $("#editor").show();
            //if the editor is already initialized, destroy it first
            if (editor) {
                return;
            }
            CKEDITOR.editorConfig = function (config) {
                config.autoParagraph = false;
                config.enterMode = CKEDITOR.ENTER_BR;
            };
            var html = document.getElementById('editorcontents').innerHTML;

            ;
            // Create a new editor inside the <div id="editor">, setting its value to html
            var config = {};
            if (text == null) {
                editor = CKEDITOR.appendTo('editor', config, html);
                console.log("text was null");
            }
            else {
                editor = CKEDITOR.appendTo('editor', config, text);
            }
        }

        function removeEditor() {
            if (!editor)
                return;

            // Retrieve the editor contents. In an Ajax application, this data would be
            // sent to the server or used in any other way.
         
            document.getElementById('editorcontents').innerHTML = editor.getData();
            document.getElementById('contents').style.display = '';
            data = {
                "type": "about",
                "description": editor.getData()
            };
            
            window.onload = function () {
                document.getElementById('editorcontents').outerHTML = editor.getData();
            }

              $.put("http://maxtowery.net/mic/api_static_pages.php", data, updateList, "json");
            
           
            editor.destroy();
            editor = null;

            text = null;
        }
        function updateList(dt) {
        }
        function gotList(dt) {
            text = dt[0]["description"];
            createEditor();

            document.getElementById('editorcontents').innerHTML = editor.getData();
            $("#editor").hide();
        }

        function loadData() {
            
           
            $.get("http://maxtowery.net/mic/api_static_pages.php?type=about", {}, gotList, "json");

        }
        function setup() {

            loadData();
        }

        $(document).ready(setup);


    </script>

    
    <!-- Custom CSS -->
    <link href="about_theme/css/round-about.css" rel="stylesheet">



    <!-- Page Content -->
    <div class="container">

       
        <!-- Team Members Row -->
        <div class="row">
            <div class="col-lg-12">
                <h2 class="page-header">Our Team</h2>
            </div>
            <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" src="about_theme/img/tom.jpg" alt="">
                <h3>Tom Tosch
                    <small>Seattle Contact</small>
                </h3>
                <p>Mount Rainer High School<br>
					19465 Marine View Dr. SW <br>
					Normandy Park, WA <br>
					98166 <br>
					email: seattle@academicsarecool.com
				</p>
				
            </div>
            <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" src="about_theme/img/annie_bouscal.jpg" alt="">
                <h3>Annie Bouscal
                    <small>Registration Contact</small>
                </h3>
                <p>Annie Bouscal <br>
				   2447 Pierre Lake Road<br>
				   Kettle Falls, WA<br>
				   99141 <br>
				   phone: 509.738.7000</p>
            </div>
            <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" src="about_theme/img/triscia.jpg" alt="">
                <h3>Triscia Hochstatter
                    <small>Moses Lake Contact</small>
                </h3>
                <p>Moses Lake High School <br>
				   803 E. Sharon Avenue <br>
				   Moses Lake, WA <br>
				   98837 <br>
				   phone: 509.766.2650 ext. 2780</p>
            </div>
            <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" src="about_theme/img/placeholder.png" alt="">
                <h3>Gregg Sampson
                    <small>Spokane Contact</small>
                </h3>
                <p>email: spokane@academicsarecool.com</p>
            </div>
            <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" src="about_theme/img/placeholder.png" alt="">
                <h3>Chris Johnson
                    <small>Tri-Cities Contact</small>
                </h3>
                <p>email: richland@academicsarecool.com</p>
            </div>
            <div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" src="about_theme/img/placeholder.png" alt="">
                <h3>Mary Kulas Nordt
                    <small>Wenatchee Contact</small>
                </h3>
                <p>phone: 509.470.2037<br>
				   email: wenatchee@academicsarecool.com</p>
            </div>
			<div class="col-lg-4 col-sm-6 text-center">
                <img class="img-circle img-responsive img-center" src="about_theme/img/placeholder.png" alt="">
                <h3>Mahen Malixi
                    <small>Vancouver Contact</small>
                </h3>
                <p>email: vancounver@academicsarecool.com</p>
            </div>
        </div>

        <hr>


      

    </div>
    <!-- /.container -->
    <style>
        .btn{
            background-color: #247611;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
        }
    </style>
    

    

</asp:Content>
