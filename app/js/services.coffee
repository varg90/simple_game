'use strict'
services = angular.module 'calendar.services', ['ngResource']

class ObjectFactory
  constructor: (@$resource, @urlSuffix, @idParam)->

  resource: ->
    @$resource(@resourcePath(), {}, @actions())

  resourcePath: ->
    "#{@objects_name()}/:#{@idParam}#{@urlSuffix}"

  actions: ->
    all:
      method: 'GET',
      params: { id: 'index' },
      transformResponse: @transformResponse
      isArray: true

  transformResponse: (data)=>
    angular.fromJson(data)[@objects_name()]

class TaskFactory extends ObjectFactory
  objects_name: ()-> 'class_tasks'


services.factory 'TaskFactory', [
  '$resource', 'urlSuffix', 'idParam',
  ($resource, urlSuffix, idParam) -> new TaskFactory($resource, urlSuffix, idParam)
]
