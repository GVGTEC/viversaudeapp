class CreateIcms < ActiveRecord::Migration[5.2]
  def change
    create_table :icms do |t|
      t.string :estado
      t.float :aliquota_icms
      t.float :aliquota_icms_st
      t.float :mva_icms_st
      t.string :fcp_sn
      t.float :fcp_pc

      t.timestamps
    end
  end
end
