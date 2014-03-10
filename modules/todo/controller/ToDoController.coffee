BaseController = require "../../common/controller/BaseController"

class ToDoController extends BaseController

	constructor : (app) ->
		super app

	index : (req, res) =>
		res.render "todo/view/index"

module.exports = ToDoController