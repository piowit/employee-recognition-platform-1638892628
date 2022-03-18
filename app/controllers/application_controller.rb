# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :timelimit_for_edit

  private

  def timelimit_for_edit
    flash[:notice] = 'You can edit or delete within 5 min from creation.'
    redirect_to(request.referer || root_path)
  end
end
