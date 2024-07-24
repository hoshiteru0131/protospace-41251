class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :profile, presence: true
  validates :occupation, presence: true
  validates :position, presence: true

  has_many :prototypes, dependent: :destroy
  def show
    user = User.find(params[:id])
    @name = user.name
    @prototypes = user.prototypes
  end
end
