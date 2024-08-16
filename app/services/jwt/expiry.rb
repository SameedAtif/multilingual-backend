# frozen_string_literal: true

module Jwt
  class Expiry
    class << self
      def expiry
        1.hour
      end
    end
  end
end
