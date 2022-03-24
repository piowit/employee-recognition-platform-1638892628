# frozen_string_literal: true

class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :authenticate_employee!
  before_action :check_kudo_giver, only: %i[edit update destroy]

  REWARDS_PER_PAGE = 2

  # GET /kudos
  def index
    @page = 1
    @kudos = Kudo.includes(:company_value, :giver, :receiver).limit(REWARDS_PER_PAGE).offset(@page * REWARDS_PER_PAGE)
  end

  # GET /kudos/1
  def show; end

  # GET /kudos/new
  def new
    if current_employee.number_of_available_kudos < 1
      redirect_to kudos_url, notice: 'You cannot give kudo! Not enough available kudos!'
    else
      @kudo = Kudo.new
    end
  end

  # GET /kudos/1/edit
  def edit
    authorize @kudo
  end

  # POST /kudos
  def create
    if current_employee.number_of_available_kudos < 1
      redirect_to kudos_path, notice: 'Kudo Not Added! Not enough available kudos.'
    else
      @kudo = Kudo.new(kudo_params)
      @kudo.giver = current_employee
      @kudo.giver.number_of_available_kudos -= 1
      @kudo.giver.save!
      if @kudo.save
        redirect_to @kudo, notice: 'Kudo was successfully created.'
      else
        render :new
      end
    end
  end

  # PATCH/PUT /kudos/1
  def update
    authorize @kudo
    if @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kudos/1
  def destroy
    authorize @kudo
    @kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  def check_kudo_giver
    redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.' unless @kudo.giver == current_employee
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
  end
end
