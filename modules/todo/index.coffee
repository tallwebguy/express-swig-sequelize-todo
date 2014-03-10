configure = (app) =>

	toDoController = new(require "./controller/ToDoController")(app)

	app.get "/", toDoController.index

exports.configure = configure