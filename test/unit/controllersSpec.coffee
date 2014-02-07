'use strict'

describe 'Calendar controllers', ->
  beforeEach module('calendar.controllers')

  describe 'Calendar', ->
    scope = {}
    tasks = ['task1', 'task2']
    TaskStub = { all: -> tasks }

    beforeEach inject ($rootScope, $controller)->
        scope = $rootScope.$new()
        $controller('Calendar', { $scope: scope, Task: TaskStub })

    it 'should get tasks', ->
      expect(scope.tasks).toBe(tasks)

