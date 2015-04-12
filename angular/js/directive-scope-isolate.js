var app = angular.module("app", []);

console.log('isolate-scope')

app.controller('expController', ['$scope', function($scope) {
  $scope.var1 = { name: 'Naomi', address: '1600 Amphitheatre' };
  $scope.var2 = { name: 'Igor', address: '123 Somewhere' };
}])

app.directive('myCustomer', function() {
  return {
    restrict: 'E',
    scope: {
      customerInfo: '=info'
    },
    templateUrl: "../html/templates/names.html"
  };
});

// notice that we've created an element restriction that sets the scope of the directive
// to the return of the directives info attribute, which is bound to the outside scope variable
// of the controller named 'expController' 
// this directive inserts data defined inside a particular controller into a provided demplate and
// then inserts that template into the dom inside the <my-customer>{{template goes here}}</my-customer> tag.
// this is a pattern referred to as 'isolate scope'
// 'customerInfo' is the name of the variable inside the scope that the template has access to
// shorthand, if the attribute has the same name as the scope's value, 'attribute: '='' works 
