# frozen_string_literal: true

module Admin
  class KudosController < AdminController
    before_action :set_kudo, only: %i[show edit update destroy]

    # GET /admin/kudos
    def index
      @kudos = Kudo.all.includes(:company_value, :giver, :receiver)
    end

    # GET /admin/kudos/1
    def show; end

    # GET /admin/kudos/new
    def new
      @kudo = Kudo.new
    end

    # GET /admin/kudos/1/edit
    def edit; end

    # POST /admin/kudos
    def create
      @kudo = Kudo.new(kudo_params)

      if @kudo.save
        redirect_to admin_kudo_path(@kudo), notice: 'Kudo was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /admin/kudos/1
    def update
      if @kudo.update(kudo_params)
        redirect_to admin_kudo_path(@kudo), notice: 'Kudo was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /admin/kudos/1
    def destroy
      @kudo.destroy
      redirect_to admin_kudos_url, notice: 'Kudo was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_kudo
      @kudo = Kudo.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def kudo_params
      params.require(:kudo).permit(:title, :content, :employee_id, :receiver_id, :company_value_id)
    end
  end
end
