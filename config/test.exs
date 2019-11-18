use Mix.Config

config :logger, level: :debug

config :pubbot, Pubbot.Scheduler,
  jobs: [
    # Every minute
    {
      "* * * * *",
      {
        Pubbot,
        :publish,
        [
          [username: "guest", password: "guest", virtual_host: "/", host: "localhost", port: 5672],
          "amqp.notificacao",
          "",
          [content_type: "application/json"],
          "templates/some_event.eex"
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
          [username: "guest", password: "guest", virtual_host: "/", host: "localhost", port: 5672],
          "",
          "source.ofertas.colaborar.campus",
          [content_type: "application/json"],
          "templates/hello.eex",
          [name: "Pubbot"]
        ]
      }
    }
  ]
