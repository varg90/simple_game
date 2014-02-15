'use strict'
controllers = angular.module 'calendar.controllers'


class CalendarController
  constructor: (@scope, @taskFactory, @params, @location, @week)->
    @scope.week = week
    @taskFactory.setIsApi(@params.store == 'api')

    @scope.$watch 'date', (newDate)=>
      @loadWeekTasks(newDate)

    if @params.date?
      @scope.date = moment(@params.date).toDate()

    @scope.offset = @offset
    @scope.length = @length
    @scope.currentDate = @currentDate
    @scope.factory = @taskFactory
    @scope.nextWeek = @nextWeek
    @scope.prevWeek = @prevWeek
    @scope.loadMore = @loadMore

    @reloadTasks()

  nextWeek: =>
    @week.nextWeek()
    @loadWeekTasks()
    @setSearchParams()

  prevWeek: =>
    @week.prevWeek()
    @loadWeekTasks()
    @setSearchParams()

  setSearchParams: =>
    @location.search('date', @week.firstDay().format("YYYY-MM-DD"))

  loadWeekTasks: (date = null)=>
    @week.updateDays(date) if date
    @taskFactory.resetPagination()
    @reloadTasks()

  reloadTasks: =>
    @scope.tasks = @taskFactory.all(@dateFilterParams())

  dateFilterParams: =>
    between_dates:
      start_date: @week.firstDay().format("YYYY-MM-DD")
      end_date: @week.lastDay().format("YYYY-MM-DD")

  loadMore: =>
    params = @dateFilterParams()
    params.page = @taskFactory.currentPage + 1
    @taskFactory.all params, @appendTasks

  appendTasks: (tasks)=>
    @scope.tasks = @scope.tasks.concat(tasks)

controllers.controller 'calendar', ['$scope', 'taskFactory', '$routeParams', '$location', 'oAuth', 'week'
  (scope, taskFactory, $routeParams, $location, oAuth, week) ->
    return $location.path('/auth') if $routeParams.store == 'api' and not oAuth.authenticated

    new CalendarController(scope, taskFactory, $routeParams, $location, week)
]
