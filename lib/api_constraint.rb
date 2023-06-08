class ApiConstraint
  def matches?(request)
    request.format == :json
  end
end
