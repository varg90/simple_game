'use strict'
controllers = angular.module 'calendar.controllers', []


class CalendarController
  constructor: (@scope, TaskFactory)->
    @scope.tasks = TaskFactory.resource().all()


controllers.controller 'Calendar', ['$scope', 'TaskFactory', (scope, TaskFactory) ->
    new CalendarController(scope, TaskFactory)
  ]
