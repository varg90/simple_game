'use strict'

describe 'filters', ->
  beforeEach module('calendar.filters')

  describe 'inWeek', ->
    beforeEach ->
      @days = [new Date(2014, 0, 20), new Date(2014, 0, 27)]
      inject ($filter)=>
        @filter = $filter('inWeek')

    describe 'before week', ->
      beforeEach ->
        @items = [{due_on: '2014-01-10', issued_on: '2014-01-01'}]

      it 'should filter', ->
        expect(@filter(@items, @days)).toEqual([])

    describe 'after week', ->
      beforeEach ->
        @items = [{due_on: '2014-02-03', issued_on: '2014-02-02'}]

      it 'should filter', ->
        expect(@filter(@items, @days)).toEqual([])

    describe 'issued in week', ->
      beforeEach ->
        @items = [{due_on: '2014-02-03', issued_on: '2014-01-20'}]

      it 'should filter', ->
        expect(@filter(@items, @days)).toEqual(@items)

    describe 'due in week', ->
      beforeEach ->
        @items = [{due_on: '2014-01-27', issued_on: '2014-01-01'}]

      it 'should filter', ->
        expect(@filter(@items, @days)).toEqual(@items)

    describe 'cover week', ->
      beforeEach ->
        @items = [{due_on: '2014-01-30', issued_on: '2014-01-01'}]

      it 'should filter', ->
        expect(@filter(@items, @days)).toEqual(@items)
