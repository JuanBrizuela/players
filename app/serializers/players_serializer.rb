class CustomerSerializer < ActiveModel::Serializer
  attributes :external_id, :first_name, :last_name,
    :position, :age, :average_position_age_diff, :name_brief

  def name_brief
    case object.sport
    when :baseball then "#{first_name[0].upcase}., #{last_name[0].upcase}."
    when :basketball then "#{first_name.capitalize}, #{last_name[0].upcase}."
    when :football "#{first_name[0].upcase}, #{last_name.capitalize}."
    end
  end

  def average_position_age_diff
    (object.age - Player.average_age_by_position(object.position)).abs
  end
end
