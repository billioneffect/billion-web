module VoteButtonHelpers
  # def link_to_vote(project, options = nil, html_options = nil)
  def link_to_vote(project, name = nil, html_options = nil, &block)

    if project.competition.open_donation
      if project.competition.has_feature?(:sms_voting)
        link_with_modal project, name, html_options, &block
      else
        link_to name, new_transaction_path(project_id: project.id), html_options, &block
      end
    end
  end

  private

  def link_with_modal(project, name = nil, html_options = nil, &block)

    # mirror Rails's link_to
    name, html_options, block= nil, name, block if block_given?

    modal_id = "sms_vote_#{project.id}"
    html_options = html_options.merge({
      'data-toggle' => 'modal',
      'data-target' => "##{modal_id}"
    })

    Rails.logger.debug([name, html_options, block].join"\n")

    capture do
      if block_given?
        concat link_to('#', html_options, &block)
      else
        concat link_to(name, '#', html_options)
      end
      concat render partial: 'shared/sms_modal', locals: {
        modal_id: modal_id,
        project: project
      }
    end
  end
end
