dp = angular.module('ng-bootstrap-datepicker', [])

dp.directive 'ngDatepicker', ->
  restrict: 'A'
  require: '?ngModel'
  scope: ngDatepicker: '='
  link: ($scope, element, attrs, controller) ->
    updateModel = undefined
    onblur = undefined
    if controller != null

      updateModel = (event) ->
        element.datepicker 'hide'
        element.blur()
        return

      onblur = ->
        date = element.val()
        $scope.$apply ->
          controller.$setViewValue date

      controller.$render = ->
        date = controller.$viewValue
        if angular.isDefined(date) and date != null and angular.isDate(date)
          element.datepicker().data().datepicker.date = date
          element.datepicker 'setValue'
          element.datepicker 'update'
        else if angular.isDefined(date)
          throw new Error('ng-Model value must be a Date object - currently it is a ' + typeof date + ' - use ui-date-format to convert it from a string')
        controller.$viewValue

    attrs.$observe 'ngDatepicker', ->
      options = $scope.ngDatepicker or {}
      element.datepicker(options).on('changeDate', updateModel).on 'blur', onblur
