<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompetitionCreation.aspx.cs" Inherits="MathIsCool.CompetitionCreation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var uri = '/api/Regions';
        var uri2 = 'api/CompetitionLevels';
        var regionArray = [];
        var LevelArray = [];
        var LevelValArray = [];
        var RegGuidArray = [];
        var LocateArray = [];
        var LocGuidArray = [];
        var RegID;
        var LocID;
        var LevID;
        $(document).ready(function () {
            // Send an AJAX request
            $.ajax({
                url: uri,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    debugger;
                    var list = document.getElementById("SelRegion");
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

            $.ajax({
                url: uri2,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    debugger;
                    var list = document.getElementById("SelLevel");
                    for (var i = 0; i < data.length; i++) {
                        var option = document.createElement("option");
                        var text = document.createTextNode(data[i].value);
                        option.appendChild(text);
                        LevelArray[i] = data[i].id;
                        LevelValArray[i] = data[i].value;
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
                        <div class="col-lg-6">
                            <label class="control-label" for="DD_Regions">Region</label>
                            <select class="form-control" id="SelRegion">
                                <option>Select Region</option>
                            </select>
                        </div>

                        <div class="col-lg-6">
                            <label class="control-label" for="DD_Locations">Location</label>
                            <select class="form-control" id="SelLoc">
                                <option>Select School</option>
                            </select>
                        </div>
                    </div>
                                        
                    <div class="row">
                        <div class="col-lg-6">
                            <label class="control-label" for="DD_Locations">Level</label>
                            <select class="form-control" id="SelLevel">
                                <option>Select Comp Level</option>
                            </select>
                        </div>                        
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                            <label>Number of Teams Allowed per School</label>
                        </div>
                        <div class="col-lg-6" id="Dd_NumSchools">   
                            <select class="form-control">
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                            </select>
                        </div>
                    </div>                                  
                </div>
            </div>
            <div class="col-lg-5 col-md-5 col-sm-12 ">
                <div class="form-group">
                 <label>Date of Competition</label>        
                    <asp:TextBox ID="Txb_Date" runat="server" ReadOnly = "true"></asp:TextBox>
                    <img src="/images/calender.png" />
                </div>
            </div>
        </div>

        <div class="col-lg-5 col-md-5 col-sm-12 ">
                   <label>Extra Notes</label>
                    <textarea id="Note" class="form-control" rows="2">
                    </textarea>
        </div>

        <div class="row">
                <div class="col-md-12">
                    <button id="btnGenSchedule"  class="btn btn-primary text-center">Generate Generic Schedule</button>
                </div>
        </div>

        <div class="row">
                <div class="col-md-12">
                    <label for="exampleInputFile">Upload Schedule</label>
                    <input type="file" id="exampleInputFile"/>
                </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                  <button id="btnCrtComp"  class="btn btn-primary text-center" >Create Comp</button>
                  <br />
                  <br />
            </div>
        </div>

    <script>
        $("#SelRegion").change(function () {
            var selectedText = $(this).find("option:selected").text();
            var index = 0;
            var x = 0;
            for (var i = 0; i < regionArray.length; i++) {
                if (selectedText == regionArray[i]) {
                    index = x;
                    var Gu = RegGuidArray[index];
                    RegID = Gu; // This is the Region Guid
                    findCompLoc();
                }
                else
                    x++;
            }
        });

        $("#SelLoc").change(function () {
            var selectedText = $(this).find("option:selected").text();
            var index = 0;
            var x = 0;
            for (var i = 0; i < LocateArray.length; i++) {
                if (selectedText == LocateArray[i]) {
                    index = x;
                    var Gu = LocGuidArray[index];
                    LocID = Gu; // This is the Comp_Loc Guid
                    }
                else
                    x++;
            }
        });

        $("#SelLevel").change(function () {
            var selectedText = $(this).find("option:selected").text();
            var index = 0;
            var x = 0;
            for (var i = 0; i < LevelValArray.length; i++) {
                if (selectedText == LevelValArray[i]) {
                    index = x;
                    var Gu = LevelArray[index];
                    LevID = Gu; // This is the Comp_Loc Guid
                    alert("Found Level ID: " + LevID);
                }
                else
                    x++;
            }
        });

        $("#btnCrtComp").on("click", function () {
           /* alert("in Create Comp On Click");         
            createComp();
            
            function createComp() {
                var CompetitionsApiUrl = "/api/Competition";
                var CompLocGUID = LocID
                var CompGUID = guid();
                var userCompetition = {
                    comp_id: CompGUID,
                    comp_loc_id: CompLocGUID,                                                     
                    level_id: LevID,
                    status_id: 1,
                    team_limit: $("#Dd_NumSchool").val(),
                    note: $("#Note").val(),
                    date: $("#Txb_Date").val()
                };
    
                var competition = JSON.stringify(userCompetition);
    
                $.ajax({
                    type: "POST",
                    url: CompetitionsApiUrl + "?value=" + competition,
                    datatype: "json",
                    contentType: "application/json; charset=utf-8",
                    processData: true,
                    success: function (data, status, jqXHR) {
                        alert("Competition Entered into DB");
                    },
                    error: function (xhr) {
                        alert("Failed to enter Competition into DB " + xhr);
                    }
                });//end ajax
    
            }//end createComp
            */
        });//end onClick

        function guid() {
            function s4() {
                return Math.floor((1 + Math.random()) * 0x10000)
                  .toString(16)
                  .substring(1);
            }
            return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
              s4() + '-' + s4() + s4() + s4();
        }//end guid

        function findCompLoc() {
            var uri = "api//Locations/LocationByRegionID/?regionID="
            $.ajax({
                url: uri + RegID,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                   debugger;
                   var LocList = document.getElementById("SelLoc");
                   for (var j = 0; j < data.length; j++) {
                       var LocOpt = document.createElement("option");
                       var LocTxt = document.createTextNode(data[j].name);
                       LocOpt.appendChild(LocTxt);
                       LocateArray[j] = data[j].name;
                       LocGuidArray[j] = data[j].comp_loc_id;
                       LocOpt.value = data[j].name;
                       LocList.appendChild(LocOpt);
                   }
                },
                error: function (x, y, z) {
                    alert("Error calling API: " + uri + " " + x + " " + y + " " + z);
                }
            });
        }       
    </script>
</asp:Content>
