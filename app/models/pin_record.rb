class PinRecord < ApplicationRecord
  def set_bastards(arr)
    self.bastards = to_string(arr)
  end

  def get_bastards
    bastards ? bastards.split(" ") : []
  end

  private

  def to_string(arr)
    arr ? arr.join(" ") : nil
  end
end
