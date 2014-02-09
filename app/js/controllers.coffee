'use strict'
controllers = angular.module 'calendar.controllers', ['ngAnimate']


class CalendarController
  constructor: (@scope, TaskFactory)->
    @scope.tasks = TaskFactory.resource().all()
    @scope.days = @days()
    @scope.offset = @offset
    @scope.length = @length
    @scope.currentDate = @currentDate

  days: =>
    @_days ||= (moment().startOf('day').isoWeekday(day).toDate() for day in [1..7])

  currentDate: (day)=>
    day == moment().startOf('day').toDate() ? 'current' : ''




controllers.controller 'Calendar', ['$scope', 'TaskFactory', (scope, TaskFactory) ->
    new CalendarController(scope, TaskFactory)
  ]
