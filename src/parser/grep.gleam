import gleam/list
import gleam/string


/// Filters text whole by find term and returns lines wherer term found
pub fn filter_text(in text: String,find find: String) -> List(String) {
  text
  |> string.split(on: "\n")
  |> filter_lines(find: find, in: _)
}
/// Filter list of lines and returns filtered lines
pub fn filter_lines(find find: String, in lines: List(String)) -> List(String) {
  lines
  |> list.filter(string.contains(_, find)) 
}
