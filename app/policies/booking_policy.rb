# frozen_string_literal: true

class BookingPolicy < ApplicationPolicy
  def show?
    @user == @record.patient.user || @user == @record.practitioner.user
  end

  def create?
    @user.role == 'patient' && @user == @record.patient.user
  end

  def update?
    @user == @record.patient.user || @user == @record.practitioner.user
  end

  def confirm?
    @user.role == 'practitioner' && @user.profilable == @record.practitioner
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
