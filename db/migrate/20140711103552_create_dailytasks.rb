class CreateDailytasks < ActiveRecord::Migration
  def change
    create_table :dailytasks do |t|
      t.integer :weekly_taks_id, :null => false
      t.timestamp :date, :null => false
      t.string :accomplishments , :plans , :issues

      t.timestamps
    end
  end
end
