'use strict'

describe 'Calendar controllers', ->
  beforeEach module('calendar.controllers')

  describe 'Calendar', ->
    scope = {}
    tasks = ['task1', 'task2']
    TaskFactory = { resource: -> all: -> tasks }

    beforeEach inject ($rootScope, $controller)->
        scope = $rootScope.$new()
        $controller('Calendar', { $scope: scope, TaskFactory: TaskFactory })

    it 'should get tasks', ->
      expect(scope.tasks).toBe(tasks)

