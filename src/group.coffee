boom =			require 'boom'





module.exports = (req, reply) ->
	orm = @orm

	if not req.params.group then return reply boom.badRequest "Missing `group` parameter."

	orm.groups.get req.params.group
	.then (group) ->
		if not group then return reply boom.notFound "There is no group <code>#{req.params.group}</code>."

		response =
			group:		req.params.group

		orm.messages.all req.params.group
		.then (messages) ->
			response.messages = messages
			reply response

		.catch (err) -> throw err
	.catch (err) -> reply err
