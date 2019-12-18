# frozen_string_literal: true

class AvailabilityPolicy < ApplicationPolicy
  def show?
    @user.role == 'practitioner' && @user.profilable == @record.practitioner
  end

  def create?
    @user.role == 'practitioner' && @user == @record.practitioner.user
  end

  def update?
    @user == @record.practitioner.user
  end

  def destroy?
    @user = @record.practitioner.user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
