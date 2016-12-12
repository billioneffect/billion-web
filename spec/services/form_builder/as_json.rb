shared_examples 'as_json with type' do
  describe '#as_json' do
    it 'should include the type in the resulting hash' do
      expect(subject.as_json).to include(type: subject.class.name.demodulize)
    end
  end
end
