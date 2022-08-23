# frozen_string_literal: true

class Player < ApplicationRecord
  scope :average_age_by_position, -> (position) { where(position: position).average(:age).to_i }

  # IDK How to infer this information, so
  # I'm delaying that problem for later and
  # getting the rest working for now ;D
  def sport
    %i[baseball basketball football].sample
  end

  def name_brief
    case sport
    when :baseball then "#{first_name[0]&.upcase}., #{last_name[0]&.upcase}."
    when :basketball then "#{first_name&.capitalize}, #{last_name[0]&.upcase}."
    when :football then "#{first_name[0]&.upcase}, #{last_name&.capitalize}."
    end
  end

  def to_json
    ActiveModelSerializers::SerializableResource.new(self).to_json
  end
end
