class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
    	t.integer :task_list_id
    	t.integer :status
    	t.text :name
    	t.text :description
   	 	t.timestamps
    end
  end
end
