'use strict'

calendar = angular.module('calendar',
  ['ngRoute', 'calendar.controllers', 'calendar.filters', 'calendar.services', 'calendar.directives', 'infinite-scroll'])

angular.module 'calendar.controllers', ['ngAnimate', 'ui.date']
angular.module 'calendar.directives', ['ui.date']
angular.module 'calendar.services', ['ngResource']
angular.module 'calendar.filters', []

calendar.value 'urlSuffix', '.json'
calendar.value 'idParam', 'id'
calendar.value 'oAuthUrl', 'http://lvh.me:3000/api/v1/oauth/token'
calendar.value 'resourcesUrl', 'http://lvh.me:3000/api/v1/'

calendar.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/calendar',
    templateUrl: 'partials/calendar.html'
    controller: 'calendar'
  $routeProvider.when '/',
    templateUrl: 'partials/homepage.html'
  $routeProvider.when '/auth',
    controller: 'auth'
    templateUrl: 'partials/auth.html'

  $routeProvider.otherwise { redirectTo: '/' }
]

calendar.config(['$sceDelegateProvider', ($sceDelegateProvider)->
  $sceDelegateProvider.resourceUrlWhitelist(['self', 'http://lvh.me:3000/**'])
])

