module ProgressBarHelpers
  def progress_bar(fraction, animated: false, height: nil, width: nil)
    fraction = [1, fraction].min
    capture do
      content_tag :div, class: "billion-progress-bar #{animated ? 'animated' : ''}"  do
        tag :div, class: "billion-progress-bar-active", style: "width: %.2f%" % (fraction * 100)
      end
    end
  end
end
