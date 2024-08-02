import gleam/erlang/atom
import gleam/result
import gleam/string

pub type Handle

type Option =
  atom.Atom

/// Opens and reads archive to get handle with useful info for library
pub fn zip_open(filename filename: String) -> Result(Handle, String) {
  atom.from_string("memory")
  |> result.map(fn(atm) {
    do_zip_open(string.to_utf_codepoints(filename), [atm])
  })
  |> result.map_error(fn(_) { "Error making atom" })
  |> result.flatten
}

@external(erlang, "zip", "zip_open")
fn do_zip_open(
  filename: List(UtfCodepoint),
  options: List(Option),
) -> Result(Handle, String)

pub type ZipFile {
  ZipFile(name: String, data: String)
}

pub fn zip_get(
  filename filename: String,
  handle handle: Handle,
) -> Result(ZipFile, String) {
  do_zip_get(string.to_utf_codepoints(filename), handle)
  |> result.map(fn(data) {
    ZipFile(name: string.from_utf_codepoints(data.0), data: data.1)
  })
}

/// opens file from zip archive
@external(erlang, "zip", "zip_get")
fn do_zip_get(
  filename: List(UtfCodepoint),
  handle: Handle,
) -> Result(#(List(UtfCodepoint), String), String)
