# frozen_string_literal: true

class PlayersFilterService
  attr_reader :scope, :filters

  def initialize(scope, filters)
    @scope = scope
    @filters = filters
  end

  def filter
    return scope unless filters

    filters.reduce(scope) do |scope, filter|
      filter_method = "filter_by_#{filter[:property]}"
      scope = send(filter_method, filter[:operator], filter[:values])
    end
  end

  private

  # Sport is not a field
  # def filter_by_sport(operator, values)
  #   return scope unless ["eq"].include?(operator)

  #   scope.where(sport: values)
  # end

  def filter_by_age(operator, values)
    return scope unless ["eq", "btw", "gt", "lt"].include?(operator)

    case operator
    when "eq" then scope.where(age: values)
    when "gt" then scope.where("age > ?", values[0])
    when "lt" then scope.where("age < ?", values[0])
    when "btw" then scope.where("age BETWEEN ? AND ?", values[0], values[1])
    else scope
    end
  end

  def filter_by_position(operator, values)
    return scope unless ["eq"].include?(operator)

    scope.where(position: values)
  end

  def filter_by_last_name(operator, values)
    return scope unless ["eq", "match"].include?(operator)

    case operator
    when "eq" then scope.where(last_name: values)
    when "match" then scope.where("last_name LIKE ?", "#{values[0]}%")
    else scope
    end
  end
end
