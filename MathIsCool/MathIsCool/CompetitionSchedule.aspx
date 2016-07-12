<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompetitionSchedule.aspx.cs" Inherits="MathIsCool.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#aabcfe;margin:0px auto;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aabcfe;color:#669;background-color:#e8edff;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#aabcfe;color:#039;background-color:#b9c9fe;}
.tg .tg-baqh{text-align:center;vertical-align:top}
.tg .tg-mb3i{text-align:left;vertical-align:top}
.tg .tg-lqy6{text-align:right;vertical-align:top}
.tg .tg-6k2t{background-color:#D2E4FC;vertical-align:top}
.tg .tg-yw4l{vertical-align:top}
</style>
<table class="tg">

  <tr>
    <td class="tg-6k2t"></td>
    <td class="tg-6k2t">Grade 4</td>
    <td class="tg-6k2t">Grade 5</td>
    <td class="tg-6k2t">Grade 6</td>
    <td class="tg-6k2t">Grade 7</td>
    <td class="tg-6k2t">Grade 8</td>
    <td class="tg-6k2t">Grade 9/10</td>
    <td class="tg-6k2t">Grade 11/12</td>
  </tr>
  <tr>
    <td class="tg-mb3i">Spokane - East</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
  </tr>
  <tr>
    <td class="tg-mb3i">Spokane - West</td>
    <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
  </tr>
  <tr>
    <td class="tg-mb3i">Coeur d'Alene</td>
    <td class="tg-yw4l">April 8, 2016</td>
      <td class="tg-yw4l">April 8, 2016</td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
  </tr>
    <tr>
    <td class="tg-mb3i">Wenatchee</td>
    <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
  </tr>
    <tr>
    <td class="tg-mb3i">Tri-Cities</td>
    <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l">April 15, 2016</td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
      <td class="tg-yw4l"></td>
  </tr>
    <tr>
    <td class="tg-mb3i">Seattle</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
  </tr>
    <tr>
    <td class="tg-mb3i">Vancouver</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
    <td class="tg-yw4l">April 15, 2016</td>
  </tr>
    <tr>
    <td class="tg-mb3i">MASTERS</td>
    <td class="tg-yw4l">May 21, 2016</td>
    <td class="tg-yw4l">May 21, 2016</td>
    <td class="tg-yw4l">May 21, 2016</td>
    <td class="tg-yw4l">May 21, 2016</td>
    <td class="tg-yw4l">May 21, 2016</td>
    <td class="tg-yw4l">May 21, 2016</td>
    <td class="tg-yw4l">May 21, 2016</td>
  </tr>
</table>

    <style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border:none;margin:0px auto;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:0px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:0px;overflow:hidden;word-break:normal;}
.tg .tg-yw41{vertical-align:top}
.tg .tg-amwm{font-weight:bold;text-align:center;vertical-align:top}
</style>
<table class="tg">
  <tr>
    <th class="tg-031e">Grade 4 - Seattle</th>
    <th class="tg-yw4l">April 15, 2016</th>
    <th class="tg-yw4l">Registration Deadline: March 18, 2016</th>
  </tr>
  <tr>
    <td class="tg-yw4l">Location:</td>
    <td class="tg-yw4l">Mount Rainier High School, 22450 19th Ave S, Des Moines, WA 98198</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l">Director:</td>
    <td class="tg-yw4l">Tom Tosch</td>
    <td class="tg-yw4l">seattle@academicsarecool.com</td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l">Comments:</td>
    <td class="tg-yw4l">Whatever the director wrote on the competition page.</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l">Schedule:</td>
    <td class="tg-amwm">Schedule of Events</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">3:00 - 3:30               Coaches Registration - Room 2701</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">3:40 - 3:50               Orientation - Gym</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">3:50 - 3:55               Students to testing rooms</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">4:05 - 4:15               Mental Math (8 questions for each student)</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">4:10                         Coaches Room 2701</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">4:20 - 4:55               Individual Test (40 questions)</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">5:05 - 5:20               Team Multiple Choice (10 questions)</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">5:25 - 5:40               Team Test (Fill in the blank 10 questions)</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">5:45 - 5:50               Practice Relay</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">5:50 - 5:55                Relay #1</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">5:55 - 6:00                Relay #2</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">6:00 - 6:40                Snack/Dinner Break</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">6:45 - 7:05                College Bowl Set 1/2 (10 Questions)</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">7:05 - 7:25                College Bowl Set 3/4</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">7:25 - 7:45                College Bowl Set 5/6</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l"></td>
    <td class="tg-yw4l">7:55                          Awards Ceremony - Gym</td>
    <td class="tg-yw4l"></td>
  </tr>
  <tr>
    <td class="tg-yw4l">Schools Registered:</td>
    <td class="tg-yw4l">??????</td>
    <td class="tg-yw4l"></td>
  </tr>
</table>
    
</asp:Content>
