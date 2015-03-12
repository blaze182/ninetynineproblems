class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates :title, length: { in: 15..150 },
                    presence: true
  validates :body,  length: { in: 30..30000 },
                    presence: true
end
