<%@ Page Title="Competition Schedule" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompSchedule.aspx.cs" Inherits="MathIsCool.CompSchedule" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>

    <script>
        function setup(){
            addEvent();
            
        }
        $(document).ready(setup);

        //Added this to check commits

        //dynamically add an event to the competition Calendar
        function addEvent(){

            $.get("/api/CompetitionCalendar", {}, gotEventInfo, "json");
            
            
        }


        var levels = new Array();
        function gotLevels(dt) {
            
            for (i = 0; i < dt.length; i++) {
                var level = dt[i]['value'];
               
                levels[i] = level;
               
            }

            
            buildTable2();

        }

        

        
        

        var regions = new Array();
        function gotRegions(dt) {
            
            for (i = 0; i < dt.length; i++) {
                var region_name = dt[i]['region_name'];
                regions[i] = region_name;
                
            }

            $.get("/api/CompetitionLevels", {}, gotLevels, "json");

        }



        var events = new Array();
        function gotEventInfo(dt) {
            for (i = 0; i < dt.length; i++) {
                var num = i;
                var name = dt[i]['level'];
                var date = dt[i]['date'];
                var street = dt[i]['street'];
                var city = dt[i]['city'];
                var state = dt[i]['state'];
                var zip = dt[i]['zip'];
                var schedule = dt[i]['schedule'];
                var status = dt[i]['status'];
                var region = dt[i]['region_name'];
                var comp_name = dt[i]['comp_name'];
                var loc_name = dt[i]['loc_name'];
                var student_limit = dt[i]['stu_limit'];
                var team_limit = dt[i]['team_limit'];
                var total_teams_allowed = dt[i]['total_teams_allowed'];
                var phone = dt[i]['phone'];
                var ext = dt[i]['ext'];
                var note = dt[i]['note'];
                 
                var event = {
                    id: num,
                    title: comp_name,
                    start: date,
                    level: name,
                    street: street,
                    city: city,
                    state: state,
                    zip: zip,
                    schedule: schedule,
                    status: status,
                    region: region,
                    loc_name: loc_name,
                    student_limit: student_limit,
                    total_teams_allowed: total_teams_allowed,
                    phone: phone,
                    ext: ext,
                    note: note

                };
                events[i] = event;
              //  console.log(event);
                
            }
            $.get("/api/Regions", {}, gotRegions, "json");
                    
        }

        var table2d;
        var event2d;
        

        function buildTable2() {
            table2d = new Array(regions.length);
            event2d = new Array(regions.length);
            //build the 2d table array first
            for (i = 0; i < regions.length; i++) {
                table2d[i] = new Array(levels.length);
                event2d[i] = new Array(levels.length);
                for (k = 0; k < levels.length; k++) {
                    //add values to table
                    table2d[i][k] = regions[i] + " " + levels[k];
                }
            }
            
            var text = table2d[0][0].indexOf("5th");
           // console.log(table2d[0][0]);
           // console.log(text);
          
            
    

            var table = document.getElementById("table1");
            //add first row that contains nothing in first cell
            var row = table.insertRow(0);
            var cell1 = row.insertCell(0);


            //levels (column headers)
            for (i = 1; i < levels.length + 1; i++) {
                var cell = row.insertCell(i);
                cell.innerHTML = "<strong>" + levels[i - 1];
                
            }
            //regions (row headers)
            for (i = 1; i < regions.length + 1; i++) {
                var row = table.insertRow(i);
                var cell = row.insertCell(0);
                cell.innerHTML = "<strong>" + regions[i - 1];
                
                //date values contained in the table
                for (j = 1; j < levels.length + 1; j++) {
                    var cell = row.insertCell(j);

                }
            }
            //after html table built and 2d array built, compare values in events to values in 2d array
            //and add events to the html table

            for (i = 0; i < regions.length; i++) {
                for (j = 0; j < levels.length; j++) {
                    var cellText = table2d[i][j];
                    for (k = 0; k < events.length; k++) {
                        var levelFound = cellText.indexOf(events[k]['level']);
                        var regionFound = cellText.indexOf(events[k]['region']);
                        if (levelFound > -1 && regionFound > -1) {
                            //console.log("cell match at: " + i + " " + j);
                            var row = document.getElementById("table1").rows[i + 1].cells;
                            var date = new Date(events[k]['start']);
                            var dateFormatted = (date.getMonth() + 1) + '-' + date.getDate() + '-' + date.getFullYear();
                            var id = i + " " + j;
                            
                            row[j + 1].innerHTML = "<input type='button' id=" + id + " value="+ dateFormatted + " name="+ events[k]['start'] +" onclick=dialog(name) >";
                            event2d[i][j] = events[k];
                            
                        }
                    }
                }
            }

        }

        function dialog(id) {
            
            for (i = 0; i < events.length; i++) {
                if (id == events[i]['start']) {
                    console.log(events[i]);
                    //found the corret event, now display the information for it

                    $("#eventContent").html("<table>" +

                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Address: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['street'] + "</td>" + "</tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'></td><td class='td1' style='padding: 0 55px;'>" + events[i]['city'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'></td><td class='td1' style='padding: 0 55px;'>" + events[i]['state'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'></td><td class='td1' style='padding: 0 55px;'>" + events[i]['zip'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Schedule: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['schedule'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Status: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['status'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Region: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['region'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Location: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['loc_name'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Max Teams Allowed: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['total_teams_allowed'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Max Teams Per School: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['team_limit'] + "</td></tr>" +
                                                "<tr><td class='td1' style='padding: 0 15px;'><strong>Max Students Per Team: </td><td class='td1' style='padding: 0 55px;'>" + events[i]['student_limit'] + "</td></tr>" +
                                            "</table>");


                }
            }

            

        }

        function switchMode() {
            
            window.location.href = "CompetitionCalendar";
          
        }

    </script>
    <br />
    <input type="button" value="Switch to Calendar Mode" id="mode" onclick="switchMode()" class="btn"/>
    <br />
    <h1 align="center">Competition Schedule</h1>
    
    <div='container' width ="50%">
        <table align="center" id="table1">
        </table>
        <br />
        <br />
        <table align="center" id="table2">
            
        </table>
        <div id="eventContent" title="Event Details" >
    </div>
    
    

    <style>
        table {
            border-collapse: collapse;
            border-spacing: 0;
            
            margin: 0px auto;
        }

        th, td {
            background-color: #E5EFF8;
            vertical-align: top;
            align-content: center;
            font-family: Arial, sans-serif;
            font-size: 14px;
            padding: 10px;
            border-style: solid;
            border-width: 1px;
            overflow: hidden;
            word-break: normal;
            border-color: #669;
           
        }
        .td1{
            background-color: #ffffff;
            border-color: #E5EFF8;
            border-style: hidden;
        }
        
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
