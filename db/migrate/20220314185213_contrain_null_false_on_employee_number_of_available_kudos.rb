class ContrainNullFalseOnEmployeeNumberOfAvailableKudos < ActiveRecord::Migration[6.1]
  def change
    change_column_null(:employees, :number_of_available_kudos, false)
  end
end
