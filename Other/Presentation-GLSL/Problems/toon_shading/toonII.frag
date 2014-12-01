uniform vec3 lightDirection; //directional lighting. You may also obtain from gl_LightSource[0].position.xyz

varying vec3 normal; //obtained from vertex

void main() {
	float intensity; //light intensity
	vec4 color; //light color
	
	//intensity lightDirection X normal; where 0 <= normal <= 1, i.e, the normal is normalized
	
	//GRADIENT CODE using intensity and color
	
	gl_FragColor = color;
} 

