'use strict'
services = angular.module 'calendar.services'

class Week
  constructor: (@startDate = new Date)->
    @updateDays()

  updateDays: (dayOfWeek = null)->
    @startDate = dayOfWeek if dayOfWeek
    @days = (moment(@startDate).startOf('day').isoWeekday(day) for day in [1..7])

  nextWeek: ->
    date = moment(@days[@days.length-1]).add(1, 'week').toDate()
    @updateDays(date)

  prevWeek: ->
    date = moment(@days[0]).subtract(1, 'week').toDate()
    @updateDays(date)

  firstDay: ->
    @days[0]

  lastDay: ->
    @days[@days.length-1]

  currentDate: (day)=>
    if day.isSame(moment().startOf('day')) then 'current' else ''


services.factory 'week', [
  () -> new Week
]
