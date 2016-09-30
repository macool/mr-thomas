class Notification
  include Mongoid::Document

  field :referrer, type: String
  field :parameters, type: String

  belongs_to :subscriber
end
