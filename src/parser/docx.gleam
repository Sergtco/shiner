import gleam/list
import gleam/result
import gleam/string
import parser/archive
import parser/xml

pub type DocError {
  FileNotFound
  ArchiveError
  ParsingError
}

///Parses document by filename and extracts all text ino list
pub fn parse_document(filename: String) -> Result(List(String), DocError) {
  let zipfile =
    archive.zip_open(filename)
    |> result.map(archive.zip_get("word/document.xml", _))
    |> result.flatten
  case zipfile {
    Ok(file) -> {
      extract_text(file.data)
      |> Ok
    }
    _ -> Error(ArchiveError)
  }
}

///Extracts text from <w:t> tags
pub fn extract_text(xml_data: String) -> List(String) {
  let #(xml, _) =
    xml_data
    |> xml.scan_string()

  xml
  // searches for w:t tag, in which text is located, is suppose?
  |> xml.xpath_string("//w:t", _)
  |> list.map(fn(val) {
    val.content
    |> list.map(fn(s) {
      s.value
      |> string.from_utf_codepoints
    })
  })
  |> list.concat()
}
