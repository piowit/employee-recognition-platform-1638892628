# frozen_string_literal: true

module Admin
  class OnlineCodesController < AdminController
    def index
      online_codes = OnlineCode.all.includes(:reward, :order)
      render :index, locals: { online_codes: online_codes }
    end

    def new
      online_code = OnlineCode.new
      render :new, locals: { online_code: online_code }
    end

    def edit
      online_code = OnlineCode.find(params[:id])
      render :edit, locals: { online_code: online_code }
    end

    def create
      online_code = OnlineCode.new(online_code_params)

      if online_code.save
        redirect_to admin_online_codes_path, notice: 'Online code was successfully added.'
      else
        render :new, locals: { online_code: online_code }
      end
    end

    def update
      online_code = OnlineCode.find(params[:id])
      if online_code.update(online_code_params)
        redirect_to admin_online_codes_path, notice: 'Online code was successfully updated.'
      else
        render :new, locals: { online_code: online_code }
      end
    end

    def destroy
      online_code = OnlineCode.find(params[:id])
      online_code.destroy
      redirect_to admin_online_codes_path, notice: 'Online code was successfully destroyed.'
    end

    private

    def online_code_params
      params.require(:online_code).permit(:code, :reward_id)
    end
  end
end
