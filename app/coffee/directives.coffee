'use strict'
angular.module('myApp.derictives',[])
  .directive('appVersion',[
    'versioin',
    (version)->(scope, elm, attrs)-> elm.text version
  ])