class User < ApplicationRecord
  has_many :access_grants, class_name: 'Doorkeeper::AccessGrant', foreign_key: :resource_owner_id, dependent: :delete_all
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id, dependent: :delete_all
  has_many :search_tasks, dependent: :destroy

  devise :database_authenticatable, :registerable, :validatable
end
