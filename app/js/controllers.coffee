'use strict'
controllers = angular.module 'calendar.controllers', []

controllers.controller 'Calendar', ['$scope', 'Task', ($scope, Task) ->
    $scope.tasks = Task.all()
  ]
