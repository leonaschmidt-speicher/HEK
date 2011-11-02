module ActiveRecord
  module QueryMethods
    def where!(opts, *rest)
      return self if opts.blank?

      relation = self
      relation.where_values += build_where opts, rest
      relation
    end
  end
end