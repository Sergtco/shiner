import archive
import docx
import gleam/result
import gleeunit
import gleeunit/should
import simplifile

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn hello_world_test() {
  1
  |> should.equal(1)
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
  |> result.map(fn(handle){
    handle
    |> archive.zip_get("word/document.xml", _)
    |> should.be_ok()
  }

)
}
