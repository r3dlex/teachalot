varying float intensity;

void main() {
	float intensity; //light intensity
	vec4 color; //light color
	
	//intensity lightDir X normal; where 0 <= normal <= 1, i.e, the normal is normalized
	
	//GRADIENT CODE using intensity and color
	
	gl_FragColor = color;
} 

