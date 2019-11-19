use Mix.Config

config :logger, level: :info

config :pubbot, Pubbot.Scheduler,
  jobs: []
