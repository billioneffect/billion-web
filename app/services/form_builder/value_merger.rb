module FormBuilder
  class ValueMerger

    def initialize(form)
      @form = form
    end

    def merge(value_hash)
      merge_values @form, hash_with_root(value_hash)
    end

    def permitted_keys
      hash_without_root permitted_keys_for(@form)
    end

    private

    def hash_with_root(hash)
      hash.has_key?(@form.name) ? hash : { @form.name => hash }
    end

    def hash_without_root(hash)
      hash.has_key?(@form.name) ? hash[@form.name] : hash
    end

    def merge_values(node, value_hash)
      if node.respond_to? :children
        node.children.each { |child| merge_values(child, value_hash[node.name]) }
      else
        node.value = value_hash[node.name]
      end

      node
    end

    def permitted_keys_for(node)
      if node.respond_to? :children
        {node.name => node.children.map { |child| permitted_keys_for(child) }}
      else
        node.name
      end
    end
  end
end
