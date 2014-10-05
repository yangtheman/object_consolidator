require_relative '../object_consolidator'
require 'rspec'

describe ObjectConsolidator do

  let(:object_a) { {oid: 'a', quantity: 4 } }
  let(:object_b) { {oid: 'b', quantity: 3 } }
  let(:object_c) { {oid: 'c', quantity: 5 } }
  let(:object_d) { {oid: 'd', quantity: 1 } }

  describe '#get_object_with_oid' do
    let(:array) { [object_a, object_b] }

    it 'should return an object with given oid if found' do
      oc = ObjectConsolidator.new(array)
      expect(oc.get_object_with_oid('a')).to eql(object_a)
    end

    it 'should return nil with given oid if not found' do
      oc = ObjectConsolidator.new(array)
      expect(oc.get_object_with_oid('c')).to be_nil
    end
  end

  describe '#get_maximum_quantity_to_replace' do
    it 'should return 0 if one of arguments is nil' do
      oc = ObjectConsolidator.new([])
      expect(oc.get_maximum_quantity_to_replace(object_a, nil)).to eql(0)
      expect(oc.get_maximum_quantity_to_replace(nil, object_a)).to eql(0)
    end

    it 'should return mininum quantity of two objects' do
      oc = ObjectConsolidator.new([])
      expect(oc.get_maximum_quantity_to_replace(object_a, object_b)).to eql(3)
    end
  end

  describe '#remove_or_decrement_element' do
    let(:array) { [object_a, object_b] }

    it 'should return nil if given quanity is equal to quanity attribute' do
      oc = ObjectConsolidator.new(array)
      oc.remove_or_decrement_element(object_a, 4)
      result = oc.get_object_with_oid('a')
      expect(result).to be_nil
    end

    it 'should return the object with less quantity if given quanity is less than quanity attribute' do
      oc = ObjectConsolidator.new(array)
      oc.remove_or_decrement_element(object_a, 3)
      result = oc.get_object_with_oid('a')
      expect(result[:quantity]).to eql(1)
    end
  end

  describe '#create_new_object' do
    it 'should return a new object with oid and quantity' do
      oc = ObjectConsolidator.new([])
      result = oc.create_new_object('f', 4)
    end
  end

  describe '#perform_consolidation' do
    let(:array) { [object_a, object_b] }

    it 'should consolidate objects' do
      oc = ObjectConsolidator.new(array)
      oc.perform_consolidation
      expect(oc.get_object_with_oid('a')).to eql({oid: 'a', quantity: 1})
      expect(oc.get_object_with_oid('b')).to be_nil
      expect(oc.get_object_with_oid('z')).to eql({oid: 'z', quantity: 3})
    end
  end

end
