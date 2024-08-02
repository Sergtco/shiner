import gleam/list
import gleam/result
import gleeunit
import gleeunit/should
import parser/grep
import parser/archive
import parser/docx
import simplifile

pub fn main() {
  gleeunit.main()
}

///Get single file data from zip archive
pub fn zip_get_test() {
  archive.zip_open("./test/document.docx")
  |> result.map(fn(handle) {
    handle
    |> archive.zip_get("word/document.xml", _)
    |> should.be_ok()
  })
}

///Extract text from xml document
pub fn extract_text_test() {
  simplifile.read("./test/document.xml")
  |> result.map(fn(data) {
    docx.extract_text(data)
    |> should.equal(["Hello", "world"])
  })
}

/// Parse whole document for list of strings
pub fn parse_document_test() {
  docx.parse_document("./test/document.docx")
  |> result.map(list.take(_, 3))
  |> should.equal(Ok(["Hello", "Hello", "!"]))
}

/// Filter text for search word
pub fn filter_text_test() {
  let text ="Roses are red\nViolets are blue,\nSugar is sweet\nAnd so are you."
  text
  |> grep.filter_text("are")
  |> should.equal(["Roses are red", "Violets are blue,", "And so are you."])
}
