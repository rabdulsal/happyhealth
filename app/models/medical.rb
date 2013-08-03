class Medical < ActiveRecord::Base
	attr_accessible		:allergies_attributes,
						:immunizations_attributes,
						:medications_attributes,
						:problems_attributes,
						:form_id

	belongs_to :form
	has_many :allergies
	has_many :immunizations
	has_many :medications
	has_many :problems

	accepts_nested_attributes_for	:allergies,
									:immunizations,
									:medications,
									:problems
end
