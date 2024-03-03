# frozen_string_literal: true

module Api
  module V1
    class ApplicationPolicy
      attr_reader :doctor, :record

      def initialize(doctor, record)
        @doctor = doctor
        @record = record
      end

      def index?
        false
      end

      def update?
        false
      end

      class Scope
        def initialize(doctor, scope)
          @doctor = doctor
          @scope = scope
        end

        def resolve
          raise NoMethodError, "You must define #resolve in #{self.class}"
        end

        private

        attr_reader :doctor, :scope
      end
    end
  end
end
