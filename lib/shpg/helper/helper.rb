class String
  def camelize()
    parts = self.scan(/[[:alnum:]]+/)
    return parts.map(&:capitalize).join
  end

  def snakify()
    parts = self.scan(/[[:alnum:]]+/)
    return parts.map(&:downcase).join("_")
  end

  def cutDfd()
    result = self.split(/^[^a-zA-Z_]*/)
    return result[1]
  end
end

if $0 == __FILE__
  puts("3my 3nam3e is_dash".camelize)
  puts("3my 3nam3e is_dash".snakify.cutDfd)
end
