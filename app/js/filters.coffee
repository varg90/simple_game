'use strict'
m = angular.module('calendar.filters', [])

m.filter 'inWeek', ()->
  (items, days)->
    filtered = []
    firstDay = days[0]
    lastDay = days[days.length - 1]
    for item in items
      if moment(item.due_on).toDate() >= firstDay and moment(item.issued_on).toDate() <= lastDay
        filtered.push item
    filtered
