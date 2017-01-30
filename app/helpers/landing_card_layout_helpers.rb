module LandingCardLayoutHelpers
  RULES = {
    4 => { offset: 0, width: 3 },
    3 => { offset: 1, width: 4 },
    2 => { offset: 1, width: 6 },
    1 => { offset: 0, width: 3 }
  }
  COLUMN_COUNT = 12

  def layout_projects(projects, &block)
    count = projects.count
    rule = get_rule(count)

    content_tag :div, class: container_class(rule) do
      concat(
        content_tag(:div, class: 'row') do
          projects.each do |project|
            concat(
              content_tag(:div, class: card_class(rule)) do
                capture(project, &block)
              end
            )
          end
        end
      )
    end
  end

  private

  def get_rule(count)
    RULES
      .select { |k, v| count % k == 0 }
      .first[1]
  end

  def container_class(rule)
    offset = rule[:offset]
    %(col-md-offset-#{offset} col-md-#{COLUMN_COUNT - offset * 2})
  end

  def card_class(rule)
    width = rule[:width]
    %(col-md-#{width})
  end
end
