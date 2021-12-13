# frozen_string_literal: true

module RuboCop
  module Cop
    module Sorted
      # TODO: Write cop description and example of bad / good code. For every
      # `SupportedStyle` and unique configuration, there needs to be examples.
      # Examples must have valid Ruby syntax. Do not use upticks.
      #
      # @safety
      #   Delete this section if the cop is not unsafe (`Safe: false` or
      #   `SafeAutoCorrect: false`), or use it to explain how the cop is
      #   unsafe.
      #
      # @example EnforcedStyle: bar (default)
      #   # Description of the `bar` style.
      #
      #   # bad
      #   bad_bar_method
      #
      #   # bad
      #   bad_bar_method(args)
      #
      #   # good
      #   good_bar_method
      #
      #   # good
      #   good_bar_method(args)
      #
      # @example EnforcedStyle: foo
      #   # Description of the `foo` style.
      #
      #   # bad
      #   bad_foo_method
      #
      #   # bad
      #   bad_foo_method(args)
      #
      #   # good
      #   good_foo_method
      #
      #   # good
      #   good_foo_method(args)
      #
      class SortHashKeys < Base
        extend AutoCorrector

        MSG = 'Key is not sorted alphabetically'

        def on_hash(node)
          @node = node

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
      end
    end
  end
end
