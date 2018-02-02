class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone_number, presence: true
  validates :status, presence: true
  validates :name, presence: true
  validates :email,
            uniqueness: true,
            format: EmailUtilities::VALID_EMAIL_REGEX,
            case_sensitive: false
  validates :password_confirmation, presence: true
end
