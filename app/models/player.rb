# frozen_string_literal: true

class Player < ApplicationRecord
  scope :average_age_by_position, -> (position) { where(position: position).average(:age).to_i }

  # IDK How to infer this information, so
  # I'm delaying that problem for later and
  # getting the rest working for now ;D
  def sport
    %i[baseball basketball football].sample
  end
end
