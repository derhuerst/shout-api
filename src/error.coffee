boom =			require 'boom'





module.exports = (req, reply) ->
	res = req.response
	if res instanceof Error
		err = if not res.isBoom then boom.wrap res, res.statusCode else res

		console.error [
			err.output.statusCode
			req.method.toUpperCase()
			req.path
		].join '\t'
		if err.isDeveloperError
			console.error err.stack
			err = boom.badImplementation()

		response = err.output?.payload or {}
		response.status = 'error'
		response = reply response
		response.statusCode = err.output.statusCode

	else
		# todo: fix this weird `.source` hack
		res.source.status = 'ok'
		res.source.statusCode = 200
		reply res.source
