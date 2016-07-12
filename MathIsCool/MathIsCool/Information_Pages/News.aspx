<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="News.aspx.cs" Inherits="MathIsCool.Information_Pages.News" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
        var myApp = angular.module('MathIsCoolApp', []).controller('Controller', function ($scope, $GetRESTService) {
            $scope.data = [];
            var tasksProm = $GetRESTService.getNewsItems();
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
            this.getNewsItems = function () {
                var url = "/api/News";
                return $http({
                    url: url,
                    method: "GET"
                });
            };
        });// Gets News Items 
    </script>
    <div class="container ">
        <div class="row">
            <div class="col-md-6">
                <h1>News</h1>
            </div>
            <br />
            <br />
        </div>
        <div class="row">     
            <div ng-controller="Controller">
                <div ng-repeat="item in data">
                    <div class="row">
                        <div class="col-md-12">
                            <span>{{item.news_content}}</span>
                            <br />
                            <br />
                        </div>                    
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>
