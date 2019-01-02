class CategoriesTaskList < ActiveRecord::Base
	validates :category_id, presence: true
	validates :task_list_id, presence: true

	belongs_to :task_list
	belongs_to :category
end