class BoundingArea

  def initialize(boxes)
    @boxes = []
    @boxes << boxes
  end

  def boxes_contain_point?(x, y)
    answer = false
    @boxes.map do |array|
      array.map do |box|
        if box.contains_point?(x, y)
          answer = true
        end
      end
    end
    answer
  end

end
