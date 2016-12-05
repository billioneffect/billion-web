class ProjectApplicationsController < ApplicationController
  helper_method :component_partial, :help_text

  def new
    application_form_description = I18n.t("application_form", scope: competition_scope)
    @form = FormBuilder::Form.new(application_form_description)
  end

  def create
  end

  private

  def component_partial(component)
    "project_applications/form/#{component.class.name.demodulize.underscore}"
  end

  def help_text(text)
    ActionController::Base.helpers.sanitize text,
      tags: %w(p br strong b em i u ul ol li)
  end

  def competition_scope
    "competition_copy.#{@competition.code_name.parameterize.underscore}"
  end
end
