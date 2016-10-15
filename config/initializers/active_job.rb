Rails.application.configure do
  unless Rails.env == 'test'
    config.active_job.queue_adapter = :delayed_job
  end
end
