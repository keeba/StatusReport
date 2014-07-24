class CreateWeeklytasks < ActiveRecord::Migration
  def change
    create_table :weeklytasks do |t|
      t.integer :year, :null => false 
      t.integer	:week_no, :null => false
      t.integer :user_id, :null => false
      t.string  :unplanned , :planned , :backlogs

      t.timestamps
    end
  end
end
