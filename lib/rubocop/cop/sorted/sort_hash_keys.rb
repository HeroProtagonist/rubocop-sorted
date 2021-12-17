# frozen_string_literal: true

module RuboCop
  module Cop
    module Sorted
      # Checks that the keys of a hash are sorted alphabetically when enabled.
      # The configuration option `VariableNamesToCheck` can be set to an array
      # of strings. Only hashes assigned to variables matching the supplied
      # names will be inspected. By default, this option is not set.
      #
      #   # bad
      #   hash = {
      #     z: 1,
      #     a: 2
      #   }
      #
      #   # good
      #   hash = {
      #     a: 2,
      #     z: 1
      #   }
      #
      class SortHashKeys < Base
        extend AutoCorrector

        MSG = 'Key is not sorted alphabetically'

        def on_hash(node)
          @node = node

          return if targeted_investigation? && !variable_of_interest?

          return if hash_keys.map(&method(:str_from)) == sorted_key_strings

          add_offense_to_keys
          add_offense_to_hash
        end

        private

        attr_reader :node

        def hash_keys
          @hash_keys ||= node.keys
        end

        def sorted_key_strings
          @sorted_key_strings ||= hash_keys.map(&method(:str_from)).sort
        end

        def add_offense_to_keys
          sorted_key_strings.each_with_index do |key, index|
            unsorted_key_node = hash_keys[index]
            add_offense(unsorted_key_node) if key != str_from(unsorted_key_node)
          end
        end

        def add_offense_to_hash
          message = 'Hash keys are not sorted alphabetically'

          add_offense(node, message: message) do |corrector|
            node
              .each_pair
              .sort_by(&method(:str_from))
              .each_with_index do |pair, index|
                corrector.replace(node.children[index], pair.source)
              end
          end
        end

        def str_from(ast_node)
          return ast_node.key.value.to_s if ast_node.is_a?(AST::PairNode)

          ast_node.value.to_s
        end

        def targeted_investigation?
          variable_names_to_check.is_a?(Array) && variable_names_to_check.any?
        end

        def variable_of_interest?
          return false unless node.parent.assignment?

          variable_name = node.parent.children.first.to_s
          variable_names_to_check.include?(variable_name)
        end

        def variable_names_to_check
          @variable_names_to_check ||= cop_config['VariableNamesToCheck']
        end
      end
    end
  end
end
