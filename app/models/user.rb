class User < ApplicationRecord
  has_one :latest_post, -> { order(created_at: :desc) }, class_name: 'Post'
  has_many :posts
  accepts_nested_attributes_for :posts
end
