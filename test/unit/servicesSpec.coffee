'use strict'

describe 'Services', ->
  beforeEach module('calendar.services')

  describe 'taskFactory', ->

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
        @taskFactory = $injector.get('taskFactory')

    it 'should set resources', ->
      expect(@taskFactory.$resource).toBe(@resource)

    it 'should set url suffix', ->
      expect(@taskFactory.urlSuffix).toBe(@urlSuffix)

    it 'should set id param', ->
      expect(@taskFactory.idParam).toBe(@idParam)

    it 'should have objects name', ->
      expect(@taskFactory.objects_name()).toBe('class_tasks')

    it 'should set resource url', ->
      expect(@taskFactory.resourcePath()).toBe('class_tasks/:id.suffix')

    it 'should transform response', ->
      json = "{\"class_tasks\":[\"value\"]}"
      expect(@taskFactory.transformResponse(json)[0]).toBe('value')
      expect(@taskFactory.transformResponse(json).length).toBe(1)

    describe '#actions', ->
      beforeEach ->
        @actions =
          all:
            method: 'GET',
            params: { id: '' },
            transformResponse: {}
            isArray: true

      it 'should set resource actions', ->
        @taskFactory.transformResponse = {}
        expect(@taskFactory.actions()).toEqual(@actions)

    describe '#resource', ->
      it 'should call $resource', ->
        @taskFactory.resourcePath = -> 'path'
        @taskFactory.actions = -> {}
        @taskFactory.model()
        expect(@resource.calls.length).toBe(1)
        expect(@resource).toHaveBeenCalledWith('path', {}, {})

    describe '#_applyMetadata', ->
      beforeEach ->
        @data = { total_items: 20, per_page: 10, page: 1}
        @taskFactory._applyMetadata(@data)

      it 'should set current page', ->
        expect(@taskFactory.currentPage).toBe(1)

      it 'should set total items', ->
        expect(@taskFactory.totalItems).toBe(20)

      it 'should set per page', ->
        expect(@taskFactory.perPage).toBe(10)

      it 'should we need to load more', ->
        expect(@taskFactory.loadMore).toBe(true)

      describe 'no more loading', ->
        beforeEach ->
          @data = {total_items: 20, per_page: 10, page: 2}
          @taskFactory._applyMetadata(@data)

        it 'should not need to load more', ->
          expect(@taskFactory.loadMore).toBe(false)

