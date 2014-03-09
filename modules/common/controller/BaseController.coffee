class BaseController

	###
	This is the default 404 page
	###
	show404 : (req, res) =>
		#could do a res.render "someotherpage"
		res.send 404

	###
	This is the default 500 page
	###
	show500 : (req, res) =>
		#could to a res.render "somepage"
		res.send 500	

module.exports = BaseController