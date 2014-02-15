'use strict'
m = angular.module 'calendar.directives'

class CalendarDatePicker
  templateUrl: 'partials/calendar_date_picker.html'

  rowClass: (task)=>
    =>
      "col-md-#{@length(task) * 2} col-md-offset-#{@offset(task) * 2}"

  link: (scope)=>
    scope.formattedDate = @formatDate(scope.week)
    scope.$watch 'date', =>
      scope.formattedDate = @formatDate(scope.week)
    scope.dateOptions = {
      showOn: "button"
      buttonImage: "img/calendar.png"
      buttonImageOnly: true
    }

  formatDate: (week)=>
    return unless week?
    dateString = moment(week.firstDay()).format('Do - ')
    dateString += moment(week.lastDay()).format('Do MMMM, YYYY')

m.directive 'calendarDatePicker', ->
  new CalendarDatePicker


