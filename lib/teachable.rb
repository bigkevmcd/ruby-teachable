class Teachable
  def when_send_then_return(method, ret)
    learnings[method] = ret
    self
  end

  def when_send_then_evaluate(method, &block)
    learnings[method] = block
    self
  end

  def accept_send(method)
    learnings[method] = self
  end

  private

  def learnings
    @learnings = {} unless defined? @learnings
    @learnings
  end

  def method_missing(m, *args, &block)
    return super unless learnings.key?(m.to_sym)
    ret = learnings[m.to_sym]
    return ret.call(*args) if ret.is_a?(Proc)
    ret
  end
end
