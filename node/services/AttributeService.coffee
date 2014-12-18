
module.exports = (attributes, map)->

	set:(item, next) ->
		item[property] = @get property for own property of item
		next null, item

	get: (name)->
		mappings = map[name.toLowerCase()]
		return unless mappings?
		for own property of attributes
			return attributes[property] if mappings.some (x)-> x is property.toLowerCase()

