class Wobauth::User < ActiveRecord::Base
  # dependencies within wobauth models
  include Wobauth::Concerns::Models::User

  devise :database_authenticatable
end

