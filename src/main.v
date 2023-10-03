module main

import request

fn main() {
	x:=request.new("http://www.example.com")
	println(x.read())
}
