class PicParser < ProgressJob::Base
  include PicsParser

  def initialize(urls, progress_max)
    super progress_max: progress_max
    @urls = ursl
  end

  def perform
    update_stage('Parsing pictures')
    parse_urls(@urls)
  end
end
