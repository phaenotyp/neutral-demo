class User < ActiveRecord::Base
  has_many :comments
  has_many :assignments
  has_many :roles, :through => :assignments
  has_many :authentications
  before_create :assign_member_role

  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  
  def role_symbols
    roles.map do |role|
      role.name.underscore.to_sym
    end
  end
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  private
  
  def assign_member_role
    member_role = Role.find_by_name("member")
    self.roles = [member_role]
  end  
end
