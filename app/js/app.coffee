'use strict'

calendar = angular.module('calendar',
  ['ngRoute', 'calendar.controllers', 'calendar.filters', 'calendar.services', 'calendar.directives'])

calendar.value 'urlSuffix', '.json'
calendar.value 'idParam', 'id'

calendar.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/calendar',
    templateUrl: 'partials/calendar.html'
    controller: 'Calendar'

  $routeProvider.otherwise { redirectTo: '/calendar' }
]
