class CreateRequests < ActiveRecord::Migration

  def change
    create_table :requests do |t|
      t.string :url, :unique => false
      t.timestamps
    end
  end

end
