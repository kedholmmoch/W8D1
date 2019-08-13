class Post < ApplicationRecord
  validates :title, :url, presence: true    

  belongs_to :author,
  class_name: 'User',
  foreign_key: :author_id,
  primary_key: :id

  has_many :post_subs, dependent: :destroy, inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments

end
