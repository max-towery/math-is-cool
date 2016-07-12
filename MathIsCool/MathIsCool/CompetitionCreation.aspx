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
        var Schedule;
        var CompetitionName;
        var TCount;
        var CompDay;
        var CompMonth;
        var CompYear;
        var CurrYear = new Date().getFullYear;


        $(document).ready(function () {
            // Send an AJAX request
            $.ajax({
                url: uri,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    debugger;
                    var list = document.getElementById("MainContent_SelRegion");
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
                   // alert("Error calling API: " + uri + " " + x + " " + y + " " + z);
                }
            });

            $.ajax({
                url: uri2,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                    debugger;
                    var list = document.getElementById("MainContent_SelLevel");
                    for (var i = 0; i < data.length; i++) {
                        var option = document.createElement("option");
                        var text = document.createTextNode(data[i].value);
                        option.appendChild(text);
                        LevelArray[i] = data[i].id;
                        LevelValArray[i] = data[i].value;
                        option.value = data[i].value;
                        list.appendChild(option);
                    }
                },
                error: function (x, y, z) {
                    //alert("Error calling API: " + uri + " " + x + " " + y + " " + z);
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
                            <label class="control-label" for="MainContent_SelRegion">Region</label>
                            <select class="form-control" id="SelRegion" runat="server">
                                <option>Select Region</option>
                            </select>
                        </div>

                        <div class="col-lg-6">
                            <label class="control-label" for="MainContent_SelLoc">Location</label>
                            <select class="form-control" id="SelLoc" runat="server">
                                <option>Select School</option>
                            </select>
                        </div>
                    </div>
                                        
                    <div class="row">
                        <div class="col-lg-6">
                            <label class="control-label" for="DD_Locations">Level</label>
                            <select class="form-control" id="SelLevel" runat="server">
                                <option>Select Comp Level</option>
                            </select>
                        </div>                        
                    </div>
                    <div class="row">
                        <div class="col-lg-6">
                        <label class="control-label" for="MainContent_SelTeams">Number of Teams Allowed per School</label>
                        <select class="form-control" id="SelTeams" runat="server">   
                            <option>1</option>
                            <option>2</option>
                            <option>3</option>
                            <option>4</option>
                            <option>5</option>
                            </select>
                        </div>
                    </div>                                  
                    <label>Competition Name</label>
                    <textarea id="CompName" runat="server" class="form-control" rows="1">
                    </textarea>
                </div>

            </div>

           <div class="col-lg-6">
              <div class="row">
                  <label>Competition Date</label></div> 
                        <label class="control-label" for="MainContent_Month">Month</label>
                        <select class="form-control" id="SelMonth" runat="server">   
                            <option>January</option>
                            <option>February</option>
                            <option>March</option>
                            <option>April</option>
                            <option>May</option>
                            <option>June</option>
                            <option>July</option>
                            <option>August</option>
                            <option>September</option>
                            <option>October</option>
                            <option>November</option>
                            <option>December</option>
                            </select>
               <div class="row">
                   <label class="control-label" for="MainContent_SelDate">Date</label>
                            <select class="form-control" id="SelDate" runat="server">
                                <option>1</option>
                                <option>2</option>
                                <option>3</option>
                                <option>4</option>
                                <option>5</option>
                                <option>6</option>
                                <option>7</option>
                                <option>8</option>
                                <option>9</option>
                                <option>10</option>
                                <option>11</option>
                                <option>12</option>
                                <option>13</option>
                                <option>14</option>
                                <option>15</option>
                                <option>16</option>
                                <option>17</option>
                                <option>18</option>
                                <option>19</option>
                                <option>20</option>
                                <option>21</option>
                                <option>22</option>
                                <option>23</option>
                                <option>24</option>
                                <option>25</option>
                                <option>26</option>
                                <option>27</option>
                                <option>28</option>
                                <option>29</option>
                                <option>30</option>
                                <option>31</option>
                            </select>
               </div>
               <div class="row">

                  
               </div>
         </div>
                
        <div class="col-lg-5 col-md-5 col-sm-12 ">
                   <label>Extra Notes</label>
                    <textarea id="Note" runat="server" class="form-control" rows="2">
                    </textarea>
        </div>

        <div class="row">
                <div class="col-md-12">
                <textarea rows="8" cols ="50" id="Sched" runat="server">
4:00pm
5:00pm
6:00pm
7:00pm
8:00pm
                </textarea>                          
                </div>
        </div>        


        <div class="row">
            <div class="col-md-12">
                  <asp:Button ID="CrtComp" runat="server" OnClick="btn_CrtComp_Click" Text="Create Comp" class="btn btn-primary text-center"  />
                  <br />
                  <br />
            </div>
        </div>

            </div>

    <input id="Region" type="hidden" runat="server" />
    <input id="Location" type="hidden" runat="server" />
    <input id="Level" type="hidden" runat="server" />
    <input id="TeamCount" type="hidden" runat="server" />
    <input id="CName" type="hidden" runat="server" />
    <input id="CDay" type="hidden" runat="server" />
    <input id="CMonth" type="hidden" runat="server" />
    <input id="CYear" type="hidden" runat="server" />  
    <input id="CSched" type="hidden" runat="server" />                
    
    <script>
        function SetPostbackValues() {
            var Region = '<%= Region.ClientID %>';
            document.getElementById(Region).value = RegID;

            var Location = '<%= Location.ClientID %>';
            document.getElementById(Location).value = LocID;

            var Level = '<%= Level.ClientID %>';
            document.getElementById(Level).value = LevID;

            var TeamCount = '<%= TeamCount.ClientID %>';
            document.getElementById(TeamCount).value = TCount;
            
            var Cname = '<%= CName.ClientID %>';
            document.getElementById(CName).value = CompetitionName;

            var CDay = '<%= CDay.ClientID %>';
            document.getElementById(CDay).value = CompDay;

            var CMonth = '<%= CMonth.ClientID %>';
            document.getElementById(CMonth).value = CompMonth;

            var CYear = '<%= CYear.ClientID %>';
            document.getElementById(CYear).value = CompYear;
            }

        $("#MainContent_SelRegion").change(function () {
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
            SetPostbackValues();
        });

        $("#MainContent_SelLoc").change(function () {
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
            SetPostbackValues();
        });

        $("#MainContent_SelLevel").change(function () {
            var selectedText = $(this).find("option:selected").text();
            var index = 0;
            var x = 0;
            for (var i = 0; i < LevelValArray.length; i++) {
                if (selectedText == LevelValArray[i]) {
                    index = x;
                    var Gu = LevelArray[index];
                    LevID = Gu;
                }
                else
                    x++;
            }
            SetPostbackValues();
        });

        $("#MainContent_SelTeams").change(function () {
            var selectedText = $(this).find("option:selected").text();
            TCount = selectedText;
            SetPostbackValues();
        });

        $("#MainContent_CompName").change(function () {
            var selectedText = $(this).find("option:selected").text();
            CompetitionName = selectedText;
            SetPostbackValues();
        });

        $("#MainContent_SelMonth").change(function () {
            var selectedText = $(this).find("option:selected").text();
            CompMonth = selectedText;
            alert("comp month: " + CompMonth);
            SetPostbackValues();
        });

        $("#MainContent_SelDate").change(function () {
            var selectedText = $(this).find("option:selected").text();
            CompDay = selectedText;
            alert("comp day: " + CompDay);
            SetPostbackValues();
        });

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
            var uri = "api/Locations"
            $.ajax({
                url: uri,
                type: 'GET',
                dataType: 'json',
                success: function (data) {
                   debugger;
                   var LocList = document.getElementById("MainContent_SelLoc");

                   if (LocList.options.length > 1) {
                       for (i = 1; i < LocList.options.length; i++) {
                           LocList.options[i] = null;
                       }
             }        
                   for (var j = 0; j < data.length; j++) {
                       if (data[j].region_id == RegID) {
                           var LocOpt = document.createElement("option");
                           var LocTxt = document.createTextNode(data[j].name);
                           LocOpt.appendChild(LocTxt);
                           LocateArray[j] = data[j].name;
                           LocGuidArray[j] = data[j].comp_loc_id;
                           LocOpt.value = data[j].name;
                           LocList.appendChild(LocOpt);    
                        }
                   }
                },
                error: function (x, y, z) {
                    alert("Error calling API: " + uri + " " + x + " " + y + " " + z);
                }
            });
        }

    </script>
</asp:Content>

