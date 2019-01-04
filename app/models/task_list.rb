class TaskList < ActiveRecord::Base
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 100 }

	has_many :tasks, :dependent => :destroy
	
	has_many :categories_task_lists, :dependent => :destroy
	has_and_belongs_to_many :categories, through: :categories_task_lists


	accepts_nested_attributes_for :tasks, :allow_destroy => true, :reject_if => :all_blank
	accepts_nested_attributes_for :categories, :allow_destroy => true, :reject_if => :all_blank
end