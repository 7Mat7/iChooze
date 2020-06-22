class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  after_create :create_criteria

  has_many :vues
  has_many :movies, through: :vues
  has_one :criterium

  def create_criteria
    @criterium = Criterium.create(user: self)
  end
end
