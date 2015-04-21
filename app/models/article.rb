class Article < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	belongs_to :user
	#validates :titile, presence: true,length: {minimum: 5}
end
