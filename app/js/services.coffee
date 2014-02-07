'use strict'
services = angular.module 'calendar.services', []

class Task
  constructor: ()->

  @all: ()->
    [
      {
        'title' : 'Task one'
        'class' : '5a'
        'teacher' : 'Mr. Jackson'
      },
      {
        'title' : 'Task 2'
        'class' : '5a'
        'teacher' : 'Mr. Jackson'
      },
    ]


services.factory 'Task', -> Task
