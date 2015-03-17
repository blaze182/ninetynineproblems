class AddCounterCacheToQuestionAnswers < ActiveRecord::Migration
  def self.up
    add_column :questions, :answers_count, :integer, null:false, default:0
    ids = Set.new
    Answer.all.each {|c| ids << c.question_id}
    ids.each do |question_id|
      Question.reset_counters(question_id, :answers)
    end
  end
  def self.down
    remove_column :answers_count
  end
end
