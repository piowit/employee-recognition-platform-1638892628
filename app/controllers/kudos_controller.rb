# frozen_string_literal: true

class KudosController < ApplicationController
  before_action :set_kudo, only: %i[show edit update destroy]
  before_action :authenticate_employee!
  before_action :check_kudo_giver, only: %i[edit update destroy]

  def index
    @kudos = Kudo.includes(:company_value, :giver, :receiver)
  end

  def show; end

  def new
    if current_employee.number_of_available_kudos < 1
      redirect_to kudos_url, notice: 'You cannot give kudo! Not enough available kudos!'
    else
      @kudo = Kudo.new
    end
  end

  def edit
    authorize @kudo
  end

  def create
    if current_employee.number_of_available_kudos < 1
      redirect_to kudos_path, notice: 'Kudo Not Added! Not enough available kudos.'
    else
      @kudo = Kudo.new(kudo_params)
      @kudo.giver = current_employee
      @kudo.giver.number_of_available_kudos -= 1
      begin
        ActiveRecord::Base.transaction do
          @kudo.giver.save!
          @kudo.save!
        end
        redirect_to @kudo, notice: 'Kudo was successfully created.'
      rescue ActiveRecord::RecordInvalid => e
        render :new, notice: e.message
      end
    end
  end

  def update
    authorize @kudo
    if @kudo.update(kudo_params)
      redirect_to @kudo, notice: 'Kudo was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @kudo
    @kudo.destroy
    redirect_to kudos_url, notice: 'Kudo was successfully destroyed.'
  end

  def check_kudo_giver
    redirect_to kudos_path, notice: 'You are not authorized to edit this kudo.' unless @kudo.giver == current_employee
  end

  private

  def set_kudo
    @kudo = Kudo.find(params[:id])
  end

  def kudo_params
    params.require(:kudo).permit(:title, :content, :giver_id, :receiver_id, :company_value_id)
  end
end
