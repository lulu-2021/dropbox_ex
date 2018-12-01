defmodule DropboxEx.Client do

  defstruct client_id: nil, access_token: nil, base_url: nil, upload_url: nil

  def new(access_token, base_url, upload_url) do
    %DropboxEx.Client{ access_token: access_token, base_url: base_url, upload_url: upload_url }
  end
end
