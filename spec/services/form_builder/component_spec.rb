require 'rails_helper'
require_relative './as_json'

describe FormBuilder::Component do
  describe 'validations' do
    subject { FormBuilder::Component.new }

    it { is_expected.to validate_presence_of :label }
  end

  describe '#name' do
    context 'without specific name' do
      it 'uses the label as a basis for the name' do
        label = 'Label with multiple words.'
        component = FormBuilder::Component.new label: label
        expect(component.name).to eq(label.parameterize.underscore)
      end
    end
  end

  include_examples 'as_json with type'
end
