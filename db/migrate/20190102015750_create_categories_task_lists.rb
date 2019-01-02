class CreateCategoriesTaskLists < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_task_lists do |t|
		t.integer :category_id
		t.integer :task_list_id
    end
  end
end
