class Position < ActiveRecord::Base
  belongs_to :article
  belongs_to :businessprocess
end
