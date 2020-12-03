module JsonapiRendererDocument

  # Graphiti v1.2.19 uses jsonapi-render gem (v 0.2.0) to render resources as JSON
  # jsonapi-renderer-0-2-0/lib/jsonapi/renderer/document.rb has `document_hash` method
  # which has been patched here to modify format of the returned hash.
  #
  def document_hash
    res_hash = {}.tap do |hash|
      if @relationship
        hash.merge!(relationship_hash)
      elsif @data != :no_data
        hash.merge!(data_hash)
      elsif @errors.any?
        hash.merge!(errors_hash)
      end
      hash[:links]   = @links   if @links.any?
      hash[:meta]    = @meta    unless @meta.nil?
      hash[:jsonapi] = @jsonapi unless @jsonapi.nil?
    end

    # This is only added to this method
    # which is invoked to return a deeply nested response.
    # This is implemented to simplify the front end logic to
    # fetch included (relationships) data.
    #
    res_hash[:data] = post_process(res_hash)
    res_hash.delete(:included)
    res_hash
  end

  def post_process(hash)

    return hash[:data] if hash[:included].blank?

    if hash[:data].respond_to?(:to_ary)
      hash[:data].map do |primary_resource|
        build_nested_data_hash(primary_resource, hash[:included], @include)
      end
    else
      hash[:data] = build_nested_data_hash(hash[:data], hash[:included], @include)
    end
    hash[:data]
  end

  def build_nested_data_hash(primary, included, include)

    return if include.keys.blank?

    include.keys.each do |include_name|

      data_set = Set.new

      if primary[:relationships][include_name][:data].respond_to?(:to_ary)
        primary[:relationships][include_name].delete(:data).each do |data|
          data_set.add?([data[:type], data[:id]])
        end
      else
        data_set.add?(
          [primary[:relationships][include_name][:data][:type],
           primary[:relationships][include_name][:data][:id]]
        )
      end

      included_data = included.select do |include_data|
        data_set.include?([include_data[:type], include_data[:id]])
      end

      primary[:relationships][include_name][:data] =
        primary[:relationships][include_name][:data].nil? ? included_data : included_data[0]

      if primary[:relationships][include_name][:data].respond_to?(:to_ary)
        primary[:relationships][include_name][:data].each do |include_obj|
          build_nested_data_hash(include_obj, included, include[include_name])
        end
      else
        build_nested_data_hash(primary[:relationships][include_name][:data], included, include[include_name])
      end
    end

    primary
  end
end

JSONAPI::Renderer::Document.prepend(JsonapiRendererDocument)
