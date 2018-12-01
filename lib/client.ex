defmodule DropboxEx.Client do

  defstruct client_id: nil, access_token: nil

  def new(access_token) do
    %DropboxEx.Client{ access_token: access_token }
  end

end
