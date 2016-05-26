class MyValidator < ActiveModel::Validator
  def validate(record)
    if FriendListSchedule.where(list_id: record.list_id, friend_id: record.friend_id).count > 0 
      record.errors[:name] << 'This already exists!'
    end
  end
end