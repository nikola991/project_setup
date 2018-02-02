class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #enums
  STATUS = { active: 0, pending: 1 }.freeze

  # define helper methods
  STATUS.each do |key,value|
    define_method "#{key}?" do
      status == value
    end
  end

  # Scopes
  STATUS.each do |key, value|
    scope key.to_s.to_sym, -> { where(status: value) }
  end

  validates :phone_number, presence: true
  validates :status, presence: true, inclusion: { in: STATUS.values }
  validates :name, presence: true
  validates :email,
            uniqueness: true,
            format: EmailUtilities::VALID_EMAIL_REGEX,
            case_sensitive: false
  validates :password_confirmation, presence: true
end
