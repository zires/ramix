require 'ramix/templates/template'

module Ramix
	class	Mongoid < Template

		# The newest version of mongoid
		def self.newest_version
			'2.3.4'
		end

		# The description of mongoid
		def self.desc
			'Mongoid is an ODM (Object Document Mapper) Framework for MongoDB, written in Ruby.'
		end

	end
end