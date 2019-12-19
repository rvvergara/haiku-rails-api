# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :activation_token
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true
  delegate :profilable, to: :profile, allow_nil: true

  has_one :profile, foreign_key: :user_id, dependent: :destroy

  delegate :first_name, :last_name, to: :profile
  delegate :profilable, to: :profile
  delegate :bookings, to: :profilable

  before_create :create_activation_digest


  # Returns a random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # This will return true if the token matches the digest
  def email_authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Method to send activation email
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end


  # Method to activate user
  def activate
    update_columns(activated: true, activated_at: Time.now)
  end

  private
  # Activation related methods
  # 1. Returns a hashed digest of a given string
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password .create(string, cost: cost)
  end

  # 2. Method to create an activation digest
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
