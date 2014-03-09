express = require "express"
path = require "path"
http = require "http"
swig = require "swig"
async = require "async"
expressValidator = require "express-validator"
passport = require "passport"

app = express()

###
Config
###
require "./config"
console.log "Environment : #{global.env}"

app.configure () =>
	app.set 'port', process.env.PORT || 3000
	app.engine 'swig', swig.renderFile
	app.set 'views', __dirname + '/modules'
	app.set 'view engine', 'swig'
	app.enable 'trust proxy'  #on the webserver it's behind nginx
	app.use express.urlencoded()
	app.use express.json()

	app.use express.static(path.join(__dirname, 'public'))
	app.use expressValidator()
	app.use express.cookieParser()
	app.use express.session({secret:'fgkjhgajh'})

	#passport middleware
	app.use passport.initialize()
	app.use passport.session()

	#module middleware container
	app.set 'middleware', {}

###
swig instance for setting filters
###
app.set 'swig', swig

###
sequelize models
### 
loadModels = (next) =>
	models = require "./modelloader.coffee"
	models.configure app, next

###
Modloader - load in and run any config each module needs
###
loadModules = (next) =>
	modloader = new(require "./modloader.coffee")
	modloader.configure app, next

###
404 and 500 routes - specifically here so they load after everything else
###
###
G2G base controller - needed for error handling pages
###
setErrorPages = (next) =>
	baseController = new(require "./modules/common/controller/BaseController")(app)
	app.use (req, res, next) =>
		baseController.show404 req, res

	app.use (err, req, res, next) =>
		baseController.show500 req, res

	next()

###
add in the router - last thing
since mods above may be injecting bits of middleware
###
setRouter = (next) =>
	app.configure () =>
		app.use app.router
	next()

async.series {
	models : loadModels
	modules : loadModules
	errorPages : setErrorPages
	router : setRouter
}, (err, result) =>
	console.log err if err?
	###
	Start server
	###
	http.createServer(app).listen app.get('port'), () =>
		console.log "Express server listening on port #{app.get("port")}"
