class User < ActiveRecord::Base
	has_secure_password
	before_create { generate_token(:auth_token) }
	#presence 必须填写
	validates :name, :email, presence: true
	#uniqueness 唯一性 case_sensitive 大小写忽略
    validates :name, :email, uniqueness: { case_sensitive: false }
    has_many :articles

	def generate_token(column)
	  begin
	    self[column] = SecureRandom.urlsafe_base64
	  end while User.exists?(column => self[column])
	end
end
