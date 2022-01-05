# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authenticate_admin_user!
  def home; end
end
