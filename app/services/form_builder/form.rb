module FormBuilder
  class Form
    include ActiveModel::Model

    attr_reader :children
    attr_accessor :name

    def children=(children)
      @children = []
      children.each { |child| add child }
    end

    def add(child)
      child = instantiate_child(child) if child.is_a? Hash

      validate_child!(child)

      child.parent = self

      @children ||= []
      @children << child
    end

    def as_json(options = {})
      super(options).merge(type: self.class.name.demodulize)
    end

    def ==(other)
      as_json == other.as_json
    end

    private

    def validate_child!(child)
      if !child.is_a?(Component) && !child.is_a?(Group)
        fail "Child must be a group or a component, got #{child.class}"
      end
    end

    def instantiate_child(hash)
      klass = "FormBuilder::#{hash[:type]}".safe_constantize
      klass.new(hash.except(:type))
    end
  end
end
