module FormBuilder
  class Component
    include ActiveModel::Model
    include ActiveModel::Validations

    validates :label, presence: true

    attr_accessor :name, :label, :help_text, :parent, :required, :value

    def name
      @name || label.parameterize.underscore
    end

    def as_json(options = {})
      super(options.merge(except: 'parent')).merge(type: self.class.name.demodulize)
    end

    def ==(other)
      as_json == other.as_json
    end
  end
end
