class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user

  validates :body, presence: true, length: { in: 30..30000 }

  default_scope { order best: :desc, created_at: :asc }

  def mark_best
    Answer.transaction do
      self.question.answers.where(best: true).where.not(id: self.id).update_all best: false
      self.update best: true
    end
  end  
end
