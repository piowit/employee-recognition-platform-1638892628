# frozen_string_literal: true

module Admin
  class AddKudosController < AdminController
    def index
      @employees = Employee.all
    end

    def update
      if amount_param.between? 1, 20
        @employees = Employee.all
        @employees.each do |employee|
          employee.number_of_available_kudos += amount_param
          redirect_to admin_add_kudos_path, notice: 'Ups! Something went wrong' unless employee.save!
        end
        redirect_to admin_add_kudos_path, notice: "Added #{amount_param} points to every employee"
      else
        redirect_to admin_add_kudos_path, notice: 'Number must be between 1 and 20'
      end
    end

    private

    def amount_param
      params[:employee][:amount].to_i
    end
  end
end
