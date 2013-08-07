module FormsHelper

	def values_of_activity_hash hash
		values = []
		hash.values.each do |val|
			if val.class.to_s == "Hash"
				puts val
				values << values_of_activity_hash(val)
			else
				values << val
			end
		end
		values.flatten.map {|o| o.to_s}.reject { |c| c.empty? }
	end
end
