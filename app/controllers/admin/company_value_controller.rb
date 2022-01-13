# frozen_string_literal: true

module Admin
  class CompanyValueController < AdminController
    def index
      @company_values = CompanyValue.all
    end

    def show; end

    def new
      @company_value = CompanyValue.new
    end

    def create
      @company_value = CompanyValue.new(caompany_value_params)

      if @company_value.save
        redirect_to admin_company_value_index_path, notice: 'Company Value was successfully created.'
      else
        render :new
      end
    end

    private

    def caompany_value_params
      params.require(:company_value).permit(:title)
    end
  end
end
