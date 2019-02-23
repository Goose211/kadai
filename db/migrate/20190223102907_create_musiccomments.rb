class CreateMusiccomments < ActiveRecord::Migration[5.2]
  def change
    create_table :Musiccomments do |t|
      t.string :artist
      t.string :album
      t.string :track
      t.string :image
      t.string :sampleurl
      t.text :comment
      t.string :crossroads
      t.integer :userid
      t.timestamps null: false
    end
  end
end
