# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Sorted::SortHashKeys, :config do
  let(:config) { RuboCop::Config.new }

  # TODO: Write test code
  #
  # For example
  it 'registers and corrects an offense when hash has keys are not sorted alphabetically' do
    expect_offense(<<~RUBY)
      hash = {
             ^ Hash keys are not sorted alphabetically
        foo: '123',
        ^^^ Key is not sorted alphabetically
        'bar' => :baz,
        ^^^^^ Key is not sorted alphabetically
        zoo: 2
      }
    RUBY

    expect_correction(<<~RUBY)
      hash = {
        'bar' => :baz,
        foo: '123',
        zoo: 2
      }
    RUBY
  end

  it 'does not register an offense when hash keys are sorted alphabetically' do
    expect_no_offenses(<<~RUBY)
      hash = {
        'bar' => :baz,
        foo: '123',
        zoo: 2
      }
    RUBY
  end
end
