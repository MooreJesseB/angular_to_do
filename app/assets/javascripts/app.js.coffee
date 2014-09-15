ToDoApp = angular.module("ToDoApp", ["ngRoute", "templates"])

# Setup the angular router
ToDoApp.config ["$routeProvider", "$locationProvider", ($routeProvider, $locationProvider) ->

  $routeProvider
    .when "/",
      templateUrl: "index.html",
      controller: "TasksCtrl"
  .otherwise
    redirectTo: "/"

  $locationProvider.html5Mode(true)

]


ToDoApp.controller "TasksCtrl", [ "$scope", "$http", ($scope, $http) -> 

  $scope.tasks = []

  # READ
  $scope.getTasks = ->
    $http.get("/tasks.json").success (data) ->
      $scope.tasksCompleted = []
      $scope.tasksIncomplete = []
      $scope.tasks = data
      $scope.tasks.forEach (item) ->
        if item.completed
          $scope.tasksCompleted.push item
        else
          $scope.tasksIncomplete.push item


  $scope.getTasks()

  # CREATE
  $scope.addTask = ->
    $scope.newTask.completed = false
    $http.post("/tasks.json", $scope.newTask).success (data) ->
      $scope.newTask = {}
      $scope.tasks.push(data)
      $scope.tasksIncomplete.push(data)


  # DELETE
  $scope.deleteTask = (task) ->
    conf = confirm "Are you sure?"
    if conf
      $http.delete("/tasks/#{task.id}.json").success (data) ->
        console.log data
        $scope.tasks.splice($scope.tasks.indexOf(task), 1)


  # UPDATE
  $scope.editTask = (task) ->
    this.editChecked = false
    $http.put("/tasks/#{this.task.id}.json}", task).success (data) ->
      console.log data

  $scope.editComplete = (task) ->
    $http.put("/tasks/#{this.task.id}.json", task).success (data) ->
      $scope.getTasks()
      console.log data
]



# Define config for CSRF token
ToDoApp.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]