module Service
  extend ActiveSupport::Concern

  Error = Class.new(StandardError)

  module ClassMethods
    def call(**args)
      new(**args).call
    end
  end
end
