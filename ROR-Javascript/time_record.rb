class TimeRecord < ActiveRecord::Base
  attr_accessible :duration, :description, :parent_id
end
