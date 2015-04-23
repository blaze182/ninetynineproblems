class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user

  validates :body, presence: true, length: { in: 30..30000 }

  def mark_best
    Answer.transaction do
      self.question.answers.update_all best: false
      self.update best: true
    end
  end  
end
