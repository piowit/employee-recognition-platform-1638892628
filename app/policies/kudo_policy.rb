# frozen_string_literal: true

class KudoPolicy < ApplicationPolicy
  def initialize(user, kudo)
    @user = user
    @kudo = kudo
  end

  def edit?
    created_within_time(@kudo) && @kudo.giver == @user
  end

  def update?
    created_within_time(@kudo) && @kudo.giver == @user
  end

  def destroy?
    created_within_time(@kudo) && @kudo.giver == @user
  end

  private

  def created_within_time(kudo)
    kudo.created_at > 5.minutes.ago
  end
end
