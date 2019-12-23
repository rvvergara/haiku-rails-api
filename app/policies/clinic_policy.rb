# frozen_string_literal: true

class ClinicPolicy < ApplicationPolicy
  def create?
    @user == @record.user
  end

  def update?
    @user.profilable == @record.creator
  end

  def destroy?
    @user.profilable == @record.creator
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
