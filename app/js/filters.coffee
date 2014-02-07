'use strict'
angular.module('calendar.filters', [])
  .filter('interpolate', [
    'version',
    (version) ->
      (text) -> String(text).replace /\%VERSION\%/mg, version
  ])

