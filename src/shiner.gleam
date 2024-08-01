import gleam/result
import archive
import docx
import gleam/io
import gleam/list

pub fn main() {
  let assert Ok(handle) = archive.zip_open("example.docx")
  case archive.zip_get("word/document.xml", handle) {
    Ok(res) -> {
      // let #(xml, _) =
      //   res.data
      //   |> docx.scan_string()
      //
      // xml
      // |> docx.xpath_string("//w:t", _)
      // |> list.each(fn(val) {
      //   docx.xpath_string(".", val)
      //   |> io.debug
      // })
      // ""
      docx.extract_text(res.data)
      |>io.debug
      ""
    }
    Error(err) -> io.debug(err)
  }
}

