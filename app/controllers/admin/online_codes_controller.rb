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

    def export
      @online_codes = OnlineCode.all.order(:code)

      response.headers['Content-Type'] = 'text/csv'
      response.headers['Content-Disposition'] =
        "attachment; filename=online_codes_#{Time.zone.now.strftime('%y%m%d_%H-%M-%S')}.csv"
      render template: 'admin/online_codes/export', handlers: [:erb], formats: [:csv]
    end

    def import
      import_service = ImportOnlineCodesCsvService.new(params)

      if import_service.call
        redirect_to admin_online_codes_path, notice: 'Rewards imported.'
      else
        redirect_to admin_online_codes_path, notice: import_service.errors.join(', ')
      end
    end

    private

    def online_code_params
      params.require(:online_code).permit(:code, :reward_id)
    end
  end
end
