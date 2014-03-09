BaseHelper = require "../../common/helper/BaseHelper"

class UserHelper extends BaseHelper

	constructor : (app) ->
		@.user = app.get("models").User
		super app

	###
	Register a new user
	Returns user/model/User
	###
	registerUser : (email, password, next) =>
		@.user.create({
			email : email
			password : password
		}).success((newUser) =>
			return next undefined, newUser
		).failure((error) =>
			@.logMessage "RegisterUser : #{error}"
			return next error
		)


