every 1.hour do
  runner 'CreateBetsWorker.perform_async'
end
