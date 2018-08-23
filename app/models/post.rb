class Post < ApplicationRecord
  belongs_to :user
  validates :title, length: { minimum: 3, on: :hoge }
end
