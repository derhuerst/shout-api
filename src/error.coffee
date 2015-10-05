boom =			require 'boom'





module.exports = (req, reply) ->
	res = req.response
	if err instanceof Error
		if not err.isBoom then err = boom.wrap err, err.statusCode

		console.error [
			err.output.statusCode
			req.method.toUpperCase()
			req.path
		].join '\t'
		if err.isDeveloperError
			console.error err.stack
			err = boom.badImplementation()

		response = reply
			status:	'error'
			error:	err
		response.statusCode = err.statusCode

	else
		# todo: fix this weird `.source` hack
		res.source.status = 'ok'
		reply res.source
