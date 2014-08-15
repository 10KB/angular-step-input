
/*!
 * angular-step-input 0.1.0
 * 10KB, http://10kb.nl/
 * License: MIT
 */

(function() {
  var module;

  module = angular.module('tien.stepInput', []);

  module.directive('tienStepInput', ["$interpolate", "$sce", function($interpolate, $sce) {
    return {
      restrict: 'AE',
      replace: true,
      scope: {
        user_options: '&stepInputOptions',
        value: '=ngModel'
      },
      link: function(scope, elem, attrs) {
        var options;
        options = {
          decrease: 'fa fa-minus',
          increase: 'fa fa-plus',
          min_value: 0,
          max_value: 999,
          style: 'primary',
          view_value: false,
          overrides: []
        };
        scope.$watch(scope.user_options, function(val) {
          return angular.extend(options, scope.user_options(scope));
        }, true);
        scope.value = !isNaN(parseInt(scope.value)) ? scope.value : 0;
        scope.decrease = function() {
          return scope.value = scope.value - 1;
        };
        scope.increase = function() {
          return scope.value = scope.value + 1;
        };
        return scope.$watch('value', function(val, oldval) {
          var overrides;
          if (!isNaN(parseInt(scope.value))) {
            scope.value = Math.min(Math.max(parseInt(val), options.min_value), options.max_value);
          } else {
            scope.value = oldval;
          }
          scope.property = angular.copy(options);
          overrides = options.overrides.filter(function(obj) {
            return obj.value === scope.value;
          });
          if (overrides.length > 0) {
            angular.extend(scope.property, overrides[0]);
          }
          if (scope.property.view_value.call != null) {
            return scope.property.view_value = $sce.trustAsHtml("" + (scope.property.view_value.call()));
          } else {
            return scope.property.view_value = $sce.trustAsHtml($interpolate(scope.property.view_value)(scope));
          }
        });
      },
      template: "<div class=\"tien-step\" ng-class=\"property.style\">\n  <button ng-click=\"decrease()\" ng-class=\"{disabled: value == property.min_value}\"><i ng-class=\"property.decrease\"></i></button>\n  <div class=\"step-value\" ng-show=\"property.view_value\" ng-bind-html=\"property.view_value\"></div>\n  <input class=\"step-value\" type=\"text\" ng-model=\"value\" ng-hide=\"property.view_value\">\n  <button ng-click=\"increase()\" ng-class=\"{disabled: value == property.max_value}\"><i ng-class=\"property.increase\"></i></button>\n</div>"
    };
  }]);

}).call(this);
