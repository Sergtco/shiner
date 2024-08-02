import gleam/erlang/atom.{type Atom}
import gleam/list
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
  XmlElement(
    tag1: String,
    tag2: String,
    tag3: #(String, String),
    namespace: XmlNamespace,
    smth: List(#(String, Int)),
    another: Int,
    attributes: XmlAttribute,
    text: List(XmlText),
    undef: List(String),
    path: String,
    extra: String,
  )
}

pub type XmlNamespace

pub type XmlAttribute

pub type XmlText {
  XmlText(
    attrs: List(#(String, Int)),
    number: Int,
    extra: List(String),
    value: List(UtfCodepoint),
    attr: Atom,
  )
}

///Extracts text from <w:t> tags
pub fn extract_text(xml_data: String) -> List(String) {
  let #(xml, _) =
    xml_data
    |> scan_string()

  xml
  // searches for w:t tag, in which text is located, is suppose?
  |> xpath_string("//w:t", _)
  |> list.map(fn(val) { 
    val.text
    |> list.map(fn(s){
      s.value
      |> string.from_utf_codepoints
    })
  })
  |> list.concat()
}

/// Should parse doc by given xpath, but erlang strange records are returned
pub fn xpath_string(xpath: String, doc: Xml) -> List(NodeEntity) {
  xpath
  |> string.to_utf_codepoints
  |> do_xpath_string(doc)
}

@external(erlang, "xmerl_xpath", "string")
fn do_xpath_string(xpath: List(UtfCodepoint), doc: Xml) -> List(NodeEntity)
