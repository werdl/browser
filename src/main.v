module main

import request
import render
fn main() {
	x:=request.new("https://browser.engineering")
	r:=x.read()
	r.print()

	
	e:=render.new(r.body)
	e.show()
}
