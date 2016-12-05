module FormBuilder
  class Group < Form
    attr_accessor :label, :parent, :help_text

    def full_name
      "#{parent.full_name}_#{name.underscore}"
    end

    def name
      @name || label.parameterize.underscore
    end

    def as_json(options = {})
      super(options.merge(except: "parent")).merge(type: self.class.name.demodulize)
    end
  end
end
