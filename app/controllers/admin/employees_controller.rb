# frozen_string_literal: true

module Admin
  class EmployeesController < AdminController
    def index
      @employees = Employee.all
    end

    def edit
      @employee = Employee.find(params[:id])
    end

    def update
      @employee = Employee.find(params[:id])
      check_password_params = employee_params
      check_password_params.delete(:password) if check_password_params[:password].blank?
      if @employee.update(check_password_params)
        redirect_to admin_employees_path, notice: 'Employee was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @employee = Employee.find(params[:id])
      @employee.destroy
      redirect_to admin_employees_path, notice: 'Employee was successfully destroyed.'
    end

    def add_kudos_for_all
      if amount_param.between? 1, 20
        begin
          ActiveRecord::Base.transaction do
            @employees = Employee.find_each
            @employees.each do |employee|
              employee.number_of_available_kudos += amount_param
              employee.save!
            end
          end
          redirect_to admin_employees_path, notice: "Added #{amount_param} points to every employee"
        rescue ActiveRecord::RecordInvalid => e
          render :new, notice: e.message
        end
      else
        redirect_to admin_employees_path, notice: 'Number must be between 1 and 20'
      end
    end

    private

    def amount_param
      params[:amount].to_i
    end

    def employee_params
      params.require(:employee).permit(:first_name, :last_name, :email, :password)
    end
  end
end
