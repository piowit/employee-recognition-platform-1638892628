# frozen_string_literal: true

module Admin
  class KudosController < AdminController
    before_action :set_kudo, only: %i[show edit update destroy]

    def index
      @kudos = Kudo.all.includes(:company_value)
    end

    def show; end

    def new
      @kudo = Kudo.new
    end

    def edit; end

    def create
      @kudo = Kudo.new(kudo_params)

      if @kudo.save
        redirect_to admin_kudo_path(@kudo), notice: 'Kudo was successfully created.'
      else
        render :new
      end
    end

    def update
      if @kudo.update(kudo_params)
        redirect_to admin_kudo_path(@kudo), notice: 'Kudo was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @kudo.destroy
      redirect_to admin_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    def kudo_params
      params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
    end
  end
end
