'use strict'
controllers = angular.module 'calendar.controllers', ['ngAnimate']


class CalendarController
  constructor: (@scope, @taskFactory, @params, urlSuffix, resourcesUrl)->
    @scope.tasks = @taskFactory.resource().all()
    @scope.days = @days()
    @scope.offset = @offset
    @scope.length = @length
    @scope.currentDate = @currentDate
    if @params.store == 'api'
      @taskFactory.url = resourcesUrl
      @taskFactory.urlSuffix = ''
    else
      @taskFactory.url = ''
      @taskFactory.urlSuffix = urlSuffix

  days: =>
    @_days ||= (moment().startOf('day').isoWeekday(day).toDate() for day in [1..7])

  currentDate: (day)=>
    day == moment().startOf('day').toDate() ? 'current': ''


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
