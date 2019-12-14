# frozen_string_literal: true

class PractitionerPolicy < ApplicationPolicy
  def create?
    @user.role == 'practitioner'
  end

  def update?
    @user == @record
  end

  def destroy?
    @user == @record
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
