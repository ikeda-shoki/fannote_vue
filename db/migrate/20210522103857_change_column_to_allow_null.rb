class ChangeColumnToAllowNull < ActiveRecord::Migration[6.0]
  def change
    change_column_null :notifications, :post_image_id, true
    change_column_null :notifications, :request_id, true
  end
end
