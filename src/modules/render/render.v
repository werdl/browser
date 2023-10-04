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
	tags_to_show:=["p","h1","h2","h3","h4","h5","h6"]
	tags:=d.dom.get_tags(html.GetTagsOptions{})
	for tag in tags{
		tag_type:=tag.str().split(" ")[0]
		tag_type.replace("<","")
		tag_type.replace(">","")
		println(tag_type)
	}
}