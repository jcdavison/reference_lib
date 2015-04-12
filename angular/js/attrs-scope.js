app = angular.module('App', ['App.controllers', 'App.directives'])


var directives = angular.module('App.directives', [])

// directives.directive('information', [function() {
//     console.log("1")
//     return {
//       scope : {
//           information : '@',
//       },
//       controller: function($scope, $element, $attrs){
//           console.log("directive attrs information fired")
//           console.log($attrs.information)
//           $scope.information = $attrs.information
//       }
//     }
// }]);

// directives.directive('infor', [function() {
//     console.log("infor")
//     return {
//       scope : {
//           infor : '@',
//       },
//       controller: function($scope, $element, $attrs){
//           console.log("directive attrs information fired")
//           console.log($attrs.infor)
//           $scope.infor = $attrs.infor
//       }
//     }
// }]);

directives.directive('setreview', [function() {
    console.log("2")
    return {
      scope: {
          setReview : '@',
      },
      controller: function($scope, $element, $attrs) {
          console.log("attrs directive")
          console.log($attrs.setreview)
          $scope.setreview = $attrs.setreview
      }
    }
}]);

controllers = angular.module('App.controllers', [])
controllers.controller('expController', function($scope, $attrs) {
  console.log("attrs in controller")
  console.log($attrs)
  $scope.var1 = { name: 'Naomi', address: '1600 Amphitheatre' };
  $scope.var2 = { name: 'Igor', address: '123 Somewhere' };
  $scope.information = $attrs.setreview
})
