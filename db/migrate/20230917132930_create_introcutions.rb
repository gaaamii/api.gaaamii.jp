class CreateIntrocutions < ActiveRecord::Migration[7.0]
  def change
    create_table :introcutions do |t|
      t.string :content

      t.timestamps
    end
  end
end
