import archive
import docx
import gleam/result
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

pub fn extract_text_test() {
  simplifile.read("./test/document.xml")
  |> result.map(fn(data) {
    docx.extract_text(data)
    |> should.equal(["Hello", "world"])
  })
}

pub fn zip_get_test() {
  archive.zip_open("./test/document.docx")
  |> result.map(fn(handle) {
    handle
    |> archive.zip_get("word/document.xml", _)
    |> should.be_ok()
  })
}

pub fn parse_document_test() {
  docx.parse_document("./test/document.docx")
  |> should.equal(Ok(["Hello", "Hello", "!"]))
}
