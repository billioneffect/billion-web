class ProjectApplicationsController < ApplicationController
  helper_method :component_partial, :help_text

  before_action :set_form

  def new
  end

  def create
    @merger.merge form_params

    ProjectApplicationMailer
      .project_application(@form, @competition.competition_config.application_email)
      .deliver_now
  end

  private

  def form_params
    params.require(@form.name).permit @merger.permitted_keys
  end

  def set_form
    application_form_description = I18n.t("application_form", scope: competition_scope)
    @form = FormBuilder::Form.new(application_form_description)
    @merger = FormBuilder::ValueMerger.new @form

  end

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
