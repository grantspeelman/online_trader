# frozen_string_literal: true

module ValidatesNonExceptional
  def validates_non_exceptional(columns)
    columns.each do |column|
      value = send(column)
      errors.add(column, value.message) if value.exceptional?
    end
  end
end
