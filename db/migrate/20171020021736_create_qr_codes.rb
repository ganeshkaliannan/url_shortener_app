class CreateQrCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :qr_codes do |t|
      t.text :qr_text

      t.timestamps
    end
  end
end
