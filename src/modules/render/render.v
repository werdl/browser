module render

import net.html
import term
import arrays

struct DOM {
	dom html.DocumentObjectModel
	data string
}

pub fn new(data string) DOM {
	return DOM{
		dom: html.parse(data)
		data: data
	}
}
const dont_show:=["style","meta","script","title"]
const nl_shows:=["h1","h2","h3","h4","h5","h6"]
const pre_nl_shows:=["section"]

fn text_tag(tag html.Tag) {
	// tags_to_show:=["p","h1","h2","h3","h4","h5","h6","a"]
	if (tag.children.len==0 && tag.name !in dont_show) || (tag.children.len==1 && tag.name=="p") {
		x:=tag.content
		mut in_amp:=false
		mut ret:=[]rune{}
		for c in x.runes() {
			if c==`&` {
				in_amp=true
			} else if c==`;` {
				in_amp=false
			} else if !in_amp {
				if arrays.uniq(x.runes())!=[`\n`,` `] {
					ret << c
				}
				
			}
		}
		print(ret.string())
	} else if tag.children.len==1 && tag.name=="li" {
		print("\n")
	} else if tag.name=="ol" {
		print("\n")
	}
}

struct RGB {
	r int=255
	g int=255
	b int=255
}

fn prnt(rgb RGB, s string) {
	print(term.rgb(rgb.r,rgb.g,rgb.b,s))
}

pub fn (d DOM) show() (int, []string) {
	mut hrefs:=[]string{}
	// println(d.dom)
	mut max:=0
	mut title:=false
	for tag in d.dom.get_tags() {
		// println(tag.text)
		// split:=tag.str().split(" ")
		// mut charr:=""
		// if split.len==1 {
		// 	charr=">"
		// } else {
		// 	charr=" "
		// }
		// rtag:=html.parse(tag.str()).get_tags(html.GetTagsOptions{})
		// tag_type:=tag.str().split(charr)[0].replace("<","").replace(">","")
		// tag_type
		// tag_type
		// println(tag.text())
		match tag.name {
			"a" {
				print(" (${max})")
				prnt(RGB{
					r: 0
					b: 139
					g: 139
				}, "${tag.content}")
				max+=1
				hrefs << tag.attributes["href"]
			}
			"title" {
				if !title {
					print("Page title: ${tag.text()}\n")
					title=true
				}
				
			}
			"br" {
				print("\n")
			}
			else {
				match tag.name {
					"p" {
						print(" ")
					} else {}
				}
				// unsafe {
				// 	if tag.parent!=nil && tag.parent.parent!=nil && tag.parent.parent.parent!=nil{
				// 		if tag.parent.parent.parent.name in pre_nl_shows {
				// 			print("\n")
				// 		}	
				// 	}
				// }
				if tag.name in nl_shows {
					print("\n")
				}
				if tag.name !in dont_show {
					text_tag(tag)
				}
				// if tag.name in nl_shows {
				// 	print("\n")
				// }
				match tag.name {
					"p" {
						print(" ")
					} else {}
				}
			}
		}
		
	}
	return max, hrefs
}