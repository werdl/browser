module render

import net.html

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

pub fn (d DOM) show() {
	tags_to_show:=["p","h1","h2","h3","h4","h5","h6","a"]
	tags:=d.dom
	// println(d.dom)
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
		if tag.children.len==0 && tag.name in tags_to_show{
			println("${tag.text()}")
		}
	}
}