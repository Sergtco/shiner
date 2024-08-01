import docx
import gleam/io

pub fn main() {
  let assert Ok(handle) =
  docx.zip_open("example.docx")
  case docx.zip_get("word/document.xml", handle) {
    Ok(res) -> {
      io.debug(res.name)
      ""
    }
    Error(err) -> io.debug(err)
  }
}
