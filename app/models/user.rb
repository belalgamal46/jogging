class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :jogging_sessions, dependent: :destroy

  validates :email, presence: true
  validates :password, presence: true

  ROLES = %w[regular manager admin].freeze

  ROLES.each do |role_name|
    define_method "#{role_name}?" do
      role == role_name
    end
  end
end
