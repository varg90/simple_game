'use strict'
angular.module('myApp',['ngRoute','myApp.filters','myApp.services','myApp.directives','myApp.controllers'])
  .config ['$routeProvider', ($routeProvider) ->
    $routeProvider.when '/view1',
      templateUrl: 'partials/partial1.html'
      controller: 'MyCtrl1'
    $routeProvider.when '/view2',
      templateUrl: 'partials/partial2.html'
      controller: 'MyCtrl2'
]