module Logable
  extend ActiveSupport::Concern

  included do
    has_many :logs, class_name: 'Log', foreign_key: 'logable_id'

    def track_log(user_id)
      Log.create!(user_id: user_id, logable_id: id, logable_type: self.class.name)
    end
  end

end