# frozen_string_literal: true

class KudoPolicy < ApplicationPolicy
  def initialize(user, kudo)
    @user = user
    @kudo = kudo
  end

  def update?
    created_within_time(@kudo)
  end

  def destroy?
    created_within_time(@kudo)
  end

  private

  def created_within_time(kudo)
    kudo.created_at > 5.minutes.ago
  end
end
