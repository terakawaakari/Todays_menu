class Direction < ApplicationRecord

  attachment :process_image

  belongs_to :recipe

end
