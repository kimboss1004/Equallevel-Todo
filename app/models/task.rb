class Task < ActiveRecord::Base
	enum status: { created: 10, completed: 20, deleted: 30 }

	validates :name, presence: true, length: { maximum: 100 }
	validates :description, presence: true, length: { maximum: 25000 }

	belongs_to :task_list
end