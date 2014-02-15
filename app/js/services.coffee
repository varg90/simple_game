'use strict'
services = angular.module 'calendar.services', ['ngResource']

class ObjectFactory
  constructor: (@$resource, @defaultUrlSuffix, @idParam, @defaultUrl )->
    @currentPage = 0
    @loadMore = true
    @setIsApi(false)

  all: (query = {}, callback = =>)->
    @loadMore = false
    @model().all(query, callback)

  model: ->
    @$resource("#{@resourcePath()}", {}, @actions())

  resourcePath: ->
    "#{@url}#{@objects_name()}/:#{@idParam}#{@urlSuffix}"

  setIsApi: (isApi = true)->
    @isApi = isApi
    if @isApi
      @url = @defaultUrl
      @urlSuffix = ''
    else
      @url = ''
      @urlSuffix = @defaultUrlSuffix


  actions: ->
    all:
      method: 'GET',
      params: { id: '' },
      transformResponse: @transformResponse
      isArray: true

  resetPagination: ()->
    @currentPage = 0
    @loadMore = true

  transformResponse: (data)=>
    parsed_json = angular.fromJson(data)
    @_applyMetadata(parsed_json.metadata) if parsed_json.metadata?
    parsed_json[@objects_name()]

  _applyMetadata: (data)->
    @currentPage = data.page
    @totalItems = data.total_items
    @perPage = data.per_page
    @loadMore = (@totalItems - @currentPage * @perPage) > 0

class TaskFactory extends ObjectFactory
  objects_name: ()-> 'class_tasks'


services.factory 'taskFactory', [
  '$resource', 'urlSuffix', 'idParam', 'resourcesUrl'
  ($resource, urlSuffix, idParam, resourcesUrl) -> new TaskFactory($resource, urlSuffix, idParam, resourcesUrl)
]


class oAuth
  constructor: (@http, @url, q)->
    @deferred = q.defer()
    @authenticated = false

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
      @authenticated = true
      @deferred.resolve()

    request.error =>
      @authenticated = false
      @deferred.reject()


services.factory 'oAuth', [
  '$resource', '$http', 'oAuthUrl', '$q',
  ($resource, $http, url, $q) -> new oAuth($http, url, $q)
]
