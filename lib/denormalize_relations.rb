if defined? Tire
  module DenormalizeRelations
    def parent_ids(hsh = {})
      r = reflections.select do |name, ref|
        ref.macro == :belongs_to
      end

      r.keys.map do |name|
        hsh.store(name.to_s + "_id", send(name).id)
        return send(name).parent_ids(hsh) if send(name).respond_to?(:parent_ids)
      end

      hsh
    end

    def to_indexed_json(*args, &block)
      JSON.parse(tire.__send__("to_indexed_json", *args, &block)).merge(parent_ids).to_json
    end
  end

  Tire::Model::Search.send(:include, DenormalizeRelations)
end
