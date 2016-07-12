<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="MathIsCool._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="headerRow1" class="row">
        <div class="container ">
            <div class="col-md-8">
                <img class="img-responsive" src="/images/Long MIC Winners.jpg" alt=""/>
            </div>
            <div class="col-md-4">
                <h1>Math is Cool</h1>
                <p>Welcome to the Math Is Cool Website. Please feel free to look at passed tests and calender to help prepare you for the next competition.</p>
                <a class="btn btn-primary btn-lg" href="#">Learn More</a>
            </div>
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-lg-12">
            <div class="well well-sm text-center">
                <p id="quote">"Math is like going to the gym for your brain. It sharpens your mind." - <strong>Danica McKellar</strong></p>
            </div>
        </div>
    </div>
    <hr />
    <div class="row row-height">
        <div class="container body-content">
            <div class="col-md-4 col-height col-bottom col-top">
                <div class="thumbnail">
                      <img src="/images/Asian_winners.png" alt="..."/>
                      <div class="caption">
                        <h3>News Story</h3>
                        <p>Vestibulum ut posuere orci. Maecenas fringilla pellentesque lorem, sit amet euismod quam rhoncus vitae. Quisque non semper lectus, vitae porta quam. Fusce non elit enim. Nam nec cursus lacus. Morbi laoreet ipsum sit amet malesuada porttitor. Phasellus ac egestas erat.</p>
                        <%--<p><a href="Information_Pages/News" class="btn btn-primary" role="button">More News</a></p>--%>
                      </div>
                  </div>
            </div>
            <div class="col-md-4 col-height col-bottom col-top">
              <div class="thumbnail">
                      <img src="/images/4th grade math is cool winners.jpg" alt="..."/>
                      <div class="caption">
                        <h3>Recent Winners</h3>
                        <p>Congratulations 4th Grade Math is Cool Team from Prairie View Elementary PTO! They took 1st place at their competition. </p>
                        <p><a href="#" class="btn btn-primary" role="button">More News</a></p>
                      </div>
              </div>
            </div>
            <div class="col-md-4 col-height col-bottom col-top">
              <div class="thumbnail">
                      <img src="/images/Horizon Middle School MIC Winners.jpg" alt="..."/>
                      <div class="caption">
                        <h3>Competitions</h3>
                        <p>Quisque non semper lectus, vitae porta quam. Fusce non elit enim. Nam nec cursus lacus. Morbi laoreet ipsum sit amet malesuada porttitor.</p>
                        <%--<p><a href="#" class="btn btn-primary" role="button">More News</a></p>--%>
                      </div>
              </div>
            </div>
        </div>
    </div><%--end row--%>

</asp:Content>
