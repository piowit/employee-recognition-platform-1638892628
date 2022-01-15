# frozen_string_literal: true

module Admin
  class CompanyValuesController < AdminController
    def index
      @company_values = CompanyValue.all
    end

    def edit
      @company_value = CompanyValue.find(params[:id])
    end

    def new
      @company_value = CompanyValue.new
    end

    def create
      @company_value = CompanyValue.new(company_value_params)
      if @company_value.save
        redirect_to admin_company_values_path, notice: 'Company Value was successfully created.'
      else
        render :new
      end
    end

    def update
      @company_value = CompanyValue.find(params[:id])
      if @company_value.update(company_value_params)
        redirect_to admin_company_value_path(@company_value), notice: 'Company Value was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @company_value = CompanyValue.find(params[:id])
      @company_value.destroy
      redirect_to admin_company_values_path, notice: 'Company Value was successfully destroyed.'
    end

    private

    def company_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
