<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Management.aspx.cs" Inherits="MathIsCool.Management" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>Management</h1>
            </div>
        </div>
        <br />
        <br />

      <!-- Nav tabs -->
        <% if (System.Web.HttpContext.Current.User.IsInRole("Administrator")) {%>
      <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab" data-toggle="tab">Home</a></li>
        <li role="presentation"><a href="#competitions" aria-controls="competitions" role="tab" data-toggle="tab">Competitions</a></li>
        <li role="presentation"><a href="#complocations" aria-controls="complocations" role="tab" data-toggle="tab">Competition Locations</a></li>
        <li role="presentation"><a href="#schools" aria-controls="schools" role="tab" data-toggle="tab">Schools</a></li>
        <li role="presentation"><a href="#coaches" aria-controls="coaches" role="tab" data-toggle="tab">Coaches</a></li>
        <li role="presentation"><a href="#directors" aria-controls="directors" role="tab" data-toggle="tab">Directors</a></li>
        <li role="presentation"><a href="#admins" aria-controls="admins" role="tab" data-toggle="tab">Administrators</a></li>
        <li role="presentation"><a href="#faq" aria-controls="faq" role="tab" data-toggle="tab">FAQ's</a></li>
      </ul>
        <% } %>
        <script>
        var adminApp = angular.module('MathIsCoolApp', []);

        adminApp.controller('CompTableController', function ($scope, $filter, $GetRESTService) {
            $scope.sortingOrder = 'name';
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            $scope.comp = {};
            $scope.levels = [];
            $scope.statuses = [];
            $scope.locations = [];
            $scope.date = "";
            $scope.time = "";
            //push current Level and status first.
            var levels = $GetRESTService.getCompLevelsItems();
            levels.then(function (response) {
                angular.forEach(response.data, function (level) {
                    if (level != null) {
                        $scope.levels.push(level);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var statuses = $GetRESTService.getStatusItems();
            statuses.then(function (response) {
                angular.forEach(response.data, function (status) {
                    if (status != null) {
                        $scope.statuses.push(status);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var locations = $GetRESTService.getCompLocationsItems();
            locations.then(function (response) {
                angular.forEach(response.data, function (location) {
                    if (location != null) {
                        $scope.locations.push(location);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var comps = $GetRESTService.getCompItems();
            comps.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        $scope.items.push(row);
                    }
                });
                $scope.search();
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                if (haystack !== null) {
                    haystack = haystack.toString();
                    return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
                }
                return true;
            };

            // init the filtered items
            $scope.search = function () {
                
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
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
                $GetRESTService.deleteCompItem(itemToDelete);
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


            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

            $scope.edit = function (index) {
                var itemToEdit = $scope.pagedItems[$scope.currentPage][index];
                $scope.comp = itemToEdit;
                $scope.date = $scope.comp.date.substring(0, 10);
                $scope.time = $scope.comp.date.substring(11, 19);
                $('#competitionModal').modal({
                    show: 'true'
                });

            }

            $scope.update = function () {
                $scope.comp.date = $('#date').val() + "T" + $('#time').val();
                $GetRESTService.putCompItem($scope.comp);
            };
            $("#compLevel").change(function () {
                $scope.comp.level_id = parseInt($('#compLevel').val());
            });
            $("#status").change(function () {
                $scope.comp.status_id = parseInt($('#status').val());
            });
        });

        adminApp.controller('CompLocTableController', function ($scope, $filter, $GetRESTService) {
            $scope.sortingOrder = 'name';
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            $scope.regions = [];
            $scope.compLoc = {};
            $scope.address = {};
            $scope.locationToPost = {};
            $scope.addressToPost = {};

            var compLoc = $GetRESTService.getCompLocItems();
            compLoc.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        $scope.items.push(row);
                    }
                });
                $scope.search();
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var compLocRegions = $GetRESTService.getRegionItems();
            compLocRegions.then(function (response) {
                angular.forEach(response.data, function (level) {
                    if (level != null) {
                        $scope.regions.push(level);
                    }
                });
            }, function (data, status, headers, config) {

                //alert("Error ", data, status);
            });
            //var locAddress = $GetRESTService.getAddressItems();
            //locAddress.then(function (response) {
            //    angular.forEach(response.data, function (add) {
            //        if (add != null) {
            //            $scope.regions.push(level);
            //        }
            //    });
            //}, function (data, status, headers, config) {
            //    alert("Error ", data, status);
            //});

            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                haystack = haystack.toString();
                return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
            };

            // init the filtered items
            $scope.search = function () {
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
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
                $GetRESTService.deleteCompLocItem(itemToDelete);
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

            $scope.edit = function (index) {
                var itemToEdit = $scope.pagedItems[$scope.currentPage][index];
                $scope.compLoc = itemToEdit;
                $('#competitionLocationModal').modal({
                    show: 'true'
                });
            }

            $scope.addModal = function () {
                $('#addCompetitionLocationModal').modal({
                    show: 'true'
                });
            }

            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

            $scope.update = function () {
                var location = {};
                location.comp_loc_id = $scope.compLoc.comp_loc_id;
                location.address_id = $scope.compLoc.address_id;
                location.map_url = $scope.compLoc.map_url;
                location.region_id = $scope.compLoc.region_id;
                location.name = $scope.compLoc.name;
                
                $scope.address.address_id = $scope.compLoc.address_id;
                $scope.address.street = $scope.compLoc.street;
                $scope.address.city = $scope.compLoc.city;
                $scope.address.state = $scope.compLoc.state;
                $scope.address.zip = $scope.compLoc.zip;


                $GetRESTService.putCompLocItem(location);
                $GetRESTService.putAddressItem($scope.address);
            };

            $scope.post = function () {
                debugger;
                $scope.locationToPost.comp_loc_id = guid();
                $scope.addressToPost.address_id = guid();//add address as well
                $scope.locationToPost.address_id = $scope.addressToPost.address_id;
                $scope.locationToPost.region_id = $('#addLocRegion').val();
                $GetRESTService.postAddressItem($scope.addressToPost);
                // allows for address to be added so that location can reference addressId properly.
                setTimeout(function () { $GetRESTService.postLocationItem($scope.locationToPost); }, 500);
            };

            $("#compTableRegion").change(function () {
                for (i = 0; i < $scope.regions.length; i++)
                {
                    if($scope.regions[i].id == $('#compTableRegion').val())
                    {
                        $scope.compLoc.region_id = $scope.regions[i].region_id;
                    }
                }
            });
        });

        adminApp.controller('SchoolsTableController', function ($scope, $filter, $GetRESTService) {
            $scope.sortingOrder = 'name';
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            $scope.school = {};
            $scope.regions = [];
            $scope.address = {};
            $scope.schoolToPost = {};
            $scope.addressToPost = {};
            var schools = $GetRESTService.getSchoolsItems();
            schools.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        $scope.items.push(row);
                    }
                });
                $scope.search();
            }, function (data, status, headers, config) {
                alert("Error: getShools ", data, status);
            });

            var schoolRegions = $GetRESTService.getRegionItems();
            schoolRegions.then(function (response) {
                angular.forEach(response.data, function (level) {
                    if (level != null) {
                        $scope.regions.push(level);
                    }
                });
            }, function (data, status, headers, config) {
                //alert("Error: getRegions ", data, status);
            });

            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                haystack = haystack.toString();
                return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
            };

            // init the filtered items
            $scope.search = function () {
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
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
                $GetRESTService.deleteSchoolItem(itemToDelete);
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

            $scope.search();

            $scope.edit = function (index) {
                var itemToEdit = $scope.pagedItems[$scope.currentPage][index];
                $scope.school = itemToEdit;
                $('#schoolModal').modal({
                    show: 'true'
                });
            }

            $scope.addModal = function () {
                $('#addSchoolModal').modal({
                    show: 'true'
                });
            }

            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

            $scope.post = function () {
                debugger;
                $scope.schoolToPost.school_id = guid();
                $scope.addressToPost.address_id = guid();//add address as well
                $scope.schoolToPost.address_id = $scope.addressToPost.address_id;
                $scope.schoolToPost.last_reg = Date.now();
                $scope.schoolToPost.approved = 1;
                $scope.schoolToPost.region_id = parseInt($('#addSchoolRegion').val());
                $scope.addressToPost.extension = null;
                //$scope.addressToPost.city = null;
                //$scope.addressToPost.state = null;
                //$scope.addressToPost.zip = null;
                //$scope.addressToPost.phone = null;
                $GetRESTService.postAddressItem($scope.addressToPost);
                setTimeout(function () { $GetRESTService.postSchoolItem($scope.schoolToPost); }, 500);
            };

            $scope.update = function () {
                var schoolToEdit = {};
                schoolToEdit.id = $scope.school.id;
                schoolToEdit.school_id = $scope.school.school_id;
                schoolToEdit.address_id = $scope.school.address_id;
                schoolToEdit.region_id = $scope.school.region_id;
                schoolToEdit.name = $scope.school.name;
                schoolToEdit.short_name = $scope.school.short_name;
                schoolToEdit.last_reg = $scope.school.last_reg;
                schoolToEdit.approved = $scope.school.approved;
                $GetRESTService.putSchoolItem(schoolToEdit);
            };
            $("#schoolRegion").change(function () {
                $scope.school.region_id = parseInt($('#schoolRegion').val());
            });
            
        });

        adminApp.controller('CoachesTableController', function ($scope, $filter, $GetRESTService) {
            $scope.sortingOrder = 'UserName';
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            $scope.coach = {};
            $scope.roles = [];
            $scope.userRole = {};

            var coaches = $GetRESTService.getUsersItems();
            coaches.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        debugger;
                        if (row.role === "Coach") {
                            $scope.items.push(row);
                        }
                    }
                });
                $scope.search();
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var coachRoles = $GetRESTService.getRoleItems();
            coachRoles.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        $scope.roles.push(row);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                haystack = haystack.toString();
                return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
            };

            // init the filtered items
            $scope.search = function () {
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
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
                $GetRESTService.deleteUserItem(itemToDelete);
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

                $scope.search();

                $scope.edit = function (index) {
                    var itemToEdit = $scope.pagedItems[$scope.currentPage][index];
                    $scope.coach = itemToEdit;
                    $('#coachModal').modal({
                        show: 'true'
                    });
                };

            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

            $scope.update = function () {
                $GetRESTService.putUserRoleItem($scope.userRole);
                $GetRESTService.putUserItem($scope.coach);
            };

            $("#coachRole").change(function () {
                //get User Role
                //Change Role for User
                $scope.userRole.roleID = $('#coachRole').val();
            });
        });

        adminApp.controller('DirTableController', function ($scope, $filter, $GetRESTService) {
            $scope.sortingOrder = 'user_name';
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            $scope.director = {};
            $scope.roles = [];
            $scope.userRole = {};

            var directors = $GetRESTService.getUsersItems();
            directors.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        if (row.role === "Director") {
                            $scope.items.push(row);
                        }
                    }
                });
                $scope.search();
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var dirRoles = $GetRESTService.getRoleItems();
            dirRoles.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        $scope.roles.push(row);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                haystack = haystack.toString();
                return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
            };

            // init the filtered items
            $scope.search = function () {
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
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
                $GetRESTService.deleteUserItem(itemToDelete);
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

            $scope.search();

            $scope.edit = function (index) {
                var itemToEdit = $scope.pagedItems[$scope.currentPage][index];
                $scope.director = itemToEdit;
                $('#directorModal').modal({
                    show: 'true'
                });
            }

            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

            $scope.update = function () {
                $GetRESTService.putUserRoleItem($scope.userRole);
                $GetRESTService.putUserItem($scope.director);
            };

            $("#directorRole").change(function () {
                //get User Role
                //Change Role for User
                $scope.userRole.roleID = $('#directorRole').val();
            });
        });

        adminApp.controller('AdminsTableController', function ($scope, $filter, $GetRESTService) {
            $scope.sortingOrder = 'user_name';
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            $scope.admin = {};
            $scope.roles = [];
            $scope.userRole = {};
            var admins = $GetRESTService.getUsersItems();
            admins.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        if (row.role === "Administrator") {
                            $scope.items.push(row);
                        }
                    }
                });
                $scope.search();
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var adminRoles = $GetRESTService.getRoleItems();
            adminRoles.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        debugger;
                        $scope.roles.push(row);
                    }
                });
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });


            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                haystack = haystack.toString();
                return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
            };

            // init the filtered items
            $scope.search = function () {
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
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
                $GetRESTService.deleteUserItem(itemToDelete);
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

            $scope.search();

            $scope.edit = function (index) {
                var itemToEdit = $scope.pagedItems[$scope.currentPage][index];
                $scope.admin = itemToEdit;

                $('#adminModal').modal({
                    show: 'true'
                });
            };

            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

            $scope.update = function () {
                debugger;
                $scope.userRole.roleId = $('#adminRole').val();
                $scope.userRole.userId = $scope.admin.userID;
                $GetRESTService.putUserRoleItem($scope.userRole);
                $GetRESTService.putUserItem($scope.admin);
            };

            //$("#adminRole").change(function () {
            //    //get User Role
            //    //Change Role for User
                
            //    $scope.userRole.roleID = $('#adminRole').val();
            //});
        });

        adminApp.controller('FAQTableController', function ($scope, $filter, $GetRESTService) {
            $scope.sortingOrder = 'level';
            $scope.pageSizes = [5, 10, 25, 50];
            $scope.reverse = false;
            $scope.filteredItems = [];
            $scope.groupedItems = [];
            $scope.itemsPerPage = 10;
            $scope.pagedItems = [];
            $scope.currentPage = 0;
            $scope.items = [];
            $scope.faq = {};
            $scope.faqToPost = {};
            var faqs = $GetRESTService.getFAQItems();
            faqs.then(function (response) {
                angular.forEach(response.data, function (row) {
                    if (row != null) {
                        $scope.items.push(row);
                    }
                });
                $scope.search();
            }, function (data, status, headers, config) {
                alert("Error ", data, status);
            });

            var searchMatch = function (haystack, needle) {
                if (!needle) {
                    return true;
                }
                haystack = haystack.toString();
                return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
            };

            // init the filtered items
            $scope.search = function () {
                $scope.filteredItems = $filter('filter')($scope.items, function (item) {
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
                $GetRESTService.deleteFAQItem(itemToDelete);
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

            $scope.search();

            $scope.edit = function (index) {
                var itemToEdit = $scope.pagedItems[$scope.currentPage][index];
                $scope.faq = itemToEdit;
                $('#faqModal').modal({
                    show: 'true'
                });
            }

            // change sorting order
            $scope.sort_by = function (newSortingOrder) {
                if ($scope.sortingOrder == newSortingOrder)
                    $scope.reverse = !$scope.reverse;

                $scope.sortingOrder = newSortingOrder;
            };

            $scope.addModal = function () {
                $('#addFaqModal').modal({
                    show: 'true'
                });
            }

            $scope.post = function () {
                debugger;
                $scope.faqToPost.faq_id = guid();
                $GetRESTService.postFAQItem($scope.faqToPost);
            };

            $scope.update = function () {
                $GetRESTService.putFAQItem($scope.faq);
            };
        });

        adminApp.service('$GetRESTService', function ($q, $http) {
            this.getUsersItems = function () {
                var url = "/api/Users";
                return $http({
                    url: url,
                    method: "GET"
                });
            }

            this.getRoleItems = function () {
                var url = "/api/Roles";
                return $http({
                    url: url,
                    method: "GET"
                });
            }

            this.getUserRoleItem = function (userId) {
                var url = "/api/UserRoles";
                debugger;
                return $http({
                    url: url + "?id=" + userId,
                    method: "GET"
                });
            }

            this.getCompLocItems = function () {
                var url = "/api/Locations";
                return $http({
                    url: url,
                    method: "GET"
                });
            }

            this.getSchoolsItems = function () {
                var url = "/api/Schools";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.getCompItems = function () {
                var url = "/api/Competitions";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.getFAQItems = function () {
                var url = "/api/FAQ";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.getAdminsItems = function () {
                var url = "/api/Users";
                return $http({
                    url: url,
                    method: "GET"
                });
            };

            this.getDirItems = function () {
                var url = "/api/Users";
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

            this.postLocationItem = function (loc) {
                var url = "/api/Locations";
                debugger;
                var value = angular.toJson(loc);
                return $http({
                    url: url,
                    data: value,
                    method: "POST"
                });
            };

            this.postSchoolItem = function (school) {
                var url = "/api/Schools";
                debugger;
                var value = angular.toJson(school);
                return $http({
                    url: url,
                    data: value,
                    method: "POST"
                });
            };

            this.postAddressItem = function (address) {
                var url = "/api/Addresses";
                debugger;
                var value = angular.toJson(address);
                return $http({
                    url: url,
                    data: value,
                    method: "POST"
                });
            };

            this.postFAQItem = function (faq) {
                var url = "/api/FAQ";
                var value = angular.toJson(faq);
                return $http({
                    url: url,
                    data: value,
                    method: "POST"
                });
            };

            this.putUserItem = function (user) {
                var url = "/api/Users";
                var value = angular.toJson(user);
                $http({
                    url: url + "?id=" + user.userID,
                    data: value,
                    method: "PUT"
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

            this.putUserRoleItem = function (userRole) {
                var url = "/api/UserRoles";
                var value = angular.toJson(userRole);
                $http({
                    url: url + "?id=" + userRole.UserId,
                    data: value,
                    method: "PUT"
                });

            };

            this.putCompLocItem = function (loc) {
                var url = "/api/Locations";
                var value = angular.toJson(loc);
                $http({
                    url: url + "?id=" + loc.comp_loc_id,
                    data: value,
                    method: "PUT"
                });

            };

            this.putAddressItem = function (add) {
                var url = "/api/Addresses";
                var value = angular.toJson(add);
                $http({
                    url: url + "?id=" + add.address_id,
                    data: value,
                    method: "PUT"
                });

            };

            this.putSchoolItem = function (school) {
                var url = "/api/Schools";
                var value = angular.toJson(school);
                $http({
                    url: url + "?id=" + school.school_id,
                    data: value,
                    method: "PUT"
                });

            };

            this.putFAQItem = function (faq) {
                var url = "/api/FAQ";
                var value = angular.toJson(faq);
                return $http({
                    url: url + "?id=" + faq.faq_id,
                    data: value,
                    method: "PUT"
                });
            };

            this.deleteUserItem = function (user) {
                var url = "/api/Users";
                var value = angular.toJson(user);
                $http({
                    url: url + "?id=" + user.user_id,
                    method: "DELETE"
                });

            };

            this.deleteCompItem = function (comp) {
                var url = "/api/Competitions";
                var value = angular.toJson(comp);
                $http({
                    url: url + "?id=" + comp.comp_id,
                    method: "DELETE"
                });
            };

            this.deleteCompLocItem = function (loc) {
                var url = "/api/Locations";
                var value = angular.toJson(loc);
                $http({
                    url: url + "?id=" + loc.comp_loc_id,
                    method: "DELETE"
                });
            };

            this.deleteUserItem = function (user) {
                var url = "/api/Users";
                var value = angular.toJson(user);
                $http({
                    url: url + "?id=" + user.userID,
                    method: "DELETE"
                });
            };

            this.deleteFAQItem = function (faq) {
                var url = "/api/FAQ";
                var value = angular.toJson(faq);
                $http({
                    url: url + "?id=" + faq.faq_id,
                    method: "DELETE"
                });
            };

            this.deleteSchoolItem = function (school) {
                var url = "/api/Schools";
                var value = angular.toJson(school);
                $http({
                    url: url + "?id=" + school.school_id,
                    method: "DELETE"
                });
            };
        });// End GetRESTService 

        adminApp.$inject = ['$scope', '$filter'];


        //$(".btn").on("click", function () {
        //    alert("Something");
        //});

        $('#myTabs a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });
        function guid() {
            function s4() {
                return Math.floor((1 + Math.random()) * 0x10000)
                  .toString(16)
                  .substring(1);
            }
            return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
              s4() + '-' + s4() + s4() + s4();
        }//end guid
    </script>
        <% if (System.Web.HttpContext.Current.User.IsInRole("Administrator")) {%>
      <!-- Tab panes -->

      <div class="tab-content">
        <div role="tabpanel" class="tab-pane fade in active" id="home">
            <h2>Admin Pages</h2>
            <div class="row">
                <div class="col-md-6">
                    <h4>Select a tab</h4>
                </div>
                <div class="col-md-6">
                    <h4>Add/Edit/Remove</h4>
                </div>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="competitions">
            <div ng-controller="CompTableController">
                <br />
                <div class="row">
                  <div class="col-md-3">
                    <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
                  </div>
                  <div class="col-md-6">
      	            
                  </div>
                  <div class="col-md-3">
                    <div class="input-group input-group-lg add-on">
                      <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search"/>
                      <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                      </div>
                    </div>
                  </div>
                </div>
                <br/>

            <div id="competitionModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="competitionModalLabel" aria-hidden="true">
            <div class="modal-dialog">
            <div class="modal-content">
	            <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			            <h3 id="competitionModalLabel">Competition</h3>
	            </div>
	            <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" ng-model=comp.name />
                          </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="date">Date</label>
                            <input type="date" class="form-control" id="date" value={{date}} />
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="date">Time</label>
                            <input type="time" class="form-control" id="time" value={{time}} />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="compLevel">Comp Level</label>
                            <select class="form-control" id="compLevel">
                                <option ng-repeat="level in levels" value={{level.id}}>{{level.value}}</option>
                            </select>
                          </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="compLocation">Comp Location</label>
                            <select class="form-control" id="compLocation">
                                <option ng-repeat="location in locations" value={{location.name}}>{{location.name}}</option>
                            </select>
                          </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="status">Status</label>
                            <select class="form-control" id="status">
                                <option ng-repeat="status in statuses" value={{status.id}}>{{status.value}}</option>
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
                            <textarea class="form-control" id="schedule" rows="5" ng-model=comp.schedule></textarea>
                          </div>
                        </div>
                    </div>      
                        
	            </div>
                
	            <div class="modal-footer">
 
		            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		            <button class="btn btn-primary" ng-click="update()" data-dismiss="modal" aria-hidden="true">SAVE CHANGES</button>

	            </div>
                
            </div>
            </div>
            </div>
    
                <table class="table table-striped table-hover">
                  <tbody><tr>
                    <th class="name"><a ng-click="sort_by('name')">Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="date"><a ng-click="sort_by('date')">Date<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="loc_name"><a ng-click="sort_by('loc_name')">Location<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="region"><a ng-click="sort_by('region')">Region<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="level"><a ng-click="sort_by('level')">Level<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="status"><a ng-click="sort_by('value')">Status<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="team_limit"><a ng-click="sort_by('perm_id')">Team Limit<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="note">Notes</th>
                    <th></th>
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
                        <td>{{item.name}}</td>
                        <td>{{item.date}}</td>
                        <td>{{item.loc_name}}</td>
                        <td>{{item.region}}</td>
                        <td>{{item.level}}</td>
                        <td>{{item.status}}</td> 
                        <td>{{item.team_limit}}</td>
                        <td>{{item.note}}</td>
                        <td><a id="edit_{{item.id}}" href="#" class="btn btn-primary btn-sm" ng-click="edit($index)">EDIT</a></td>
                        <td><a class="btn btn-danger btn-sm" href="#" ng-click="deleteItem($index)">X</a></td>
                    </tr>
                  </tbody>
                </table>
            </div>

            <div class="col-md-2 col-md-offset-10">
                    <a type="button" href="CompetitionCreation.aspx" class="btn btn-success btn-sm pull-right">ADD</a>
                </div>

        </div>
        <div role="tabpanel" class="tab-pane fade" id="complocations">
            <div ng-controller="CompLocTableController">
                <br />
                <div class="row">
                  <div class="col-md-3">
                    <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
                  </div>
                  <div class="col-md-6">
      	            
                  </div>
                  <div class="col-md-3">
                    <div class="input-group input-group-lg add-on">
                      <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search"/>
                      <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                      </div>
                    </div>
                  </div>
                </div>
                <br />
    
            <div id="competitionLocationModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="competitionLocationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
            <div class="modal-content">
	            <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			            <h3 id="competitionLocationModalLabel">Competition Location</h3>
	            </div>
	            <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="compLocName">Name</label>
                            <input type="text" class="form-control" id="compLocName" ng-model=compLoc.name />
                          </div>
                        </div>
                        <%--<div class="col-md-6">
                            <div class="form-group">
                            <label for="mapURL">Map URL</label>
                            <input type="text" class="form-control" id="mapURL" ng-model=compLoc.map_url />
                          </div>
                        </div>--%>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="compTableRegion">Region</label>
                            <select class="form-control" id="compTableRegion">
                                <option ng-repeat="region in regions" value={{region.id}}>{{region.region_name}}</option>
                            </select>
                          </div>
                        </div>
	            </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="addStreet">Street</label>
                            <input type="text" class="form-control" id="addStreet" ng-model=compLoc.street />
                          </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                            <label for="addCity">City</label>
                            <input type="text" class="form-control" id="addCity" ng-model=compLoc.city />
                          </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                            <label for="addState">State</label>
                            <input type="text" class="form-control" id="addState" ng-model=compLoc.state />
                          </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                            <label for="addZip">Zip</label>
                            <input type="text" class="form-control" id="addZip" ng-model=compLoc.zip />
                          </div>
                        </div>
                    </div>
	            <div class="modal-footer">
		            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		            <button class="btn btn-primary" ng-click="update()" data-dismiss="modal" aria-hidden="true">SAVE CHANGES</button>
                    </div>
	            </div>
            </div>
            </div>
            </div>

            <div id="addCompetitionLocationModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addCompetitionLocationModalLabel" aria-hidden="true">
            <div class="modal-dialog">
            <div class="modal-content">
	            <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			            <h3 id="addCompetitionLocationModalLabel">Competition Location</h3>
	            </div>
	            <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="addLocName">Name</label>
                            <input type="text" class="form-control" id="addLocName" ng-model=locationToPost.name />
                          </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="addLocRegion">Region</label>
                            <select class="form-control" id="addLocRegion">
                                <option ng-repeat="region in regions" value={{region.region_id}}>{{region.region_name}}</option>
                            </select>
                          </div>
                        </div>
	            </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="addLocStreet">Street</label>
                            <input type="text" class="form-control" id="addLocStreet" ng-model=addressToPost.street />
                          </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                            <label for="addLocCity">City</label>
                            <input type="text" class="form-control" id="addLocCity" ng-model=addressToPost.city />
                          </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                            <label for="addLocState">State</label>
                            <input type="text" class="form-control" id="addLocState" ng-model=addressToPost.state />
                          </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                            <label for="addLocZip">Zip</label>
                            <input type="text" class="form-control" id="addLocZip" ng-model=addressToPost.zip />
                          </div>
                        </div>
                    </div>
	            <div class="modal-footer">
		            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		            <button class="btn btn-primary" ng-click="post()" data-dismiss="modal" aria-hidden="true">ADD LOCATION</button>
                    </div>
	            </div>
            </div>
            </div>
            </div>
 
                <table class="table table-striped table-hover">
                  <tbody><tr>
                    <th class="id"><a ng-click="sort_by('id')">ID<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="name"><a ng-click="sort_by('name')">Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="region"><a ng-click="sort_by('region')">Region<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="Address">Address</th>
                    <th></th>
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
                         <td>{{item.id}}</td> 
                            <td>{{item.name}}</td> 
                            <td>{{item.region}}</td> 
                            <td>{{item.street}} {{item.city}} {{item.state}} {{item.zip}}</td> 
                            <td><a id="edit_{{item.id}}" ng-click="edit($index)" class="btn btn-primary btn-sm">EDIT</a></td>
                        <td><a class="btn btn-danger btn-sm" href="#" ng-click="deleteItem($index)">X</a></td>
                    </tr>
                  </tbody>
                </table>
                <div class="col-md-2 col-md-offset-10">
                    <a id="addLocationBtn" class="btn btn-success btn-md pull-right" ng-click="addModal()">ADD</a>
                </div>
            </div>

            
        </div>
        <div role="tabpanel" class="tab-pane fade" id="schools">
            <div ng-controller="SchoolsTableController">
                <br />
                <div class="row">
                  <div class="col-md-3">
                    <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
                  </div>
                  <div class="col-md-6">
      	            
                  </div>
                  <div class="col-md-3">
                    <div class="input-group input-group-lg add-on">
                      <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search"/>
                      <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                      </div>
                    </div>
                  </div>
                </div>
                <br/>

            <div id="schoolModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="schoolModalLabel" aria-hidden="true">
            <div class="modal-dialog">
            <div class="modal-content">
	            <div class="modal-header">
		            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			            <h3 id="schoolModalLabel">School</h3>
	            </div>
	            <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                            <label for="schoolName">Name</label>
                            <input type="text" class="form-control" id="schoolName" ng-model=school.name />
                          </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                            <label for="shortName">Short Name</label>
                            <input type="text" class="form-control" id="shortName" ng-model=school.short_name />
                          </div>
                        </div>
                        <div class="col-md-2">
                            <div class="form-group">
                            <label for="approval">Approval</label>
                            <input type="text" class="form-control" id="approval" ng-model=school.approved />
                          </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="schoolRegion">Region</label>
                            <select class="form-control" id="schoolRegion">
                                <option ng-repeat="region in regions" value={{region.id}}>{{region.region_name}}</option>
                            </select>
                          </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                            <label for="division">Division</label>
                            <input type="text" class="form-control" id="division" ng-model=school.division />
                          </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                            <label for="lastReg">Last Registration</label>
                            <input type="text" class="form-control" id="lastReg" ng-model=school.last_reg />
                          </div>
                        </div>
                    </div>
	            </div>
	            <div class="modal-footer">
		            <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		            <button class="btn btn-primary" ng-click="update()" data-dismiss="modal" aria-hidden="true">SAVE CHANGES</button>
                    </div>
	            </div>
            </div>
            </div><%--end School Modal--%>
            
            <div id="addSchoolModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addSchoolModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
	                    <div class="modal-header">
		                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                    <h3 id="addSchoolModalLabel">School</h3>
	                    </div>
	                    <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                    <label for="addSchoolName">Name</label>
                                    <input type="text" class="form-control" id="addSchoolName" ng-model=schoolToPost.name />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="addShortName">Short Name</label>
                                    <input type="text" class="form-control" id="addShortName" ng-model=schoolToPost.short_name />
                                  </div>
                                </div>
                            </div>
                            <br />
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                    <label class="control-label" for="addSchoolRegion">Region</label>
                                    <select class="form-control" id="addSchoolRegion">
                                        <option ng-repeat="region in regions" value={{region.region_id}}>{{region.region_name}}</option>
                                    </select>
                                  </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="addDivision">Division</label>
                                    <input type="text" class="form-control" id="addDivision" ng-model=schoolToPost.division />
                                  </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                    <label for="addApproval">Approval</label>
                                    <input type="text" class="form-control" id="addApproval" ng-model=school.approved />
                                  </div>
                        </div>
                            </div>
                            <div class="row">
                            <div class="col-md-6">
                                    <div class="form-group">
                                    <label for="schoolStreet">Street</label>
                                    <input type="text" class="form-control" id="schoolStreet" ng-model=addressToPost.street />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="schoolCity">City</label>
                                    <input type="text" class="form-control" id="schoolCity" ng-model=addressToPost.city />
                                  </div>
                                </div>
                                <div class="col-md-2">
                                    <div class="form-group">
                                    <label for="schoolState">State</label>
                                    <input type="text" class="form-control" id="schoolState" ng-model=addressToPost.state />
                                  </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="schoolZip">Zip</label>
                                    <input type="text" class="form-control" id="schoolZip" ng-model=addressToPost.zip />
                                  </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="schoolPhone">Phone</label>
                                    <input type="text" class="form-control" id="schoolPhone" ng-model=addressToPost.phone />
                                  </div>
                                </div>
                            </div>
	                    </div>
                            <div class="modal-footer">
		                        <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		                        <button class="btn btn-primary" ng-click="post()" data-dismiss="modal" aria-hidden="true">ADD SCHOOL</button>
                            </div>
	                    </div>
	                </div>
                </div>

    
                <table class="table table-striped table-hover">
                  <tbody><tr>
                    <th class="name"><a ng-click="sort_by('name')">Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="divison"><a ng-click="sort_by('divison')">Divison<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="short_name"><a ng-click="sort_by('short_name')">Short Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="last_reg"><a ng-click="sort_by('last_reg')">Last Registration<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="approved"><a ng-click="sort_by('approved')">Approved<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th></th>
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
                        <td>{{item.name}}</td> 
                        <td>{{item.division}}</td>
                        <td>{{item.short_name}}</td>
                        <td>{{item.last_reg}}</td>
                        <td>{{item.approved}}</td>
                        <td><a id="edit_{{item.id}}" ng-click="edit($index)" class="btn btn-primary btn-sm">EDIT</a></td>
                        <td><a class="btn btn-danger btn-sm" href="#" ng-click="deleteItem($index)">X</a></td>
                    </tr>
                  </tbody>
                </table>
                <div class="col-md-2 col-md-offset-10">
                    <a id="addSchoolBtn" class="btn btn-success btn-md pull-right" ng-click="addModal()">ADD</a>
                </div>
            
        </div>
            </div>
        <div role="tabpanel" class="tab-pane fade" id="coaches">
            <div ng-controller="CoachesTableController">
                <br />
                <div class="row">
                  <div class="col-md-3">
                    <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
                  </div>
                  <div class="col-md-6">
      	            
                  </div>
                  <div class="col-md-3">
                    <div class="input-group input-group-lg add-on">
                      <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search"/>
                      <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                      </div>
                    </div>
                  </div>
                </div>
                <br/>

                <div id="coachModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="coachModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
	                <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                <h3 id="coachModalLabel">Coach</h3>
	                </div>
	                <div class="modal-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                <label for="fName">First Name</label>
                                <input type="text" class="form-control" id="coachFName" ng-model=coach.firstName />
                              </div>
                            </div>
                            <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="lName">Last Name</label>
                                    <input type="text" class="form-control" id="coachLName" ng-model=coach.lastName />
                                  </div>
                                </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="uName">UserName</label>
                                    <input type="text" class="form-control" id="coachUserName" ng-model=coach.userName />
                                  </div>
                                </div>
                            <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="coachRole">Role</label>
                            <select class="form-control" id="coachRole">
                                <option ng-repeat="role in roles" value={{role.roleId}}>{{role.name}}</option>
                            </select>
                          </div>
                        </div>
	                </div>
	                <div class="modal-footer">
		                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		                <button class="btn btn-primary" ng-click="update()" data-dismiss="modal" aria-hidden="true">SAVE CHANGES</button>
                        </div>
	                </div>
                </div>
                </div>
                </div>
    
                <table class="table table-striped table-hover">
                  <tbody><tr>
                    <th class="user_name"><a ng-click="sort_by('user_name')">Username<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="fname"><a ng-click="sort_by('fname')">First Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="lname"><a ng-click="sort_by('lname')">Last Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="email"><a ng-click="sort_by('email')">Email<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="Role"><a ng-click="sort_by('userRole')">Role<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th></th>
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
                        <td>{{item.userName}}</td> 
                        <td>{{item.firstName}}</td> 
                        <td>{{item.lastName}}</td> 
                        <td>{{item.email}}</td>
                        <td>{{item.userRoles[0].role.name}}</td>
                        <td><a id="edit_{{item.id}}" ng-click="edit($index)" class="btn btn-primary btn-sm">EDIT</a></td>
                        <td><a class="btn btn-danger btn-sm" href="#" ng-click="deleteItem($index)">X</a></td>
                    </tr>
                  </tbody>
                </table>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="directors">
            <div ng-controller="DirTableController">
                <br />
                <div class="row">
                  <div class="col-md-3">
                    <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
                  </div>
                  <div class="col-md-6">
      	            
                  </div>
                  <div class="col-md-3">
                    <div class="input-group input-group-lg add-on">
                      <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search"/>
                      <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                      </div>
                    </div>
                  </div>
                </div>
                <br/>

                <div id="directorModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="directorModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
	                <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                <h3 id="directorModalLabel">Coach</h3>
	                </div>
	                <div class="modal-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                <label for="fName">First Name</label>
                                <input type="text" class="form-control" id="dirFName" ng-model=director.firstName />
                              </div>
                            </div>
                            <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="lName">Last Name</label>
                                    <input type="text" class="form-control" id="dirLName" ng-model=director.lastName />
                                  </div>
                                </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="uName">UserName</label>
                                    <input type="text" class="form-control" id="dirUserName" ng-model=director.userName />
                                  </div>
                                </div>
                            <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="dirRole">Role</label>
                            <select class="form-control" id="dirRole">
                                <option ng-repeat="role in roles" value={{role.roleId}}>{{role.name}}</option>
                            </select>
                          </div>
                        </div>
	                </div>
	                <div class="modal-footer">
		                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		                <button class="btn btn-primary" ng-click="update()" data-dismiss="modal" aria-hidden="true">SAVE CHANGES</button>
                        </div>
	                </div>
                </div>
                </div>
                </div>
    
                <table class="table table-striped table-hover">
                  <tbody><tr>
                    <th class="user_name"><a ng-click="sort_by('user_name')">Username<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="fname"><a ng-click="sort_by('fname')">First Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="lname"><a ng-click="sort_by('lname')">Last Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="email"><a ng-click="sort_by('email')">Email<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="Role"><a ng-click="sort_by('userRole')">Role<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th></th>
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
                        <td>{{item.userName}}</td> 
                        <td>{{item.firstName}}</td> 
                        <td>{{item.lastName}}</td> 
                        <td>{{item.email}}</td>
                        <td>{{item.role}}</td>
                        <td><a id="edit_{{item.id}}" ng-click="edit($index)" class="btn btn-primary btn-sm">EDIT</a></td>
                        <td><a class="btn btn-danger btn-sm" href="#" ng-click="deleteItem($index)">X</a></td>
                    </tr>
                  </tbody>
                </table>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="admins">
            <div ng-controller="AdminsTableController">
                <br />
                <div class="row">
                  <div class="col-md-3">
                    <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
                  </div>
                  <div class="col-md-6">
      	            
                  </div>
                  <div class="col-md-3">
                    <div class="input-group input-group-lg add-on">
                      <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search"/>
                      <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                      </div>
                    </div>
                  </div>
                </div>
                <br/>

                <div id="adminModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="adminModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
	                <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                <h3 id="adminModalLabel">Admin</h3>
	                </div>
	                	                <div class="modal-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                <label for="fName">First Name</label>
                                <input type="text" class="form-control" id="adminFName" ng-model=admin.firstName />
                              </div>
                            </div>
                            <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="lName">Last Name</label>
                                    <input type="text" class="form-control" id="adminLName" ng-model=admin.lastName />
                                  </div>
                                </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                    <div class="form-group">
                                    <label for="uName">UserName</label>
                                    <input type="text" class="form-control" id="adminUserName" ng-model=admin.userName />
                                  </div>
                                </div>
                            <div class="col-md-4">
                            <div class="form-group">
                            <label class="control-label" for="adminRole">Role</label>
                            <select class="form-control" id="adminRole">
                                <option ng-repeat="role in roles" value={{role.roleID}}>{{role.name}}</option>
                            </select>
                          </div>
                        </div>
	                </div>
	                <div class="modal-footer">
		                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		                <button class="btn btn-primary" ng-click="update()" data-dismiss="modal" aria-hidden="true">SAVE CHANGES</button>
                        </div>
	                </div>
                </div>
                </div>
                </div>
    
                <table class="table table-striped table-hover">
                  <tbody><tr>
                    <th class="user_name"><a ng-click="sort_by('user_name')">Username<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="fname"><a ng-click="sort_by('fname')">First Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="lname"><a ng-click="sort_by('lname')">Last Name<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="email"><a ng-click="sort_by('email')">Email<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="Role"><a ng-click="sort_by('userRole')">Role<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th></th>
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
                        <td>{{item.userName}}</td> 
                        <td>{{item.firstName}}</td> 
                        <td>{{item.lastName}}</td> 
                        <td>{{item.email}}</td>
                        <td>{{item.role}}</td>
                        <td><a id="edit_{{item.id}}" ng-click="edit($index)" class="btn btn-primary btn-sm">EDIT</a></td>
                        <td><a class="btn btn-danger btn-sm" href="#" ng-click="deleteItem($index)">X</a></td>
                    </tr>
                  </tbody>
                </table>
            </div>
        </div>
        <div role="tabpanel" class="tab-pane fade" id="faq">
            <div ng-controller="FAQTableController">
                <br />
                <div class="row">
                  <div class="col-md-3">
                    <select class="form-control input-lg pull-right" ng-model="itemsPerPage" ng-change="perPage()" ng-options="('show '+size+' per page') for size in pageSizes"></select>
                  </div>
                  <div class="col-md-6 col-lg-6">
      	            
                  </div>
                  <div class="col-md-3 col-lg-3">
                    <div class="input-group input-group-lg add-on">
                      <input type="text" class="form-control search-query" ng-model="query" ng-change="search()" placeholder="Search"/>
                      <div class="input-group-btn">
                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                      </div>
                    </div>
                  </div>
                </div>
                <br/>

                <div id="faqModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="faqModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
	                <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                <h3 id="faqModalLabel">FAQ</h3>
	                </div>
	                <div class="modal-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                <label for="faqLevel">Level</label>
                                <input type="text" class="form-control" id="faqLevel" ng-model=faq.level />
                              </div>
                            </div>
                        
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                <label for="faqQuestion">Question:</label>
                                    <textarea class="form-control" id="faqQuestion" rows="1" ng-model=faq.question></textarea>
                              </div>
                            </div>
                        
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                <label for="faqAnswer">Answer:</label>
                                <textarea class="form-control" id="faqAnswer" rows="3" ng-model=faq.answer></textarea>
                              </div>
                            </div>
	                </div>
	                <div class="modal-footer">
		                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		                <button class="btn btn-primary" ng-click="update()" data-dismiss="modal" aria-hidden="true">SAVE CHANGES</button>
                        </div>
	                </div>
                </div>
                </div>
                </div>

                <div id="addFaqModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addFaqModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                <div class="modal-content">
	                <div class="modal-header">
		                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			                <h3 id="addFaqModalLabel">FAQ</h3>
	                </div>
	                <div class="modal-body">
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                <label for="addFaqLevel">Level</label>
                                <input type="text" class="form-control" id="addFaqLevel" ng-model=faqToPost.level />
                              </div>
                            </div>
                        
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                <label for="addFaqQuestion">Question:</label>
                                    <textarea class="form-control" id="addFaqQuestion" rows="1" ng-model=faqToPost.question ></textarea>
                              </div>
                            </div>
                        
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                <label for="addFaqAnswer">Answer:</label>
                                <textarea class="form-control" id="addFaqAnswer" rows="3" ng-model=faqToPost.answer ></textarea>
                              </div>
                            </div>
	                </div>
	                <div class="modal-footer">
		                <button class="btn btn-danger" data-dismiss="modal" aria-hidden="true">CLOSE</button>
		                <button class="btn btn-primary" ng-click="post()" data-dismiss="modal" aria-hidden="true">ADD FAQ</button>
                        </div>
	                </div>
                </div>
                </div>
                </div>
    
                <table class="table table-striped table-hover">
                  <tbody><tr>
                    <th class="level"><a ng-click="sort_by('level')">Level<i class="glyphicon glyphicon-sort-by-attributes"></i></a></th>
                    <th class="question">Question</th>
                    <th class="answer">Answer</th>
                    <th></th>
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
                        <td>{{item.level}}</td> 
                        <td>{{item.question}}</td> 
                        <td>{{item.answer}}</td>
                        <td><a id="edit_{{item.id}}" ng-click="edit($index)" class="btn btn-primary btn-sm">EDIT</a></td>
                        <td><a class="btn btn-danger btn-sm" href="#" ng-click="deleteItem($index)">X</a></td>
                    </tr>
                  </tbody>
                </table>
                <div class="col-md-2 col-md-offset-10">
                    <a id="addFaq" ng-click="addModal()" class="btn btn-success btn-md pull-right">ADD</a>
                </div>
            </div> 
            </div>
        </div>
      </div>
    <% } %>
</asp:Content>
