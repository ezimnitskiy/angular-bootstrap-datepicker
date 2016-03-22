angular.module('ui-bootstrap-datepicker', []).directive 'uiDatepicker', [
  '$timeout'
  ($timeout) ->
    {
      restrict: 'A'
      require: '?ngModel'
      scope:
        uiDatepickerOptions: '='
        ngModel: '='
      link: ($scope, element, attrs, controller) ->

        handler = ->
          options = $scope.uiDatepickerOptions or {}
          $scope.inputHasFocus = false
          element.datepicker(options).on 'changeDate', ($event) ->
            if !$scope.$$phase and !$scope.$root.$$phase
              return $scope.$apply(->
                controller.$setViewValue $event.date
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
          return

        $timeout handler, 0
        return

    }
]