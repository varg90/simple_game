'use strict'
angular.module('calendar.directives', [])
  .directive('appVersion', [
    'version',
    (version) ->
      (scope, elm, attrs) -> elm.text version
  ])
