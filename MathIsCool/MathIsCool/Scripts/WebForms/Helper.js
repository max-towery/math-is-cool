var myApp = angular.module('MathIsCoolApp', []).controller('Controller', function ($scope, $GetRESTService) {
    debugger;
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
    debugger;
    this.getNewsItems = function () {
        var url = "/api/News";
        return $http({
            url: url,
            method: "GET"
        });
    };
});// Gets News Items 