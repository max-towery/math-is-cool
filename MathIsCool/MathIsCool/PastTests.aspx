<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PastTests.aspx.cs" Inherits="MathIsCool.PastTests" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <script>
        var myApp = angular.module('MathIsCoolApp', []).controller('Controller', function ($scope, $GetRESTService) {
            $scope.data = [];
            var tasksProm = $GetRESTService.getSamplesItems();
            tasksProm.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        $scope.data.push(row);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });
        });

        myApp.service('$GetRESTService', function ($q, $http) {
            this.getSamplesItems = function () {
                var url = "/api/Samples";
                return $http({
                    url: url,
                    method: "GET"
                });
            };
        });// Gets Sample items
        
    </script>
    <!--TODO: Once we have the database updated, we can iterate through the URLS posted there to build the dropdown table-->
    <div class="container ">
            <div class="row">
                <div class="col-md-6">
                    <h1>Past Test Samples</h1>
                </div>
            </div>
        <br /><br />
            <div class="panel-group" id="accordion">
                    <div class="sampleHeader">Elementary Level Tests</div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse00{{$index+1}}">
                                    Grade: 4 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse00{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                               <a href="./samples/elementary/grade_4/4MAS02.pdf">Masters:      Year: 2001-02</a><br />
                               <a href="./samples/elementary/grade_4/4MIC00.pdf">Individual:   Year: 2000-01</a><br />
                               <a href="./samples/elementary/grade_4/4MIC01.pdf">Individual:   Year: 2001-02</a><br />
                               <a href="./samples/elementary/grade_4/4MIC02.pdf">Individual:   Year: 2002-03</a><br />
                               <a href="./samples/elementary/grade_4/4MIC96.pdf">Individual:   Year: 1996-97</a><br />
                               <a href="./samples/elementary/grade_4/4MIC97.pdf">Individual:   Year: 1997-98</a><br />
                               <a href="./samples/elementary/grade_4/4MIC98.pdf">Individual:   Year: 1998-99</a><br />
                               <a href="./samples/elementary/grade_4/4MIC99.pdf">Individual:   Year: 1999-00</a><br />

                            </div>
                        </div>
              
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse01{{$index+1}}">
                                    Grade: 5 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse01{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="./samples/elementary/grade_5/5MIC99.pdf">Individual:  Year: 1999-00</a><br />
                                <a href="./samples/elementary/grade_5/5MIC00.pdf">Individual:  Year: 2000-01</a><br />
                                <a href="./samples/elementary/grade_5/5MIC01.pdf">Individual:  Year: 2001-02</a><br />
                                <a href="./samples/elementary/grade_5/5MIC02.pdf">Individual:  Year: 2002-03</a><br />
                                <a href="./samples/elementary/grade_5/5MIC96.pdf">Individual:  Year: 1996-97</a><br />
                                <a href="./samples/elementary/grade_5/5MIC97.pdf">Individual:  Year: 1997-98</a><br />
                                <a href="./samples/elementary/grade_5/5MIC98.pdf">Individual:  Year: 1998-99</a><br />
                                <a href="./samples/elementary/grade_5/5MIC99.pdf">Individual:  Year: 1999-00</a><br />
                            </div>
                        </div>
                    </div>
                    <div class="sampleHeader">Middle School Level Tests</div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1{{$index+1}}">
                                    Grade: 7 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse1{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="./samples/middle_school/grade_7/7MIC00.pdf">Individual:  Year: 2000-01</a><br />
                                <a href="./samples/middle_school/grade_7/7MIC01.pdf">Individual:  Year: 2001-02</a><br />
                                <a href="./samples/middle_school/grade_7/7MIC96.pdf">Individual:  Year: 1996-97</a><br />
                                <a href="./samples/middle_school/grade_7/7MIC97.pdf">Individual:  Year: 1997-98</a><br />
                                <a href="./samples/middle_school/grade_7/7MIC98.pdf">Individual:  Year: 1998-99</a><br />
                                <a href="./samples/middle_school/grade_7/7MIC99.pdf">Individual:  Year: 1999-00</a><br />
                            </div>
                        </div>
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1{{$index+1}}">
                                    Grade: 8 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse1{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="./samples/elementary/grade_5/8MIC00.pdf">Individual:  Year: 2000-01</a><br />
                                <a href="./samples/elementary/grade_5/8MIC01.pdf">Individual:  Year: 2001-02</a><br />
                                <a href="./samples/elementary/grade_5/8MIC96.pdf">Individual:  Year: 1996-97</a><br />
                                <a href="./samples/elementary/grade_5/8MIC97.pdf">Individual:  Year: 1997-98</a><br />
                                <a href="./samples/elementary/grade_5/8MIC98.pdf">Individual:  Year: 1998-99</a><br />
                                <a href="./samples/elementary/grade_5/8MIC99.pdf">Individual:  Year: 1999-00</a><br />
                            </div<div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse1{{$index+1}}">
                                    Grade: 7/8
                                </a>
                            </h4>
                        </div>
                        <div id="collapse1{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="./samples/elementary/grade_7_8/07-08MastersPreA-GeomIndiv.pdf">Masters Pre-Algrebra/Geometry:  Year: 2007-08</a><br />
                                <a href="./samples/elementary/grade_7_8/07-08MastersPreA-GeomIndiv.pdf">Masters Pre-Algrebra/Geometry:  Year: 2007-08</a><br />
                                <a href="./samples/elementary/grade_7_8/07-08MastersPreA-GeomIndiv.pdf">Masters Pre-Algrebra/Geometry:  Year: 2007-08</a><br />
                                <a href="./samples/elementary/grade_7_8/07-08MastersPreA-GeomIndiv.pdf">Masters Pre-Algrebra/Geometry:  Year: 2007-08</a><br />
                          
                            </div>
                        </div>
                        </div>

                    </div>
                    <div class="sampleHeader">High School Level Tests</div>
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2{{$index+1}}">
                                    Grade: 9 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse2{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="testing.pdf">Year: 2000-01</a>
                            </div>
                        </div>
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2{{$index+1}}">
                                    Grade: 10 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse2{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="testing.pdf">Year: 2000-01</a>
                            </div>
                        </div>
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2{{$index+1}}">
                                    Grade: 11 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse2{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="testing.pdf">Year: 2000-01</a>
                            </div>
                        </div>
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" data-parent="#accordion" href="#collapse2{{$index+1}}">
                                    Grade: 12 
                                </a>
                            </h4>
                        </div>
                        <div id="collapse2{{$index+1}}" class="panel-collapse collapse">
                            <div class="panel-body">
                                <a href="testing.pdf">Year: 2000-01</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



    <style>
        .sampleHeader {font-size: 27px; margin: 20px;}
        .jumbotron{width:80%;margin-left:10%;max-width: 1200px;margin-left:auto; margin-right:auto;}
        .img-center {margin:0 auto;}
        .dl-horizontal dt{white-space: normal;}
        .omacenter{margin-left:auto; margin-right:auto;}
        .titre{color:#fff;}
        .entete{background-color: #00581B;width:80%;margin-left:10%;}
        
    </style>



</asp:Content>
