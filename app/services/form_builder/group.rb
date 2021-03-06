module FormBuilder
  class Group < Form
    attr_accessor :label, :parent, :help_text, :help_text_title, :collapsible, :expanded

    validates :label, presence: true

    def initialize(*args)
      super
      @expanded = @expanded.nil? ? true : @expanded
    end

    def name
      @name || label.parameterize.underscore
    end

    def as_json(options = {})
      super(options.merge(except: 'parent')).merge(type: self.class.name.demodulize)
    end
  end
end
