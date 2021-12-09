defmodule LiveSelectDebugWeb.DemoLive do
  use LiveSelectDebugWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, changeset: change_data(empty_data(), %{}))}
  end

  def handle_event("save", %{"profile" => profile_params}, socket) do
    # IO.inspect(socket.assigns.changeset, label: "incoming changeset")

    changeset = change_data(empty_data(), profile_params)
    socket = assign(socket, changeset: changeset)
    # IO.inspect(socket.assigns.changeset, label: "mid changeset")

    case Ecto.Changeset.apply_action(changeset, :update) do
      {:ok, data} ->
        IO.puts("Fake making a profile with:")
        IO.inspect(data)

        new_changeset = change_data(empty_data(), %{})
        IO.inspect(new_changeset, label: "fresh new_changeset")

        {:noreply, assign(socket, changeset: new_changeset)}

      {:error, changeset} ->
        IO.inspect(changeset, label: "error changeset")
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp empty_data do
    %{name: nil, color: nil}
  end

  defp change_data(data, params) do
    types = %{name: :string, color: :string}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required([:name, :color])
  end

  def color_values do
    [
      "Red",
      "Green",
      "Blue"
    ]
  end

  def render(assigns) do
    ~H"""
    <h1>Demo</h1>

    <.form let={f} for={@changeset} as="profile" phx-submit="save">

      <div class="form-group">
        <%= label f, :name, "Name" %>
        <%= text_input f, :name %>
        <%= error_tag f, :name %>
      </div>

      <div class="form-group">
        <%= label f, :color, "Color" %>
        <%= select f,
          :color,
          color_values(),
          prompt: "Select a color..."
        %>
        <%= error_tag f, :color %>
      </div>

      <div class="form-group">
        <%= submit "Save Profile" %>
      </div>

    </.form>
    """
  end
end
