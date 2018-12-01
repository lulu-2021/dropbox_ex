defmodule DropboxEx do
  @moduledoc """
    Documentation for DropboxEx. wrapper for dropbox api v2
  """
  use HTTPoison.Base

  @base_url Application.get_env(:dropbox_ex, :base_url)
  @upload_url Application.get_env(:dropbox_ex, :upload_url)

  def download_request(client, url, data, headers) do
    headers = Map.merge(headers, headers(client))

    IO.puts "\n---------\n"
    IO.inspect headers
    IO.inspect upload_url()
    IO.inspect url
    IO.inspect data
    IO.puts "\n---------\n"

    response = HTTPoison.post!("#{upload_url()}#{url}", data, headers)

    IO.inspect response

    response
    |> download_response
  end

    def download_response(response) do
    case response do
      {:ok, %{body: body, headers: headers, status_code: 200}} ->
        {:ok, %{file: body, headers: get_header(headers, "dropbox_api_result") |> Poison.decode}}
      _ -> response
    end
  end

  defp get_header(headers, key) do
    headers
    |> Enum.filter(fn({k, _}) -> k == key end)
    |> hd
    |> elem(1)
  end

  defp headers(client), do: %{ "Authorization" => "Bearer #{client.access_token}" }

  defp json_headers, do: %{ "Content-Type" => "application/json" }

  defp base_url() do
    url = @base_url
    case url do
      nil -> "https://api.dropboxapi.com/2/"
      _ -> url
    end
  end

  defp upload_url do
    url = @upload_url
    case url do
      nil -> "https://content.dropboxapi.com/2/"
      _ -> url
    end
  end
end
