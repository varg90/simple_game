'use strict'
controllers = angular.module 'calendar.controllers', ['ngAnimate']


class CalendarController
  constructor: (@scope, @taskFactory, @params, urlSuffix, resourcesUrl)->
    @scope.days = @days()
    if @params.store == 'api'
      @taskFactory.url = resourcesUrl
      @taskFactory.urlSuffix = ''
    else
      @taskFactory.url = ''
      @taskFactory.urlSuffix = urlSuffix

    @scope.offset = @offset
    @scope.length = @length
    @scope.currentDate = @currentDate
    @scope.factory = @taskFactory
    @scope.nextWeek = @nextWeek
    @scope.prevWeek = @prevWeek
    @scope.loadMore = @loadMore
    @scope.tasks = []

  days: (startsOn = new Date)=>
    @_days = (moment(startsOn).startOf('day').isoWeekday(day).toDate() for day in [1..7])

  currentDate: (day)=>
    day == moment().startOf('day').toDate() ? 'current': ''

  nextWeek: =>
    firstDay = moment(@_days[@_days.length-1]).add(1, 'day').toDate()
    @scope.days = @days(firstDay)
    @reloadTasks()

  prevWeek: =>
    lastDay = moment(@_days[0]).subtract(1, 'day').toDate()
    @scope.days = @days(lastDay)
    @reloadTasks()

  reloadTasks: =>
    @scope.tasks = @taskFactory.all(@dateFilterParams())

  dateFilterParams: =>
    between_dates:
      start_date: @_days[0]
      end_date: @_days[@_days.length-1]

  loadMore: =>
    params = @dateFilterParams()
    params.page = @taskFactory.currentPage + 1
    @taskFactory.all params, (tasks)=>
      @scope.tasks = @scope.tasks.concat(tasks)

controllers.controller 'calendar', ['$scope', 'taskFactory', '$routeParams', 'resourcesUrl', 'urlSuffix'
  (scope, taskFactory, $routeParams, resourcesUrl, urlSuffix) ->
    new CalendarController(scope, taskFactory, $routeParams, urlSuffix, resourcesUrl)
]

class AuthController
  constructor: (@scope, @location, @oAuth)->
    @oAuth.auth().then @success, @error

  success: =>
    @location.path('/calendar').search(store: 'api')

  error: =>
    @scope.failed = true

controllers.controller 'auth', ['$scope', '$location', 'oAuth', ($scope, $location, oAuth)->
  new AuthController($scope, $location, oAuth)
]
