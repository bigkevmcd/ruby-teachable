require "test_helper"

class TeachableTest < Minitest::Test
  def setup
    @teachable = Teachable.new
  end

  def test_send_then_return
    @teachable.when_send_then_return(:help, 'ok')

    assert_equal('ok', @teachable.help)
  end

  def test_send_then_return_with_nil
    @teachable.when_send_then_return(:get_nil, nil)

    assert_nil(@teachable.get_nil)
  end

  def test_send_with_evaluate
    @teachable.when_send_then_evaluate(:help) {
      'testing'
    }

    assert_equal('testing', @teachable.help)
  end

  def test_accept_send
    @teachable.accept_send(:test)

    assert_equal(@teachable.test, @teachable)
  end

  def test_with_unknown_method
    assert_raises(NoMethodError) {
      @teachable.testing
    }
  end

  def test_teachable
    @teachable.
      when_send_then_return(:help, 'ok').
      when_send_then_evaluate(:doit) { puts "inspecting 1" }.
      accept_send(:noDebugger).
      when_send_then_evaluate(:negate) { |num| -num }

    assert_equal('ok', @teachable.help)
    assert_equal(@teachable, @teachable.noDebugger)
    assert_equal(-120, @teachable.negate(120))
  end

end
