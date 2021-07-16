class Product < ApplicationRecord
  belongs_to :movimentation , :optional => true

end
