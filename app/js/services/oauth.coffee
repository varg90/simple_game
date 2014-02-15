'use strict'
services = angular.module 'calendar.services'

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
      username: 'username_1'
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
