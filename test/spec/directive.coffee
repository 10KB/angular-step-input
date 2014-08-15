describe 'angular-step-input', ->

  beforeEach(module('tien.stepInput'))

  beforeEach inject ($rootScope) ->
    @scope = $rootScope

  it 'should initialize', inject ($compile) ->
    element = angular.element '<tien-step-input></tien-step-input>'
    element = $compile(element)(@scope)

  it 'should decrease on decrement button click', inject ($compile) ->
    @scope.model = 3
    element = angular.element '<tien-step-input ng-model="model"></tien-step-input>'
    element = $($compile(element)(@scope))
    element.find('button').eq(0).click()
    expect(@scope.model).toBe(2)

  it 'should increase on increment button click', inject ($compile) ->
    @scope.model = 3
    element = angular.element '<tien-step-input ng-model="model"></tien-step-input>'
    element = $($compile(element)(@scope))
    element.find('button').eq(1).click()
    expect(@scope.model).toBe(4)

  it 'should respect min value', inject ($compile) ->
    @scope.options = min_value: 3
    @scope.model = 3
    element = angular.element '<tien-step-input ng-model="model" step-input-options="options"></tien-step-input>'
    element = $($compile(element)(@scope))
    element.find('button').eq(0).click()
    expect(@scope.model).toBe(3)

  it 'should respect max value', inject ($compile) ->
    @scope.options = max_value: 3
    @scope.model = 3
    element = angular.element '<tien-step-input ng-model="model" step-input-options="options"></tien-step-input>'
    element = $($compile(element)(@scope))
    element.find('button').eq(1).click()
    expect(@scope.model).toBe(3)