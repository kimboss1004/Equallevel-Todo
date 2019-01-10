class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
        t.string :login, :limit => 100, :null => false
        t.string :crypted_password, :limit => 40, :null => false
        t.string :salt, :limit => 40, :null => false
        t.string :email, :limit => 100, :null => false
        t.string :firstname, :limit => 100, :null => false
        t.string :lastname, :limit => 100, :null => false
        t.timestamp
    end
  end
end
