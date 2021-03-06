class Api::V1::PlayerSerializer
  include FastJsonapi::ObjectSerializer

  set_type :execution

  attributes :id, :start_date, :end_date, :elapsed_tipe

  belongs_to :movie
end
