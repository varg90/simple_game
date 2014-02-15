'use strict'
controllers = angular.module 'calendar.controllers', ['ngAnimate']


class CalendarController
  constructor: (@scope, @taskFactory, @params, @location)->
    @scope.days = @days()
    @taskFactory.setIsApi(@params.store == 'api')

    if @params.date?
      @loadWeek(moment(@params.date))

    @scope.offset = @offset
    @scope.length = @length
    @scope.currentDate = @currentDate
    @scope.factory = @taskFactory
    @scope.nextWeek = @nextWeek
    @scope.prevWeek = @prevWeek
    @scope.loadMore = @loadMore

    @reloadTasks()

  days: (startsOn = new Date)=>
    @_days = (moment(startsOn).startOf('day').isoWeekday(day) for day in [1..7])

  currentDate: (day)=>
    day == moment().startOf('day') ? 'current': ''

  nextWeek: =>
    date = moment(@_days[@_days.length-1]).add(1, 'week')
    @loadWeek(date)
    @location.search('date', date.format("YYYY-MM-DD"))

  prevWeek: =>
    date = moment(@_days[0]).subtract(1, 'week')
    @loadWeek(date)
    @location.search('date', date.format("YYYY-MM-DD"))

  loadWeek: (date)=>
    @scope.days = @days(date)
    @taskFactory.resetPagination()
    @reloadTasks()

  reloadTasks: =>
    @scope.tasks = @taskFactory.all(@dateFilterParams())

  dateFilterParams: =>
    between_dates:
      start_date: @_days[0].format("YYYY-MM-DD")
      end_date: @_days[@_days.length-1].format("YYYY-MM-DD")

  loadMore: =>
    params = @dateFilterParams()
    params.page = @taskFactory.currentPage + 1
    @taskFactory.all params, @appendTasks

  appendTasks: (tasks)=>
    @scope.tasks = @scope.tasks.concat(tasks)

controllers.controller 'calendar', ['$scope', 'taskFactory', '$routeParams', '$location', 'oAuth'
  (scope, taskFactory, $routeParams, $location, oAuth) ->
    return $location.path('/auth') if $routeParams.store == 'api' and not oAuth.authenticated

    new CalendarController(scope, taskFactory, $routeParams, $location)
]

class AuthController
  constructor: (@scope, @location, @oAuth)->
    @oAuth.auth().then @success, @error

  success: =>
    @location.path('/calendar').search('store', 'api')

  error: =>
    @scope.failed = true

controllers.controller 'auth', ['$scope', '$location', 'oAuth', ($scope, $location, oAuth)->
  new AuthController($scope, $location, oAuth)
]
