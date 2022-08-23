class PlayerSerializer < ActiveModel::Serializer
  attributes :external_id, :first_name, :last_name,
    :position, :age, :average_position_age_diff, :name_brief

  def average_position_age_diff
    return nil unless object.age

    (object.age - Player.average_age_by_position(object.position)).abs
  end
end
