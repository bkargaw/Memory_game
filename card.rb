class Card
  attr_accessor :value, :face_up

  def initialize(value)
    @value = value
    @face_up = false
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def to_s
    value_length = value.to_s.length
    empty_space = " " * (6 - value_length)
    face_up ? "#{value}#{empty_space}" : " " * 6
  end

  def ==(other_card)
    value == other_card.value
  end
end
