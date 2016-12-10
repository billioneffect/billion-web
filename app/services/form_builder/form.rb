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

      if !child.is_a?(Component) && !child.is_a?(Group)
        raise "Child must be a group or a component, got #{child.class}"
      end

      child.parent = self

      @children ||= []
      @children << child
    end

    def as_json(options = {})
      super(options).merge(type: self.class.name.demodulize)
    end

    def ==(o)
      as_json == o.as_json
    end

    private

    def instantiate_child(hash)
        klass = "FormBuilder::#{hash[:type]}".safe_constantize
        klass.new(hash.except(:type))
    end
  end
end
