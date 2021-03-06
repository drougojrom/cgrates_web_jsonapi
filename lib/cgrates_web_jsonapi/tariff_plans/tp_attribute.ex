defmodule CgratesWebJsonapi.TariffPlans.TpAttribute do
  use Ecto.Schema
  import Ecto.Changeset
  use EctoConditionals, repo: CgratesWebJsonapi.Repo
  @attributes ~w[tpid tenant custom_id contexts filter_ids activation_interval blocker weight
                 attribute_filter_ids path value cg_type]a

  use CgratesWebJsonapi.CsvImport, module: __MODULE__, attributes: @attributes

  @primary_key {:pk, :id, autogenerate: true}
  @derive {Phoenix.Param, key: :pk}
  schema "tp_attributes" do
    field :id, :integer, source: :pk
    field :tpid, :string
    field :tenant, :string
    field :custom_id, :string, source: :id
    field :contexts, :string, default: ""
    field :filter_ids, :string, default: ""
    field :activation_interval, :string, default: ""
    field :blocker, :boolean
    field :weight, :decimal, default: 0
    field :attribute_filter_ids, :string, default: ""
    field :path, :string
    field :cg_type, :string, source: :type
    field :value, :string

    field :created_at, :naive_datetime
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @attributes)
    |> validate_required([:tpid, :tenant, :custom_id, :path, :value, :cg_type])
    |> validate_length(:tpid, max: 64)
    |> validate_length(:tenant, max: 64)
    |> validate_length(:custom_id, max: 64)
    |> validate_length(:contexts, max: 64)
    |> validate_length(:filter_ids, max: 64)
    |> validate_length(:activation_interval, max: 64)
    |> validate_length(:attribute_filter_ids, max: 64)
    |> validate_length(:path, max: 64)
    |> validate_length(:cg_type, max: 64)
    |> validate_length(:value, max: 64)
  end
end
