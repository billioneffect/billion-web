module VoteButtonHelpers
  # def link_to_vote(project, options = nil, html_options = nil)
  def link_to_vote(project, name = nil, html_options = nil, &block)
    # mirror Rails's link_to
    html_options, options, name = options, name, block if block_given?

    show_sms = true

    if project.competition.open_donation
      if show_sms
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
      else
        link_to name, new_transaction_path(project_id: project.id), html_options
      end
    end
  end
end
