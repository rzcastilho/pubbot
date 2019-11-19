import Config

config :logger, level: :info

config :pubbot, Pubbot.Scheduler,
  jobs: [
    # Every minute
    {
      "* * * * *",
      {
        Pubbot,
        :publish,
        [
          [username: "guest", password: "guest", virtual_host: "/", host: "rabbitmq", port: 5672],
          "event.exchange",
          "",
          [content_type: "application/json"],
          "/app/templates/event.eex"
        ]
      }
    },
    # Every 15 minutes
    {
      "*/5 * * * *",
      {
        Pubbot,
        :publish,
        [
          [username: "guest", password: "guest", virtual_host: "/", host: "rabbitmq", port: 5672],
          "",
          "hello.queue",
          [content_type: "application/json"],
          "/app/templates/hello.eex",
          [name: "Pubbot"]
        ]
      }
    }
  ]
