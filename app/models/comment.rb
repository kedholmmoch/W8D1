class Comment < ApplicationRecord
  validates :content, presence: true

  belongs_to :author,
  class_name: 'User',
  foreign_key: :author_id

  belongs_to :post,
  class_name: 'Post',
  foreign_key: :post_id

  belongs_to :parent_comment,
  class_name: 'Comment',
  foreign_key: :comment_id,
  optional: true

  has_many :child_comments,
  foreign_key: :comment_id,
  class_name: 'Comment'
end
