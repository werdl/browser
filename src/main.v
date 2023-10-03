module main

import request
import render
import os
fn main() {
	x:=request.new("https://browser.engineering")
	r:=x.read()
	r.print()

	
	e:=render.parse(r.body)
	print(e)
	e.print()

	for {
		inp:=os.input("> ")
		println(render.linkn(inp.int()))
	}
}
