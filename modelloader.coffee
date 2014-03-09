path = require "path"
seq = require "sequelize"
async = require "async"
db = require "./modules/common/helper/db"

modelList = [
	{ module : 'user', model : 'User'}
]

exports.configure = (app, next) ->
	
	models = {}

	modelList.forEach (m) =>
		importPath = path.join __dirname, "modules", m.module, "model", "#{m.model}.coffee"
		console.log "Loading : #{importPath}" if global.config.site.verbose_load
		models[m.model] = db.import importPath

	###
	If we are being asked to sync the database, then do just that and quit
	###
	_syncModel = (model, next) =>
		model.sync({force : true}).success(() =>
			return next undefined
		).error((error) =>
			return next error
		)

	if process.env["SYNCDB"]?
		console.log "Sync database in progress.."
		toSync = []
		toSync.push m for name, m of models
		async.mapSeries toSync, _syncModel, (err, result) =>
			console.log "..Database sync complete"
			process.exit 0

	else
		###
		set relationships between models here
		###

		app.set("models", models)
		app.set("db", db)
		next()