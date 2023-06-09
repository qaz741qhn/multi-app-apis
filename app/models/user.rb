class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :omniauthable, omniauth_providers: [:google_oauth2]
  devise :jwt_authenticatable, jwt_revocation_strategy: JwtDenylist

  validates_presence_of :email
  has_many :user_tasks

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
