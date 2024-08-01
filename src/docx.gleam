import gleam/pair
import gleam/string

pub type Xml
/// Scans xml file stored in String type, returns xml and unparsable part
pub fn scan_string(line: String) -> #(Xml, String) {
  do_scan_string(string.to_utf_codepoints(line))
  |> pair.map_second(string.from_utf_codepoints)
}

@external(erlang, "xmerl_scan", "string")
fn do_scan_string(string: List(UtfCodepoint)) -> #(Xml, List(UtfCodepoint))

pub type NodeEntity {
  XmlElement
  XmlAttribute 
  XmlText
  XmlPI
  XmlComment
  XmlNsNode
  XmlDocument
}

/// Should parse doc by given xpath, but erlang strange records are returned
pub fn xpath_string(xpath: String, doc: Xml) -> List(NodeEntity){
  xpath
  |> string.to_utf_codepoints
  |> do_xpath_string(doc)
}

@external(erlang, "xmerl_xpath", "string")
fn do_xpath_string(xpath: List(UtfCodepoint), doc: Xml) -> List(NodeEntity)
