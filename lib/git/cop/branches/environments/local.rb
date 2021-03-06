# frozen_string_literal: true

require "open3"

module Git
  module Cop
    module Branches
      module Environments
        # Provides feature branch information for local development environment.
        class Local
          def initialize shell: Open3
            @shell = shell
          end

          def name
            result, _status = shell.capture2e "git rev-parse --abbrev-ref HEAD | tr -d '\n'"
            result
          end

          def shas
            result, _status = shell.capture2e %(git log --pretty=format:"%H" master..#{name})
            result.split("\n")
          end

          private

          attr_reader :shell
        end
      end
    end
  end
end
