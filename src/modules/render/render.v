module render

import net.html
import term


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

fn text_tag(tag html.Tag) string {
	// tags_to_show:=["p","h1","h2","h3","h4","h5","h6","a"]
	dont_show:=["style","meta","script","title"]
	if tag.children.len==0 && tag.name !in dont_show {
		x:=tag.text()
		mut in_amp:=false
		mut ret:=""
		for c in x.runes() {
			if c==`&` {
				in_amp=true
			} else if c==`;` {
				in_amp=false
			} else if !in_amp {
				ret+=c.str()
			}
		}
		return ret
	}
	return ""
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
	
	tags:=d.dom
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
				print("\n${max} ")
				prnt(RGB{
					r: 0
					b: 139
					g: 139
				}, "${tag.text()}\n")
				max+=1
				hrefs << tag.attributes["href"]
			}
			"title" {
				if !title {
					print("Page title: ${tag.text()}\n")
					title=true
				}
				
			}
			else {
				print("${text_tag(tag)}")
			}
		}
		
	}
	return max, hrefs
}