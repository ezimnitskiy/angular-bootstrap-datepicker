dp = angular.module('ng-bootstrap-datepicker', [])

dp.directive 'ngDatepicker', ->
  restrict: 'A'
  require: '?ngModel'
  scope:
    ngDatepicker: '='
    ngModel: '='
  link: ($scope, element, controller) ->
    options = $scope.ngDatepicker or {}
    $scope.inputHasFocus = false
    element.datepicker(options).on 'changeDate', ($event) ->
      if !$scope.$$phase and !$scope.$root.$$phase
        return $scope.$apply(->
          controller.$setViewValue($event.date)
        )
      return
    element.on('focus', ->
      $scope.inputHasFocus = true
    ).on 'blur', ->
      $scope.inputHasFocus = false
    if $scope.ngModel
      element.datepicker 'setDate', $scope.ngModel
    $scope.$watch 'ngModel', (value) ->
      if !$scope.inputHasFocus
        return element.datepicker('update', value)
      return