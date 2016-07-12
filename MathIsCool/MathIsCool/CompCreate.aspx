<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompCreate.aspx.cs" Inherits="MathIsCool.CompCreate" %>
<asp:Content ID="MainBody" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        var uri = '/api/Regions';
        var regionArray = [];
        var RegGuidArray = [];
        var RegID;

        $(document).ready(function () {
            // Send an AJAX request
            $.ajax({
                url: uri,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    debugger;
                    var list = document.getElementById("SelectRegion");
                    for (var i = 0; i < data.length; i++) {
                        var option = document.createElement("option");
                        var text = document.createTextNode(data[i].region_name);
                        option.appendChild(text);
                        regionArray[i] = data[i].region_name;
                        RegGuidArray[i] = data[i].region_id;
                        option.value = data[i].region_name;
                        list.appendChild(option);
                    }
                },
                error: function (x, y, z) {
                    alert("Error calling API: " + uri + " " + x + " " + y + " " + z);
                }
            });
        });


    </script>

    <div class="row">
        <h2>Create Competition</h2>
    </div>

    <div class="row">            
            <div class="col-lg-5 col-md-5 col-sm-12 col-md-offset-1">
                <div class="form-group">
                    <div class="row">
                        <textarea rows="8" cols ="50" id="Sched">
4:00pm
5:00pm
6:00pm
7:00pm
8:00pm
                                </textarea>        
                     </div>
                    <div class="row">
                       <input class="btn btn-default" type="button" value="Save" onclick="SaveSched()"/>
                    </div>
                </div>
            </div>
        </div>
    <script>
        $("SaveButtton").click(function () {

            alert("before show modal");

        });

        function SaveSched() {
            alert("Pop up");
            var CompSched = Sched.textContent;
            alert("saved schedule: " + CompSched);
        }

    </script>

</asp:Content>
