module ActiveRecord
	class Base
		def update_attributes_changed(attributes)
			self.attributes = attributes
			changes = self.changes
			return save, changes
		end
	end
end
