class User < ActiveRecord::Base
    validates :nickname, presence: true

# class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :nickname, presence: true
  # has_one_attached :avatar

  has_many :reviews

  has_one_attached :avatar

end
