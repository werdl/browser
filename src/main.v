module main

import request
import render
import os

fn gen_list(max int) []string {
	mut total:=[]string{}
	for i in 0..max+1 {
		total << i.str()
	}
	return total
}
fn read_site(s string) {
	x:=request.new(s)
	r:=x.read()
	r.print()

	
	e:=render.new(r.body)
	max, hrefs:=e.show()
	for {
		inp:=os.input("> ")
		list:=gen_list(max)
		if inp in list{
			read_site(hrefs[inp.int()])
		} else if inp=="q" {
			exit(0)
		}else {
			read_site(inp)
		}
	}
}
fn main() {
	read_site("https://browser.engineering")
}
