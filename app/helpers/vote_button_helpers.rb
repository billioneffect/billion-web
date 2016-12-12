module VoteButtonHelpers
  def link_to_vote_always_show(project, name = nil, html_options = nil, &block)
    link_to_vote(project, name, html_options, &block) ||
      capture(&(block || proc { concat name }))
  end

  def link_to_vote(project, name = nil, html_options = nil, &block)
    if project.competition.open_donation
      if project.competition.has_feature?(:project_page)
        project_link_only project, name, html_options, &block
      elsif project.competition.has_feature?(:sms_voting)
        link_with_modal project, name, html_options, &block
      else
        transaction_link_only project, name, html_options, &block
      end
    end
  end

  private

  def transaction_link_only(project, name = nil, html_options = nil, &block)
    html_options, block, name = name, html_options, capture(&block) if block_given?

    link_to name, new_project_transaction_path(project), html_options
  end

  def project_link_only(project, name = nil, html_options = nil, &block)
    html_options, block, name = name, html_options, capture(&block) if block_given?

    link_to name, project_path(project), html_options
  end

  def link_with_modal(project, name = nil, html_options = nil, &block)
    html_options, block, name = name, html_options, capture(&block) if block_given?

    modal_id = "sms_vote_#{project.id}"
    html_options = html_options.merge({
      'data-toggle' => 'modal',
      'data-target' => "##{modal_id}"
    })

    capture do
      concat link_to(name, '#', html_options)
      concat render partial: 'shared/sms_modal', locals: {
        modal_id: modal_id,
        project: project
      }
    end
  end
end
