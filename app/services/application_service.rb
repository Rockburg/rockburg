class ApplicationService
  include Interactor
  include Interactor::Contracts
  include Pundit

  def current_user
    context.user
  end

  def action_name
    self.class.name.split('::').last.underscore
  end
end
