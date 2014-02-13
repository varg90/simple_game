'use strict'
services = angular.module 'calendar.services', ['ngResource']

class ObjectFactory
  constructor: (@$resource, @urlSuffix, @idParam, @url = '')->

  all: (query = {})->
    @model().all(query)

  model: ->
    @$resource("#{@resourcePath()}", {}, @actions())

  resourcePath: ->
    "#{@url}#{@objects_name()}/:#{@idParam}#{@urlSuffix}"

  actions: ->
    all:
      method: 'GET',
      params: { id: '' },
      transformResponse: @transformResponse
      isArray: true

  transformResponse: (data)=>
    angular.fromJson(data)[@objects_name()]

class TaskFactory extends ObjectFactory
  objects_name: ()-> 'class_tasks'


services.factory 'taskFactory', [
  '$resource', 'urlSuffix', 'idParam'
  ($resource, urlSuffix, idParam) -> new TaskFactory($resource, urlSuffix, idParam)
]


class oAuth
  constructor: (@http, @url, q)->
    @deferred = q.defer()

  promise: ->
    @deferred.promise

  auth: ->
    request = @http.post @url,
      grant_type: 'password'
      client_id: '123'
      client_secret: '123'
      username: 'username_12'
      password: 'password'
    @deferred.promise

    request.success (response)=>
      @http.defaults.headers.common.Authorization = "Bearer #{response.access_token}"
      @deferred.resolve()

    request.error =>
      @deferred.reject()


services.factory 'oAuth', [
  '$resource', '$http', 'oAuthUrl', '$q',
  ($resource, $http, url, $q) -> new oAuth($http, url, $q)
]
