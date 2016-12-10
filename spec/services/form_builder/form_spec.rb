require 'rails_helper'

describe FormBuilder::Form do

  describe '#add' do
    context 'with hash' do
      it 'instantiate the child component' do
        form = FormBuilder::Form.new

        group = FormBuilder::Group.new
        group.add FormBuilder::Input.new label: 'Grouped Input label', parent: form

        input = FormBuilder::Input.new label: 'Input label', parent: form
        textarea = FormBuilder::Textarea.new label: 'Textarea label', parent: form

        form.add group.as_json
        form.add input.as_json
        form.add textarea.as_json

        expect(form.children).to eq([group, input, textarea])
      end
    end

    context 'with object' do
      it 'raise an error when adding unknown objects' do
        form = FormBuilder::Form.new
        expect { form.add 30 }.to raise_error
      end

      it 'add known objects' do
        form = FormBuilder::Form.new

        group = FormBuilder::Group.new
        group.add FormBuilder::Input.new label: 'Grouped Input label', parent: form

        input = FormBuilder::Input.new label: 'Input label', parent: form
        textarea = FormBuilder::Textarea.new label: 'Textarea label', parent: form

        form.add group
        form.add input
        form.add textarea

        expect(form.children).to eq([group, input, textarea])
      end
    end
  end

  describe '#children=' do
    it 'set new children' do
      group = FormBuilder::Group.new
      input = FormBuilder::Input.new label: 'Input label'

      form = FormBuilder::Form.new
      form.add input

      form.children = [group]

      expect(form.children).not_to include(input)
      expect(form.children).to include(group)
    end
  end

  describe 'as_json' do
    it 'includes the type' do
      expect(FormBuilder::Form.new.as_json).to include(type: "Form")
    end
  end
end
