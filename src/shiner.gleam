import archive
import docx
import gleam/io

pub fn main() {
  let assert Ok(handle) = archive.zip_open("example.docx")
  case archive.zip_get("word/document.xml", handle) {
    Ok(res) -> {
      let #(xml, _) =
        res.data
        |> docx.scan_string()

      xml
      |> docx.xpath_string(".//self::w:t", _)
      |> io.debug
      ""
    }
    Error(err) -> io.debug(err)
  }
}
