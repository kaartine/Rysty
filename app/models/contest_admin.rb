class ContestAdmin < ActiveRecord::Base
  belongs_to :users
  belongs_to :contests
end
