require 'nugrant/parameters'

module Clivers
  def self.parameters()
    @@parameters ||= Nugrant::Parameters.new({:config => {:params_filename => ".clivers"}})
  end
end
