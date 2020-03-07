class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable,:validatable

  attachment :profile_image
  attachment :image

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, presence: true, length: {maximum: 20, minimum: 2}
  validates :introduction,length: { maximum: 50 }
  has_many :books,dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many  :comment_books, through: :comments, source: 'book'
  
  has_many :favorites, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: 'book'

  def favorited_by?(book_id)
    favorites.where(book_id: book_id).exists?
  end
end
