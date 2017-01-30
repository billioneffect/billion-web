module FormBuilder
  class Subgroup < Group
    attr_accessor :label, :parent, :help_text

    validates :label, presence: true

    def name
      @name || label.parameterize.underscore
    end

    def as_json(options = {})
      super(options.merge(except: 'parent')).merge(type: self.class.name.demodulize)
    end

    private

    def validate_child!(child)
      if !child.is_a?(Component)
        fail "Child must be a component, got #{child.class}"
      end
    end
  end
end
