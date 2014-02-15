'use strict'

describe 'Controllers', ->
  beforeEach module('calendar.controllers')

  describe 'calendar', ->
    routeParams = {}

    beforeEach ->
      @tasks = ['task1', 'task2']
      @taskFactory = { all: (=> @tasks), setIsApi: => }
      spyOn(@taskFactory, 'setIsApi')
      @location = { path: {} }
      @oAuth = { authenticated: true }
      @week = { firstDay: (=> { format: => 'Date' }), lastDay: (=> { format: => 'Date' }) }

      inject ($rootScope, $controller)=>
        @scope = $rootScope.$new()
        $controller('calendar',
          taskFactory: @taskFactory
          $scope: @scope
          $routeParams: routeParams
          $location: @location
          oAuth: @oAuth
          week: @week
        )

    describe 'local', ->
      it 'should get tasks', ->
        expect(@scope.tasks).toBe(@tasks)

      it 'should set is api to false', ->
        expect(@taskFactory.setIsApi).toHaveBeenCalledWith(false)

    describe 'API', ->
      beforeEach ->
        routeParams = {store: 'api'}

      it 'should get tasks', ->
        expect(@scope.tasks).toBe(@tasks)

      it 'should set is api to true', ->
        expect(@taskFactory.setIsApi).toHaveBeenCalledWith(true)


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



