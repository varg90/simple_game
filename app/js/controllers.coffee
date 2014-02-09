'use strict'
controllers = angular.module 'calendar.controllers', ['ngAnimate']


class CalendarController
  constructor: (@scope, TaskFactory)->
    @scope.tasks = TaskFactory.resource().all()
    @scope.days = @days()
    @scope.offset = @offset
    @scope.length = @length

  days: =>
    @_days ||= (moment().isoWeekday(day).toDate() for day in [0..6])



controllers.controller 'Calendar', ['$scope', 'TaskFactory', (scope, TaskFactory) ->
    new CalendarController(scope, TaskFactory)
  ]
