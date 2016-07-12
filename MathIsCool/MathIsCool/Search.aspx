<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="MathIsCool.Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<hr>
  <div ng-controller="initApp">
    <div class="row">
      <div class="col-md-3">
        <div class="input-group input-group-lg add-on">
          <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search">
          <div class="input-group-btn">
            <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
          </div>
        </div>
      </div>
      <div class="col-md-6">
      	<h4 class="text-center">AngularJs Dynamic Data Table</h4>
      </div>
      <div class="col-md-3">
        <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
      </div>
    </div><a href="#myModal" role="button" class="btn btn-default" data-toggle="modal">Launch demo modal</a>

<div id="myModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
<div class="modal-dialog">
<div class="modal-content">
	<div class="modal-header">
		<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			<h3 id="myModalLabel">Modal header</h3>
	</div>
	<div class="modal-body">
		<p>One fine body…</p>
	</div>
	<div class="modal-footer">
		<button class="btn" data-dismiss="modal" aria-hidden="true">Close</button>
		<button class="btn btn-primary">Save changes</button>
	</div>
</div>
</div>
</div>
    
    <table class="table table-striped table-hover">
      <tbody><tr>
        <th class="username"><a ng-click="sort_by('username')">Username <i class="fa fa-sort"></i></a></th>
        <th class="fname"><a ng-click="sort_by('fname')">First Name  <i class="fa fa-sort"></i></a></th>
        <th class="lname" title="non-sortable">Last Name</th>
        <th class="id"><a ng-click="sort_by('id')">ID <i class="fa fa-sort"></i></a></th>
        <th class="email"><a ng-click="sort_by('email')">Email<i class="fa fa-sort"></i></a></th>
        <th class="type"><a ng-click="sort_by('type')">Type <i class="fa fa-sort"></i></a></th>
        <th></th>
      </tr>
      </tbody>
      <tfoot>
        <tr><td colspan="9">{{sizes}}
          <div class="text-center">
            <ul class="pagination">
              <li ng-class="{disabled: currentPage == 0}">
                <a href="javascript:;" ng-click="prevPage()">« Prev</a>
              </li>
              <li ng-repeat="n in range(pagedItems.length)" ng-class="{active: n == currentPage}" ng-click="setPage()">
                <a href="javascript:;" ng-bind="n + 1">1</a>
              </li>
              <li ng-class="{disabled: currentPage == pagedItems.length - 1}">
                <a href="javascript:;" ng-click="nextPage()">Next »</a>
              </li>
            </ul>
          </div>
        </td>
      </tr></tfoot>
      <tbody>
        <tr ng-repeat="item in pagedItems[currentPage] | orderBy:sortingOrder:reverse">
          <td>{{item.user_name}}</td>
          <td>{{item.fname}}</td>
          <td>{{item.lname}}</td>
          <td><a href="#">{{item.id}}</a></td>
          <td>{{item.email}}</td>
          <td><a href="#" ng-click="deleteItem($index)">x</a></td>
        </tr>
      </tbody>
    </table>
  </div>

    <script>

        var adminApp = angular.module('MathIsCoolApp', []);
        var generateData = function () {
            var arr = [];
            var letterWords = ["alpha", "bravo", "charlie", "daniel", "earl", "fish", "grace", "henry", "ian", "jack", "karen", "mike", "delta", "alex", "larry", "bob", "zelda"]
            for (var i = 1; i < 60; i++) {
                var id = letterWords[Math.floor(Math.random() * letterWords.length)];
                arr.push({ "id": id + i, "name": "name " + i, "description": "Description of item #" + i, "field3": id, "field4": "Some stuff about rec: " + i, "field5": "field" + i });
            }
            return arr;
        }

        var sortingOrder = 'name'; //default sort

            adminApp.controller('initApp', function ($scope, $filter, $GetRESTService) {

            // init
            $scope.sortingOrder = sortingOrder;
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            var tasksProm1 = $GetRESTService.getUsersItems();
            tasksProm1.then(function (response) {
                //$scope.items = response.data;
                debugger;
                angular.forEach(response.data, function (row) {
                    
                    if (row != null) {
                        debugger;
                        if (row.perm_id === "0ee794c2-ee96-41be-8cfe-47fef01c9d5b") {
                            row.perm_id = "Coach";
                            $scope.items.push(row);
                        }
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });
            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                debugger;
                haystack = haystack.toString();
                return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
            };

            // init the filtered items
            $scope.search = function () {
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
                    debugger;
                    for (var attr in item) {
                        if (searchMatch(item[attr], $scope.query))
                            return true;
                    }
                    return false;
                });
                // take care of the sorting order
                if ($scope.sortingOrder !== '') {
                    $scope.filteredItems = $filter('orderBy')($scope.filteredItems, $scope.sortingOrder, $scope.reverse);
                }
                $scope.currentPage = 0;
                // now group by pages
                $scope.groupToPages();
            };

            // show items per page
            $scope.perPage = function () {
                $scope.groupToPages();
            };

            // calculate page in place
            $scope.groupToPages = function () {
                $scope.pagedItems = [];

                for (var i = 0; i < $scope.filteredItems.length; i++) {
                    if (i % $scope.itemsPerPage === 0) {
                        $scope.pagedItems[Math.floor(i / $scope.itemsPerPage)] = [$scope.filteredItems[i]];
                    } else {
                        $scope.pagedItems[Math.floor(i / $scope.itemsPerPage)].push($scope.filteredItems[i]);
                    }
                }
            };

            $scope.deleteItem = function (idx) {
                var itemToDelete = $scope.pagedItems[$scope.currentPage][idx];
                var idxInItems = $scope.items.indexOf(itemToDelete);
                $scope.items.splice(idxInItems, 1);
                $scope.search();

                return false;
            };

            $scope.range = function (start, end) {
                var ret = [];
                if (!end) {
                    end = start;
                    start = 0;
                }
                for (var i = start; i < end; i++) {
                    ret.push(i);
                }
                return ret;
            };

            $scope.prevPage = function () {
                if ($scope.currentPage > 0) {
                    $scope.currentPage--;
                }
            };

            $scope.nextPage = function () {
                if ($scope.currentPage < $scope.pagedItems.length - 1) {
                    $scope.currentPage++;
                }
            };

            $scope.setPage = function () {
                $scope.currentPage = this.n;
            };

            // functions have been describe process the data for display
            $scope.search();


            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

        });

            adminApp.$inject = ['$scope', '$filter'];

            adminApp.service('$GetRESTService', function ($q, $http) {
                this.getUsersItems = function () {
                    var url = "/api/Users";
                    return $http({
                        url: url,
                        method: "GET"
                    });
                }
            });
        $(document).ready(function() {
            $scope.search();
        });
    </script>
</asp:Content>
