config =
	site : 
		verbose_db : false
		verbose_load : false
		salt_length : 48
	database :
		host : "127.0.0.1"
		port : "5432"
		db : "todo"
		username : "todo"
		password : "Passw0rd"
	locallogin :
		success : "/profile"
		failure : "/register"

module.exports = config