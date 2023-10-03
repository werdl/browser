module request

import net.http

pub fn (u URL) read() (string,http.Header) {
	request_str:= match u.port==0 {
		true {
			'${u.scheme}://${u.host}/${u.path}'
		} 
		false {
			'${u.scheme}://${u.host}:${u.port}/${u.path}'
		}
	}
	println(request_str)
	data := http.get(request_str) or {panic(err)}
    
	return data.body, data.header
}