'use strict'

describe 'Services', ->
  beforeEach module('calendar.services')

  describe 'TaskFactory', ->

    beforeEach ->
      @idParam = 'id'
      @urlSuffix = '.suffix'
      @resource = jasmine.createSpy('$resource')
      module ($provide)=>
        $provide.value('$resource', @resource)
        $provide.value('urlSuffix', @urlSuffix)
        $provide.value('idParam', @idParam)
        return

      inject ($injector)=>
        @TaskFactory = $injector.get('TaskFactory')

    it 'should set resources', ->
      expect(@TaskFactory.$resource).toBe(@resource)

    it 'should set url suffix', ->
      expect(@TaskFactory.urlSuffix).toBe(@urlSuffix)

    it 'should set id param', ->
      expect(@TaskFactory.idParam).toBe(@idParam)

    it 'should have objects name', ->
      expect(@TaskFactory.objects_name()).toBe('class_tasks')

    it 'should set resource url', ->
      expect(@TaskFactory.resourcePath()).toBe('class_tasks/:id.suffix')

    it 'should transform response', ->
      json = "{\"class_tasks\":[\"value\"]}"
      expect(@TaskFactory.transformResponse(json)[0]).toBe('value')
      expect(@TaskFactory.transformResponse(json).length).toBe(1)

    describe '#actions', ->
      beforeEach ->
        @actions =
          all:
            method: 'GET',
            params: { id: 'index' },
            transformResponse: {}
            isArray: true

      it 'should set resource actions', ->
        @TaskFactory.transformResponse = {}
        expect(@TaskFactory.actions()).toEqual(@actions)

    describe '#resource', ->
      it 'should call $resource', ->
        @TaskFactory.resourcePath = -> 'path'
        @TaskFactory.actions = -> {}
        @TaskFactory.resource()
        expect(@resource.calls.length).toBe(1)
        expect(@resource).toHaveBeenCalledWith('path', {}, {})
