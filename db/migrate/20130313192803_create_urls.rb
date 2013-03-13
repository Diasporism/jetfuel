class CreateUrls < ActiveRecord::Migration

  def change
    create_table :urls do |t|
      t.string :long_url, :unique => true
      t.string :short_url, :unique => true
      t.timestamps
    end
  end

end
