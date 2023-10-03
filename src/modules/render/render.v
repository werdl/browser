module render

import request



type Elements = [][]string
pub fn parse(body string) Elements{
	mut text, mut in_tag:="", false

	mut p:=[][]string{}{}
	mut current:=[]string{}
	mut i:=0
	for c in body.runes() {
		if c==`<`{
			in_tag=true
			// current=[]
			if text!="" && body.runes()[i+1]==`/`{
				current << text
			} else {
				current=[]
			}
			text=""
		} else if c==`>` {
			in_tag=false
			current << text
			p << current
			
			text=""
		} else {
			text+=c.str()
		}
		i+=1
	}
	if !in_tag && text!="" {
		current << text
	}
	p << current

	mut fresh:=[][]string{}{}
	for q in p {

		if q.len<3 || (q[0][0]==`/` && q[2][0]==`/`) || "/head" in q{
			
		} else {
			fresh << q
		}
	}
	return fresh
}
__global (
	links Elements
)
pub fn linkn(n int) []string {
	return links[n]
}
pub fn (e Elements) print() {
	for element in e {
		if !element[0].contains("style") {
			if element[0]=="title" {
				println("Page Title: ${element[1]} \n\n")
			} else if element[0].contains("href") {
				links << element
				$if linux {
					println("${links.len-1} \e[1;36m${element[1]}\e[0m")
				}
			}
			else {
				println(element[1])
			}
		}
	}
}
