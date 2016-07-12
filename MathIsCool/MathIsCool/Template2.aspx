<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Template2.aspx.cs" Inherits="MathIsCool.Template2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
   <main class="bs-docs-masthead" id="content" role="main" tabindex="-1">
       <div class="row">
            <image id="headerImage" class="img-responsive" src="/images/headerImage.png"></image>
       </div>
       <div class="row row-height">
        <div class="container body-content">
            <div class="col-md-4 col-height col-bottom col-top">
                <div class="thumbnail">
                      <img src="/images/Programmers.png" alt="...">
                      <div class="caption">
                        <h3>News Story</h3>
                        <p>Vestibulum ut posuere orci. Maecenas fringilla pellentesque lorem, sit amet euismod quam rhoncus vitae. Quisque non semper lectus, vitae porta quam. Fusce non elit enim. Nam nec cursus lacus. Morbi laoreet ipsum sit amet malesuada porttitor. Phasellus ac egestas erat.</p>
                        <p><a href="#" class="btn btn-primary" role="button">More News</a></p>
                      </div>
                  </div>
            </div>
            <div class="col-md-4 col-height col-bottom col-top">
              <div class="thumbnail">
                      <img src="/images/Engineers.png" alt="...">
                      <div class="caption">
                        <h3>Recent Winners</h3>
                        <p>Curabitur vitae euismod erat. Nulla vehicula, lorem at bibendum iaculis, tortor risus ornare eros, non varius lorem odio at diam. Praesent blandit quam id turpis faucibus faucibus. Donec ullamcorper accumsan ex ac sodales. Quisque faucibus eget nunc id hendrerit. Etiam scelerisque et sapien eu dictum. Integer sagittis sed leo et posuere.</p>
                        <p><a href="#" class="btn btn-primary" role="button">More News</a></p>
                      </div>
              </div>
            </div>
            <div class="col-md-4 col-height col-bottom col-top">
              <div class="thumbnail">
                      <img src="/images/Unicorns.png" alt="...">
                      <div class="caption">
                        <h3>Competition</h3>
                        <p>Quisque non semper lectus, vitae porta quam. Fusce non elit enim. Nam nec cursus lacus. Morbi laoreet ipsum sit amet malesuada porttitor.</p>
                        <p><a href="#" class="btn btn-primary" role="button">More News</a></p>
                      </div>
              </div>
            </div>
        </div>
    </div><%--end row--%>
   </main>
</asp:Content>
