<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FAQ.aspx.cs" Inherits="MathIsCool.Information_Pages.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var myApp = angular.module('MathIsCoolApp', []).controller('Controller', function ($scope, $GetRESTService) {
            debugger;
            $scope.data = [];
            var tasksProm = $GetRESTService.getFAQItems();
            tasksProm.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        debugger;
                        $scope.data.push(row);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });
        });

        myApp.service('$GetRESTService', function ($q, $http) {
            debugger;
            this.getFAQItems = function () {
                var url = "/api/FAQ";
                return $http({
                    url: url,
                    method: "GET"
                });
            };
        });// Gets FAQ items 
    </script>
        <div class="container">
            <h2>FAQ</h2>
            <br />
            <br />
            <div class="panel-group" id="accordion">
                <div ng-controller="Controller">
                    <div ng-repeat="item in data">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title">
                                    <a data-toggle="collapse" data-parent="#accordion" href="#collapse{{$index+1}}">
                                        {{item.question}}

                                    </a>
                                </h4>
                            </div>
                            <div id="collapse{{$index+1}}" class="panel-collapse collapse ">
                                <div class="panel-body">

                                    {{item.answer}}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    <style>
        .jumbotron{width:80%;margin-left:10%;max-width: 1200px;margin-left:auto; margin-right:auto;}
        .img-center {margin:0 auto;}
        .dl-horizontal dt{white-space: normal;}
        .omacenter{margin-left:auto; margin-right:auto;}
        .titre{color:#fff;}
        .entete{background-color: #00591b;width:80%;margin-left:10%;}
    </style>
    
    
          
</asp:Content>