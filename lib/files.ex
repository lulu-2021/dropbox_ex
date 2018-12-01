defmodule DropboxEx.Files do
  import DropboxEx

   def download(client, path) do
     dropbox_headers = %{
       :path => path
     }
     headers = %{ "Dropbox-API-Arg" => Poison.encode!(dropbox_headers) }
     download_request(client, "files/download", [], headers)
   end

   def list_folder(client, path) do
     body = %{"path" => path}
     result = to_string(Poison.Encoder.encode(body, []))
     post(client, "/files/list_folder", result)
   end

   def list_files_in_folder(client, path, filtered_by_file_ending \\ "*") do
     folder_metadata = list_folder(client, path)
     files = folder_metadata["entries"]
     |> Enum.filter(fn(entry) -> entry[".tag"] == "file" end)
     |> Enum.filter(fn(entry) ->
       case filtered_by_file_ending do
         "*" -> true
         _ -> List.last(String.split(entry["name"], ".")) == String.trim_leading(filtered_by_file_ending, ".")
       end
     end)
   end

   def list_filenames_in_folder(client, path, filtered_by_file_ending \\ "*") do
     filenames = list_files_in_folder(client, path, filtered_by_file_ending)
     |> Enum.map(fn(entry) -> entry["path_lower"] end)
   end
 end
