import gleam/string
import gleam/pair
import gleam/erlang/atom.{type Atom}
pub type Xml

/// Scans xml file stored in String type, returns xml and unparsable part
pub fn scan_string(data line: String) -> #(Xml, String) {
  do_scan_string(string.to_utf_codepoints(line))
  |> pair.map_second(string.from_utf_codepoints)
}

@external(erlang, "xmerl_scan", "string")
fn do_scan_string(string: List(UtfCodepoint)) -> #(Xml, List(UtfCodepoint))


pub type NodeEntity {
  XmlElement(
    name: String,
    expanded_name: String,
    nsifno: #(String, String),
    namespace: XmlNamespace,
    smth: List(#(String, Int)),
    another: Int,
    attributes: XmlAttribute,
    content: List(XmlText),
    lanugage: List(String),
    xmlbase: String,
    elementdef: String,
  )
}

pub type XmlNamespace

pub type XmlAttribute

pub type XmlText {
  XmlText(
    parents: List(#(String, Int)),
    pos: Int,
    lanugage: List(String),
    value: List(UtfCodepoint),
    typ: Atom,
  )
}
/// Should parse doc by given xpath, but erlang strange records are returned
pub fn xpath_string(xpath xpath: String, document doc: Xml) -> List(NodeEntity) {
  xpath
  |> string.to_utf_codepoints
  |> do_xpath_string(doc)
}

@external(erlang, "xmerl_xpath", "string")
fn do_xpath_string(xpath: List(UtfCodepoint), doc: Xml) -> List(NodeEntity)
