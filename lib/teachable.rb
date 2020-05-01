class Teachable
  def initialize
    @methods = {}
  end

  def when_send_then_return(method, ret)
    @methods[method] = ret
    self
  end

  def when_send_then_evaluate(method, &block)
    @methods[method] = block
    self
  end

  def accept_send(method)
    @methods[method] = self
  end

  private

  def method_missing(m, *args, &block)
    return super unless @methods.key?(m.to_sym)
    ret = @methods[m.to_sym]
    return ret.call(*args) if ret.is_a?(Proc)
    ret
  end
end
