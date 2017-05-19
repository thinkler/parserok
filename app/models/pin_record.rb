# frozen_string_literal: true
class PinRecord < ApplicationRecord
  def bastards=(arr)
    self.bastards = to_string(arr)
  end

  def bastards
    bastards ? bastards.split(' ') : []
  end

  private

  def to_string(arr)
    arr ? arr.join(' ') : nil
  end
end
