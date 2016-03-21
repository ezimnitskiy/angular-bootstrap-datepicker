dp = angular.module('ng-bootstrap-datepicker', [])

restrict: 'A'
require: '?ngModel'
scope:
  ngDatepicker: '='
  ngModel: '='
link: ($scope, element, attrs, controller) ->

  updateModel = ($event) ->
    element.datepicker 'hide'
    element.blur()
    return

  onblur = ->
    date = undefined
    date = element.val()
    $scope.$apply ->
      controller.$setViewValue date

  if controller != null

    controller.$render = ->
      date = undefined
      date = controller.$viewValue
      if angular.isDefined(date) and date != null and angular.isDate(date)
        element.datepicker().data().datepicker.date = date
        element.datepicker 'setValue'
        element.datepicker 'update'
      else if angular.isDefined(date)
        throw new Error('ng-Model value must be a Date object - currently it is a ' + typeof date + ' - use ui-date-format to convert it from a string')
      controller.$viewValue

  if $scope.ngModel
    element.datepicker 'setDate', $scope.ngModel
  attrs.$observe 'ngDatepicker', ->
    options = undefined
    options = $scope.ngDatepicker or {}
    element.datepicker(options).on('changeDate', updateModel).on 'blur', onblur

