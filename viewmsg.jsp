<html>
  <head>
    <meta charset="utf-8">
    <title>messsages</title>
    <script src="js/jquery.js"></script>
		<script src="js/angular.js"></script>
    <script src="js/viewmsg.js"></script>
    <link rel=stylesheet type="text/css" href="css/viewmsg.css">
  </head>
  <body>

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
