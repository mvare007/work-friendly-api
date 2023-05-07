class ApiConstraint
  def matches?(request)
    request.format == :json || request.format == :xlsx
  end
end
