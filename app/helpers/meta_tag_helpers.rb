module MetaTagHelpers
  # Define helpers for setting meta data
  #
  # name: the name of the meta data
  #
  # default: a default value. If a callable is given, it will be evaluated in
  # the context of the view.
  #
  # formatter: a callable that is used to format the value.
  #
  # Examples:
  #
  # ```
  # meta_helper :title, default: 'Billion',
  #                     formatter: ->(title) { "#{title} | Billion" }
  # `` `
  #
  # This will define two helper methods: meta_title and set_meta_title.
  # The default value of meta_title is 'Billion'.
  # Calling `set_meta_title('Title')` will set the meta_title to `'Title | Billion '`
  #
  # ```
  # meta_helper :image, default: -> { image_url('img.png') }
  # ```
  #
  # In this case, meta_image will have a default value of '/assets/img.png'
  def self.meta_helper(name, default: nil, formatter: nil)
    meta_name = "meta_#{name}"
    variable_name = "@#{meta_name}".to_sym

    define_method meta_name do
      variable_value = instance_variable_get(variable_name)
      if variable_value.present?
        variable_value
      else
        default.respond_to?(:call) ? instance_exec(&default) : default
      end
    end

    define_method "set_#{meta_name}" do |value|
      new_value = formatter.respond_to?(:call) ? formatter.call(value) : value
      instance_variable_set(variable_name, new_value)
    end
  end

  meta_helper :title,
    default: -> {
      I18n.t("#{competition_scope}.meta.default_title", default: 'meta.default_title'.to_sym)
    },
    formatter: ->(title) { "#{title} | Billion" }

  meta_helper :description, default: -> {
    I18n.t("#{competition_scope}.meta.default_description", default: 'meta.default_description'.to_sym)
  }

  meta_helper :image, default: -> {
    I18n.t("#{competition_scope}.meta.default_image_url", default: image_url('share-image.png'))
  }

  meta_helper :canonical, default: -> { request.original_url }
end
