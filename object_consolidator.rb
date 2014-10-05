class ObjectConsolidator

  MAP = {
    ['a', 'b'] => 'z'
  }

  def initialize(array)
    @array = array
  end

  def perform_consolidation
    MAP.each do |k, v|
      object_1 = get_object_with_oid(k[0])
      object_2 = get_object_with_oid(k[1])
      quantity = get_maximum_quantity_to_replace(object_1, object_2)
      if quantity > 0
        remove_or_decrement_element(object_1, quantity)
        remove_or_decrement_element(object_2, quantity)
        create_new_object(v, quantity)
      end
    end
  end

  def get_object_with_oid(oid)
    @array.find { |e| e[:oid] == oid }
  end

  def get_maximum_quantity_to_replace(object_a, object_b)
    return 0 if object_a.nil? || object_b.nil?
    [object_a[:quantity], object_b[:quantity]].min
  end
  
  def remove_or_decrement_element(object, quantity)
    if object[:quantity] == quantity
      index = @array.find_index(object)
      @array[index] = nil
      @array.compact!
    else
      object[:quantity] -= quantity
    end
  end

  def create_new_object(oid, quantity)
    @array << { oid: oid, quantity: quantity }
  end

end
