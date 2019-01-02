class Category < ActiveRecord::Base
	validates :name, presence: true, length: { maximum: 100 }

	has_many :categories_task_lists, :dependent => :destroy
	has_and_belongs_to_many :task_lists, through: :categories_task_lists
end