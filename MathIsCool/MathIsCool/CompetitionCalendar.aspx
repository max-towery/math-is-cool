<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompetitionCalendar.aspx.cs" Inherits="MathIsCool.CompetitionCalendar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src='./fullcalendar/lib/jquery.min.js'></script>
    <script src='./fullcalendar/lib/moment.min.js'></script>
    <script src='./fullcalendar/fullcalendar.min.js'></script>
    <link rel='stylesheet' href='./fullcalendar/fullcalendar.css' />
    <link rel='stylesheet' href='./fullcalendar/lib/cupertino/jquery-ui.min.css' />
  

 
<script src="http://code.jquery.com/ui/1.11.1/jquery-ui.min.js"></script>

    <script>

        
     
        function setup(){
            $('#calendar').fullCalendar({
                //if a user clicks on an event, do some things...
                eventClick: function(event){
                    
                  
                    $("#eventContent").dialog({
                        modal: true,
                        title: event.title,
                       
                        draggable: false,
                        resizable: false,
                        width: 600,
                        open: function(){
                        jQuery('.u  i-widget-overlay').bind('click',function(){
                            jQuery('#eventContent').dialog('close');
                        })
                        }
                    
                    });
                   
                    $("#eventContent").html("<table>" +
                 
                                                "<tr><td style='padding: 0 15px;'><strong>Address: </td><td style='padding: 0 55px;'>" + event['street'] + "</td>" + "</tr>" +
                                                "<tr><td style='padding: 0 15px;'></td><td style='padding: 0 55px;'>" + event['city'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'></td><td style='padding: 0 55px;'>" + event['state'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'></td><td style='padding: 0 55px;'>" + event['zip'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'><strong>Schedule: </td><td style='padding: 0 55px;'>" + event['schedule'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'><strong>Status: </td><td style='padding: 0 55px;'>" + event['status'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'><strong>Region: </td><td style='padding: 0 55px;'>" + event['region'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'><strong>Location: </td><td style='padding: 0 55px;'>" + event['loc_name'] + "</td></tr>" +                                                               
                                                "<tr><td style='padding: 0 15px;'><strong>Max Teams Allowed: </td><td style='padding: 0 55px;'>" + event['total_teams_allowed'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'><strong>Max Teams Per School: </td><td style='padding: 0 55px;'>" + event['team_limit'] + "</td></tr>" +
                                                "<tr><td style='padding: 0 15px;'><strong>Max Students Per Team: </td><td style='padding: 0 55px;'>" + event['student_limit'] + "</td></tr>" +
                                            "</table>");
                    
                    
                },
                theme: true,
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,agendaWeek,agendaDay'
                },
                defaultDate: '2016-01-12',
                editable: true,

                eventLimit: true, // allow "more" link when too many events
                

            });

            addEvent();
            $("#calendar").fullCalendar('today');
        }
        $(document).ready(setup);

        //dynamically add an event to the competition Calendar
        function addEvent(){

            $.get("/api/CompetitionCalendar", {}, gotList, "json");
         
        }

        
        //id of the competition corresponds to the index of the array

        var events = new Array();
        function gotList(dt) {
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
                
               
              
                events[i] = event;
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
                $('#calendar').fullCalendar('renderEvent', event, true);
            }
                    
        }

        function switchMode() {
            window.location.href = "CompSchedule";
            
        
        }

    </script>
    <br />
    <input type="button" value="Switch to Schedule Mode" id="mode" onclick="switchMode()" class="btn"/>
    <div class="container">
        <div class="row">
    <br />
    <h1>Competition Calendar</h1>
    <br/>
    <br/>
<div id='calendar'></div>
<br />
<div id="eventContent" title="Event Details">
    <div id="eventInfo"></div>
</div>
        </div>
    </div>
    <style>
        .btn{
            background-color: #247611;
            border: none;
            color: white;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
    </style>
</asp:Content>
