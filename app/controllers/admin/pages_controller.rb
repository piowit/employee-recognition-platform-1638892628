# frozen_string_literal: true

module Admin
  class PagesController < ApplicationController
    before_action :authenticate_admin_user!
    layout 'admin'

    def dashboard; end
  end
end
