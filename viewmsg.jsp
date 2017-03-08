<html>
  <head>
    <meta charset="utf-8">
    <title>messsages</title>
    <script src="js/jquery.js"></script>
		<script src="js/angular.js"></script>
    <script src="js/viewmsg.js"></script>
  </head>
  <body>
    <style>
      table, th , td  {
      border: 1px solid grey;
      border-collapse: collapse;
      padding: 5px;
      }
      table tr:nth-child(odd) {
      background-color: #e3f51a;
      }
      table tr:nth-child(even) {
      background-color: #4642f9;
      }
    </style>

    <script>
    var app = angular.module('myApp', []);
      app.controller('customersCtrl', function($scope, $http) {
      $http.get("getmsg.jsp").then(function (response) {
        console.log(response);
        $scope.msg = response.data.Responsemsg;
      });
     });
    </script>

    <div ng-app="myApp" ng-controller="customersCtrl">

          <table>
            <tr ng-repeat="x in msg">
              <td>{{x.id}}</td>
              <td>{{x.author}}</td>
              <td>{{x.title}}</td>
              <td>{{x.content}}</td>
            </tr>
          </table>

    </div>
  </body>
</html>
