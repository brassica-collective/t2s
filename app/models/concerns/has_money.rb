module HasMoney
  extend ActiveSupport::Concern

  class_methods do
    def money(name, options = {})
      options = {:cents => "#{name}_cents".to_sym}.merge(options)
      mapping = [[options[:cents].to_s, 'cents']]

      composed_of name, :class_name => 'Money', :allow_nil => true, :mapping => mapping
    end
  end
end