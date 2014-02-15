'use strict'
controllers = angular.module 'calendar.controllers'

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
