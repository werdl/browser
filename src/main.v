module main

import request

fn main() {
	x:=request.new("http://badssl.com")
	r:=x.read()
	r.print()
}
