require 'spec_helper'
require 'sweet_params'

describe SweetParams do
  let(:params) { ActionController::Parameters.new(scope: 'recent', filter: { scope: 'recent' }, empty: '') }

  describe '#has?' do
    it 'should respond to method' do
      params.must_respond_to :has?
    end

    it 'should be true if parameter is present' do
      params.has?(:scope, in: [:recent, :new]).must_equal true
    end

    it 'should be false if parameter is missing' do
      params.has?(:empty).must_equal false
      params.has?(:not_here).must_equal false
    end

    it 'should handle multi-dimensional params hash' do
      params.has?([:filter, :scope]).must_equal true
    end

    it 'should handle multi-dimensional params hash' do
      params.has?([:filter, :not_here]).must_equal false
    end

    it 'should use single value as whitelist' do
      params.has?(:scope, in: :recent).must_equal true
    end

    it 'should use array as whitelist' do
      params.has?(:scope, in: [:recent, :new]).must_equal true
    end

    it 'should not allow not whitelisted params' do
      params.has?(:scope, in: [:hot, :new]).must_equal false
    end
  end

  describe '#validate' do
    it 'should respond to method' do
      params.must_respond_to :validate
    end

    it 'should allow whitelisted param' do
      params.validate(:scope, in: [:hot, :recent]).must_equal 'recent'
    end

    it 'should return nil for not whitelisted param' do
      params.validate(:scope, in: [:hot, :new]).must_equal nil
    end
  end

  describe '#validate_to_sym' do
    it 'should respond to method' do
      params.must_respond_to :validate_to_sym
    end

    it 'should symbolize whitelisted param' do
      params.validate_to_sym(:scope, in: [:hot, :recent]).must_equal :recent
    end

    it 'should return nil for not whitelisted param' do
      params.validate_to_sym(:scope, in: [:hot, :new]).must_equal nil
    end
  end
end
