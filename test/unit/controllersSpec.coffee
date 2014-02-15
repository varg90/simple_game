'use strict'

describe 'Controllers', ->
  beforeEach module('calendar.controllers')

  describe 'calendar', ->
    routeParams = {}

    beforeEach ->
      @tasks = ['task1', 'task2']
      @taskFactory = { all: => @tasks }
      @location = { path: {} }
      @oAuth = { authenticated: true }

      @resourcesUrl = 'http://host.com'
      @urlSuffix = '.json'
      inject ($rootScope, $controller)=>
        @scope = $rootScope.$new()
        $controller('calendar',
          taskFactory: @taskFactory
          $scope: @scope
          $routeParams: routeParams
          resourcesUrl: @resourcesUrl
          urlSuffix: @urlSuffix
          $location: @location
          oAuth: @oAuth
        )

    describe 'local', ->
      it 'should get tasks', ->
        expect(@scope.tasks).toBe(@tasks)

      it 'should set url', ->
        expect(@taskFactory.url).toBe('')

      it 'should set url', ->
        expect(@taskFactory.urlSuffix).toBe(@urlSuffix)

    describe 'API', ->
      beforeEach ->
        routeParams = {store: 'api'}

      it 'should get tasks', ->
        expect(@scope.tasks).toBe(@tasks)

      it 'should set url', ->
        expect(@taskFactory.url).toBe(@resourcesUrl)

      it 'should set url', ->
        expect(@taskFactory.urlSuffix).toBe('')



  describe 'auth', ->
    beforeEach ->
      @search = { search: jasmine.createSpy('search') }
      @location = { path: => @search }
      spyOn(@location, 'path').andCallThrough()

      @oAuth = { auth: => then: (success, error)=> @success = success; @error = error }
      spyOn(@oAuth, 'auth').andCallThrough()

      @urlSuffix = '.json'

      inject ($rootScope, $controller)=>
        @scope = $rootScope.$new()
        @authController = $controller('auth',
          $scope: @scope
          $location: @location
          oAuth: @oAuth
        )

    it 'should auth', ->
      expect(@oAuth.auth).toHaveBeenCalled()

    describe '#error', ->
      it 'should set fail state', ->
        @authController.error()
        expect(@scope.failed).toBe(true)

    describe '#success', ->
      it 'should set change location', ->
        @authController.success()
        expect(@location.path).toHaveBeenCalledWith('/calendar')
        expect(@search.search).toHaveBeenCalledWith('store', 'api')



