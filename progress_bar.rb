class ProgressBar
  def initialize(total, label)
    @total   = total
    @counter = 1
    @label   = label
  end

  def increment
    complete = sprintf("%#.2f%", ((@counter.to_f / @total.to_f) * 100))
    print "\r\e[0K#{@label} #{@counter}/#{@total} (#{complete})"
    @counter += 1
  end
end
