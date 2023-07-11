defmodule ChatterWeb.FeatureCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Wallaby.DSL
      import Chatter.Factory
      alias ChatterWeb.Router.Helpers, as: Routes

      @endpoint ChatterWeb.Endpoint
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Chatter.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Chatter.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Chatter.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
