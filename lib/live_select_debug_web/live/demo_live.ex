defmodule LiveSelectDebugWeb.DemoLive do
  use LiveSelectDebugWeb, :live_view

  def mount(_params, _session, socket) do
    changeset = change_data(empty_data(), %{})
    form_id = Ecto.UUID.generate()
    {:ok, assign(socket, changeset: changeset, form_id: form_id)}
  end

  def handle_event("save", %{"profile" => profile_params}, socket) do
    changeset = change_data(empty_data(), profile_params)

    case Ecto.Changeset.apply_action(changeset, :update) do
      {:ok, data} ->
        IO.puts("Pretend we did something interesting using a profile with:")
        IO.inspect(data)

        new_changeset = change_data(empty_data(), %{})

        # In order to "kick" the form into its default state we attach a new form id.
        {:noreply, assign(socket, changeset: new_changeset, form_id: Ecto.UUID.generate())}

      {:error, error_changeset} ->
        {:noreply, assign(socket, changeset: error_changeset)}
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

    <%# Without the form_id usage, the input widgets do not reset as wanted. %>
    <.form let={f} for={@changeset} as="profile" phx-submit="save" id={@form_id}>

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
