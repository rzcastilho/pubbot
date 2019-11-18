use Mix.Config

config :logger, level: :debug

config :pubbot, Pubbot.Scheduler,
  jobs: []
