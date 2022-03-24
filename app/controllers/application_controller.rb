# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # customize Pundit user
  def pundit_user
    current_employee
  end
end
