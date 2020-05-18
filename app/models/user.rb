class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  has_many :role_users
  belongs_to :organization

  validates :organization_id, presence: true
  validates_associated :organization
  has_many :roles, through: :role_users
  has_many :tweets
  after_create :add_role_to_user

  def add_role_to_user
    self.roles << Role.find_by_name('USER')
  end
  
  def roles_name
    self.roles.collect { |role| role.name }
  end
end
