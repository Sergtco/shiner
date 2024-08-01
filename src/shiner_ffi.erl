-module(shiner_ffi).
-export([print_xml/0]).
-include_lib("xmerl/include/xmerl.hrl").

% 1. Read the XML file
print_xml() ->
% 1. Read the XML file
{ok, XmlBinary} = file:read_file("word/document.xml"),

% 2. Convert the binary to a list (string)
XmlString = binary_to_list(XmlBinary),

% 3. Parse the XML content
{Xml, _} = xmerl_scan:string(XmlString),

% 4. Extract text nodes
Texts = xmerl_xpath:string("//w:t", Xml),

% 5. Print extracted texts
lists:foreach(fun(TextNode) ->
    Text = hd(xmerl_xpath:string(".", TextNode)),
    io:format("~s~n", [Text#xmlText.value])
end, Texts).

