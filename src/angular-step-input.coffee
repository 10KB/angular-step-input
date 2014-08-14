###!
# angular-step-input 0.1.0
# 10KB, http://10kb.nl/
# License: MIT
###

module = angular.module('tien.stepInput', [])

module.directive 'tienStepInput', ($interpolate, $sce) ->
  restrict: 'AE'
  replace: true
  scope:
    user_options: '&stepInputOptions'
    value: '=ngModel'

  link: (scope, elem, attrs) ->
    # default options
    options =
      decrease: 'fa fa-minus'
      increase: 'fa fa-plus'
      min_value: 0
      max_value: 999
      style: 'primary'
      view_value: false
      overrides: []

    # merge user defined options
    scope.$watch scope.user_options, (val) ->
      angular.extend(options, scope.user_options(scope))
    , true

    scope.value = if !isNaN(parseInt(scope.value)) then scope.value else 0

    scope.decrease = ->
      scope.value = scope.value - 1

    scope.increase = ->
      scope.value = scope.value + 1

    scope.$watch 'value', (val, oldval) ->
      # limit value between min_value and max_value
      if !isNaN(parseInt(scope.value))
        scope.value = Math.min(Math.max(parseInt(val), options.min_value), options.max_value)
      # replace by oldval if NaN
      else
        scope.value = oldval

      # put options on scope
      scope.property = angular.copy(options)

      # apply value specific options overrides
      overrides = options.overrides.filter (obj) -> obj.value is scope.value
      if overrides.length > 0
        angular.extend(scope.property, overrides[0])

      # custom view_value as method
      if scope.property.view_value.call?
        scope.property.view_value = $sce.trustAsHtml("#{scope.property.view_value.call()}")
      # custom view_value as expression
      else
        scope.property.view_value = $sce.trustAsHtml($interpolate(scope.property.view_value)(scope))

  template: """
    <div class="tien-step" ng-class="property.style">
      <button ng-click="decrease()" ng-class="{disabled: value == property.min_value}"><i ng-class="property.decrease"></i></button>
      <div class="step-value" ng-show="property.view_value" ng-bind-html="property.view_value"></div>
      <input class="step-value" type="text" ng-model="value" ng-hide="property.view_value">
      <button ng-click="increase()" ng-class="{disabled: value == property.max_value}"><i ng-class="property.increase"></i></button>
    </div>
  """