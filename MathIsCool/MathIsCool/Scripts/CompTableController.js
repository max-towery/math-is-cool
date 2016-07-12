
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
    //push current Level and status first.
    debugger;
    var levels = $GetRESTService.getCompLevelsItems();
    levels.then(function (response) {
        angular.forEach(response.data, function (level) {
            if (level != null) {
                $scope.levels.push(level);
            }
        });
    }, function (data, status, headers, config) {
        alert("Error: getting Levels in CompTableController ", data, status);
    });

    var statuses = $GetRESTService.getStatusItems();
    statuses.then(function (response) {
        angular.forEach(response.data, function (status) {
            if (status != null) {
                $scope.statuses.push(status);
            }
        });
    }, function (data, status, headers, config) {
        alert("Error: getting statuses in CompTableController ", data, status);
    });

    var tasksProm1 = $GetRESTService.getCompItems();
    tasksProm1.then(function (response) {
        angular.forEach(response.data, function (row) {
            if (row != null) {
                $scope.items.push(row);
            }
        });
    }, function (data, status, headers, config) {
        alert("Error: getting Competitions in CompTableController ", data, status);
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
        debugger;
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
        debugger;

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
    $scope.search();

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
        $('#competitionModal').modal({
            show: 'true'
        });
    }

    $scope.update = function () {
        $GetRESTService.putCompItem($scope.comp);
    }
    $("#compLevel").change(function () {
        $scope.comp.level_id = parseInt($('#compLevel').val());
    });
    $("#status").change(function () {
        $scope.comp.status_id = parseInt($('#status').val());
    });
});

adminApp.service('$GetRESTService', function ($q, $http) {
    this.getUsersItems = function () {
        var url = "/api/Users";
        return $http({
            url: url,
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

    this.putCompItem = function (comp) {
        var url = "/api/Competitions";
        var value = angular.toJson(comp);
        debugger;
        $http({
            url: url + "?id=" + comp.comp_id,
            data: value,
            method: "PUT"
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

    this.deleteUserItem = function (user) {
        var url = "/api/Users";
        var value = angular.toJson(user);
        debugger;
        $http({
            url: url + "?id=" + user.user_id,
            method: "DELETE"
        });

    };

    this.deleteCompItem = function (comp) {
        var url = "/api/Competitions";
        var value = angular.toJson(comp);
        debugger;
        $http({
            url: url + "?id=" + comp.comp_id,
            method: "DELETE"
        });

    };
});