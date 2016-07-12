<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CompCreation.aspx.cs" Inherits="MathIsCool.CompCreation" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script>
    var adminApp = angular.module('MathIsCoolApp', []);

        adminApp.controller('CompController', function ($scope, $RESTService) {
            $scope.comp = {};
            $scope.levels = [];
            $scope.statuses = [];
            $scope.locations = [];
            $scope.regions = [];
            $scope.date = "";
            $scope.time = "";
            //push current Level and status first.
            var levels = $RESTService.getCompLevelsItems();
            levels.then(function (response) {
                angular.forEach(response.data, function (level) {
                    if (level != null) {
                        $scope.levels.push(level);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var statuses = $RESTService.getStatusItems();
            statuses.then(function (response) {
                angular.forEach(response.data, function (status) {
                    if (status != null) {
                        $scope.statuses.push(status);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var regions = $RESTService.getRegionItems();
            regions.then(function (response) {
                angular.forEach(response.data, function (region) {
                    if (region != null) {
                        $scope.regions.push(region);
                    }
                });
            }, function (data, status, headers, config) {
                //do nothing
            });

            $scope.post = function () {
                $scope.comp.date = $('#date').val() + "T" + $('#time').val();
                $scope.comp.comp_id = guid();
                $scope.comp.status_id = 1;
                $scope.comp.level_id = parseInt($('#compLevel').val());
                $scope.comp.comp_loc_id = $('#compLocation').val();
                $scope.comp.region_id = $('#compRegion').val();
                $RESTService.postCompItem($scope.comp);
            };
            $scope.comp.schedule = "3:00 - 3:30	Coaches pick up packets and distribute materials to students\n" +
            "3:40 - 3:50	Orientation\n" +
            "3:50 - 3:55	Students go to testing rooms, coaches to coaches meeting\n" +
            "4:00 - 4:10	Mental Math (8 questions for each student)\n" +
            "4:15 - 4:50	Individual Test (40 questions)\n" +
            "4:55 - 5:10	Individual Test (Multiple Choice 10 questions counts toward team score)\n" +
            "5:15 - 5:30	Team Test (Fill in the blank 10 questions)\n" +
            "5:35 - 5:45	Pressure Round (5 questions)\n" +
            "Break -" +
            "6:25 - 6:45	College Bowl #1,2 (10 questions/set)\n" +
            "6:45 - 7:05	College Bowl #3,4 (10 questions/set)\n" +
            "7:05 - 7:25	College Bowl #5,6 (10 questions/set)\n" +
            "7:30	Award Ceremony";

            $("#compRegion").change(function () {
                $scope.locations = [];
                var locations = $RESTService.getCompLocationsItems();
                locations.then(function (response) {
                    angular.forEach(response.data, function (location) {
                        if (location != null) {
                            if (location.region_id == $('#compRegion').val())
                            {
                                $scope.locations.push(location);
                            }
                        }
                    });
                }, function (data, status, headers, config) {
                    alert("Error ", data, status);
                });
            });
        });

            adminApp.service('$RESTService', function ($q, $http) {

            this.getCompLevelsItems = function () {
                var url = "/api/CompetitionLevels";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.getCompLocationsItems = function () {
                var url = "/api/Locations";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.getStatusItems = function () {
                var url = "/api/Statuses";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.getRegionItems = function () {
                var url = "/api/Regions";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.postCompItem = function (comp) {
                var url = "/api/Competitions";
                var value = angular.toJson(comp);
                return $http({
                    url: url,
                    data: value,
                    method: "POST"
                });
            };

            this.putCompItem = function (comp) {
                var url = "/api/Competitions";
                var value = angular.toJson(comp);
                $http({
                    url: url + "?id=" + comp.comp_id,
                    data: value,
                    method: "PUT"
                });

            };
            });// End GetRESTService 

            function guid() {
                function s4() {
                    return Math.floor((1 + Math.random()) * 0x10000)
                      .toString(16)
                      .substring(1);
                }
                return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
                  s4() + '-' + s4() + s4() + s4();
            }//end guid
            //var n = d.toISOString();
            function init() {

                var _inputs = document.getElementsByTagName('input');

                for (var i = 0; i < _inputs.length; i++) {

                    if (!Modernizr.inputtypes[_inputs[i].type]) {
                        _inputs[i].className = 'not-supported';
                    }

                    _inputs[i].parentNode.getElementsByClassName('result')[0].innerHTML = _inputs[i].value;

                    _inputs[i].onchange = function () {
                        //console.log(this.value);
                        var result_node = this.parentNode.getElementsByClassName('result');
                        result_node[0].innerHTML = this.value;
                    }
                }
            }

            window.onload = init;
    </script>
    <% if (System.Web.HttpContext.Current.User.IsInRole("Administrator")) {%>
    <div class="container ">
        <div class="row">
            <div class="col-md-6">
                <h1>Competition Creation</h1>
            </div>
        </div>
        <br />
        <div ng-controller="CompController">
        <br />
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" ng-model=comp.name />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                    <label for="date">Date</label>
                    <input type="date" class="form-control" id="date" value="2016-06-01"/>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                    <label for="date">Time</label>
                    <input type="time" class="form-control" id="time" value="12:00:00"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <div class="form-group">
                    <label class="control-label" for="compRegion">Region</label>
                    <select class="form-control" id="compRegion">
                        <option ng-repeat="region in regions" value={{region.region_id}}>{{region.region_name}}</option>
                    </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                    <label class="control-label" for="compLocation">Comp Location</label>
                    <select class="form-control" id="compLocation">
                        <option ng-repeat="location in locations" value={{location.comp_loc_id}}>{{location.name}}</option>
                    </select>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                    <label class="control-label" for="compLevel">Comp Level</label>
                    <select class="form-control" id="compLevel">
                        <option ng-repeat="level in levels" value={{level.id}}>{{level.value}}</option>
                    </select>
                    </div>
                </div>
            </div>
            <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="team_limit">Team Limit(per School)</label>
                        <input type="number" class="form-control" id="team_limit" ng-model=comp.team_limit />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="student_limit">Student Limit(per Team)</label>
                        <input type="number" class="form-control" id="student_limit" ng-model=comp.student_limit />
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                        <label for="team_allowed">Total Teams Allowed</label>
                        <input type="number" class="form-control" id="team_allowed" ng-model=comp.total_teams_allowed />
                        </div>
                    </div>
                </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                    <label for="note">Notes</label>
                    <textarea class="form-control" id="note" rows="3" ng-model=comp.note></textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <div class="form-group">
                    <label for="note">Schedule</label>
                    <textarea class="form-control" id="schedule" rows="15" ng-model=comp.schedule></textarea>
                    </div>
                </div>
            </div>      
            <div class="row">   
                <div class="col-md-4 col-md-offset-8" >   
                    <button class="btn btn-md btn-success pull-right" ng-click="post()">ADD COMPETITION</button>
                </div>  
            </div>
	    </div>
    </div>
    <% } %>
</asp:Content>
