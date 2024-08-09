module Importers
  def self.for(format)
    "Importers::#{format.camelize}Importer".constantize
  end
end
