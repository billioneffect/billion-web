require 'rails_helper'
require_relative './as_json'

describe FormBuilder::Textarea do
  describe 'validations' do
    subject { FormBuilder::Textarea.new }

    it do
      is_expected.to validate_numericality_of(:rows)
        .is_greater_than_or_equal_to(0)
        .only_integer
        .allow_nil
    end
  end

  include_examples 'as_json with type'
end
