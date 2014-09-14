ToDoApp = angular.module "ToDoApp", ["ngRoute", "templates"]

# Setup the angular router
ToDoApp.config ["routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->

  $routeProvider
    .when "/",
      templateUrl: "index.html",
      controller: "TaskCtrl"
    .otherwise
      redirectTo: "/"

  $locationProvider.html5Mode true

]


ToDoApp.controller "TaskCtrl", [ "scope", "http", ($scope, $http) -> 







]


# Define config for CSRF token
ToDoApp.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token').attr('content')
]