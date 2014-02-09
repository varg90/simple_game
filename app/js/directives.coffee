'use strict'
m = angular.module('calendar.directives', [])

class CalendarRow
  templateUrl: 'partials/calendar_row.html'

  rowClass: (task)=>
    "col-md-#{@length(task) * 2} col-md-offset-#{@offset(task) * 2}"

  link: (scope)=>
    @days = scope.days
    scope.rowClass = @rowClass

  offset: (task)=>
    issuedOn = moment(task.issued_on).toDate()
    offset = 0
    for day in @days
      if issuedOn > day
        offset++
      else
        break
    offset

  length: (task)=>
    issuedOn = moment(task.issued_on).toDate()
    dueOn = moment(task.due_on).toDate()
    length = 0
    for day in @days
      if day >= issuedOn and day <= dueOn
        length++
    length

m.directive 'calendarRow', ->
  new CalendarRow

