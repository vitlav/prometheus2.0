class AddIndexInGroupIdToSrpmModel < ActiveRecord::Migration
  def change
    add_index :srpms, :group_id
  end
end
