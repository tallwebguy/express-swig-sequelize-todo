###
Clustering
###
cluster = require "cluster"
numCPUs = require("os").cpus()

if cluster.isMaster
	numCPUs.forEach () =>
		cluster.fork()

	cluster.on "exit", (worker, code, signal) =>
		console.log "worker #{worker.process.pid} died"
		cluster.fork()
else
	require "./app.coffee"