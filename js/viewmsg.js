
var app = angular.module('myApp', []);
  app.controller('customersCtrl', function($scope, $http) {
    $http.post("getmsg.jsp").then(function (response) {
      //console.log(response);
      $scope.msg = response.data.Responsemsg;
    });

    $scope.remove = function($index,msgid) {
      //直接刪除陣列
      $scope.msg.splice( $index, 1 );

      //丟id到後端進行刪除資料庫
      $scope.msgid=msgid;

      var data = {"deleteindex" : $scope.msgid};
	    $http.post('deletemsg.jsp', data );
    	/*.success(function(data, status) {
    		console.log(status);
    	})
    	.error(function(data, status) {
    		console.log(status);
    	});*/
    };

 });
