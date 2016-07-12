<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Locations.aspx.cs" Inherits="MathIsCool.Information_Pages.Locations" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="page-header">
      <h1>Locations</h1>
    </div>
    <div class="container body-content">
        <table class="table table-striped">
            <thead> 
                <tr> 
                    <th>Region</th> 
                    <th>High School</th> 
                    <th>7th/8th Grade</th> 
                    <th>6th Grade</th> 
                    <th>5th Grade</th> 
                    <th>4th Grade</th> 
                </tr> 
            </thead> 
            <tbody> 
                <tr> 
                    <th scope="row">Seattle</th> 
                    <td>Redmond H.S.</td> 
                    <td>Redmond H.S.</td> 
                    <td><a href="#MtRainier" onclick="focusSchool('MtRainier')">Mt. Rainier H.S.</a></td>
                    <td><a href="#MtRainier" onclick="focusSchool('MtRainier')">Mt. Rainier H.S.</a></td>
                    <td><a href="#MtRainier" onclick="focusSchool('MtRainier')">Mt. Rainier H.S.</a></td>
                </tr> 
                <tr> 
                    <th scope="row">Spokane - East</th> 
                    <td>Spokane Falls CC</td>
                    <td><a href="#MtSpokane" onclick="focusSchool('MtSpokane')">Mt. Spokane H.S.</a></td>
                    <td><a href="#MtSpokane" onclick="focusSchool('MtSpokane')">Mt. Spokane H.S.</a></td>
                    <td><a href="#MtSpokane" onclick="focusSchool('MtSpokane')">Mt. Spokane H.S.</a>.</td>
                    <td><a href="#MtSpokane" onclick="focusSchool('MtSpokane')">Mt. Spokane H.S.</a></td>
                </tr> 
                <tr> 
                    <th scope="row">Spokane - West</th> 
                    <td></td> 
                    <td>Whitworth Univ.</td> 
                    <td>St. George's School</td>
                    <td>Eastern Wash. Univ.</td>
                    <td>Whitworth Univ.</td>
                </tr> 
            </tbody> 
        </table>
    <br />
    <div id="MtSpokane" class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">Mount Spokane High School</h2>
          <p class="lead">6015 E. Mt. Spokane Park Dr.
            Spokane, WA
            99021
          </p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive center-block" src="/images/mtSpokaneHS.jpg" alt="500x500" data-holder-rendered="true">
        </div>
      </div>
    <div id="MtRainier" class="row featurette">
        <div class="col-md-7 col-md-push-5">
          <h2 class="featurette-heading">Mount Rainier High School <span class="text-muted"></span></h2>
          <p class="lead">22450 19th Ave S 
            Des Moines, WA
          </p>
        </div>
        <div class="col-md-5 col-md-pull-7">
          <img class="featurette-image img-responsive center-block" src="/images/mtRainierHS.jpg" alt="500x500" data-holder-rendered="true">
        </div>
      </div>
        <div class="row featurette">
        <div class="col-md-7" >
          <h2 class="featurette-heading">Moses Lake High School<span class="text-muted"></span></h2>
          <p class="lead">803 E. Sharon Avenue
            Moses Lake, WA
            98837
          </p>
        </div>
        <div class="col-md-5 ">
          <img class="featurette-image img-responsive center-block" src="/images/mosesLakeHS.jpg" alt="500x500" data-holder-rendered="true">
        </div>
      </div>
</div>
<script>
    function focusSchool(loc) {
        window.location = '#' + loc;
    }
</script>
</asp:Content>
