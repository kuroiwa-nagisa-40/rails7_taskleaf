class ChangeTasksNameLimit30 < ActiveRecord::Migration[7.1]
  def change
    def up
      change_column :tasks, :title, :string, limit: 30 #By default SQL String limit 255 character 
    end

    def down 
      change_column :tasks, :title, :string
      #Ex:- change_column("admin_users", "email", :string, :limit =>25)
    end
  end
end
