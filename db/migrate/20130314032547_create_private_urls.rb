class CreatePrivateUrls < ActiveRecord::Migration

  def change
    create_table :private_urls do |t|
      t.references :user
      t.string :long_url
      t.string :short_url, :uniqueness => true
      t.string :vanity_url
      t.timestamps
    end
  end

end
