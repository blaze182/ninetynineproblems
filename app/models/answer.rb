class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true

  validates :body, presence: true, length: { in: 30..30000 }
end
