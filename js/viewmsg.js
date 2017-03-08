var app = angular.module('myApp', []);
  app.controller('customersCtrl', function($scope, $http) {
  $http.get("getmsg.jsp").then(function (response) {
    console.log(response);
    $scope.msg = response.data.Responsemsg;
  });
 });
