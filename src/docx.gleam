import gleam/erlang/atom
import gleam/result
import gleam/string

pub type Handle

type Option =
  atom.Atom

pub fn zip_open(filename: String) -> Result(Handle, String) {
  atom.from_string("memory")
  |> result.map(fn(atm) {
    do_zip_open(string.to_utf_codepoints(filename), [atm])
  })
  |> result.map_error(fn(_) { "Error making atom" })
  |> result.flatten
}

@external(erlang, "zip", "zip_open")
pub fn do_zip_open(
  filename: List(UtfCodepoint),
  options: List(Option),
) -> Result(Handle, String)

pub type ZipFile {
  File(name: String, data: String)
}

pub fn zip_get(filename: String, handle: Handle) -> Result(ZipFile, String) {
  do_zip_get(string.to_utf_codepoints(filename), handle)
  |> result.map(fn(data) {
    File(name: string.from_utf_codepoints(data.0), data: data.1)
  })
}

@external(erlang, "zip", "zip_get")
fn do_zip_get(
  filename: List(UtfCodepoint),
  handle: Handle,
) -> Result(#(List(UtfCodepoint), String), String)
