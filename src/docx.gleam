import gleam/pair
import gleam/string

pub type Xml

pub fn scan_string(line: String) -> #(Xml, String) {
  do_scan_string(string.to_utf_codepoints(line))
  |> pair.map_second(string.from_utf_codepoints)
}

@external(erlang, "xmerl_scan", "string")
fn do_scan_string(string: List(UtfCodepoint)) -> #(Xml, List(UtfCodepoint))

pub type Any

pub fn xpath_string(xpath: String, doc: Xml) -> Any {
  xpath
  |> string.to_utf_codepoints
  |> do_xpath_string(doc)
}

@external(erlang, "xmerl_xpath", "string")
fn do_xpath_string(xpath: List(UtfCodepoint), doc: Xml) -> Any
