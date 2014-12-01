void main() {
	vec3 normal, lightDirection;
	vec4 diffuse;
	float NdotL;
		
	/* first transform the normal into eye space and normalize the result */
	normal = normalize(gl_NormalMatrix * gl_Normal);
		
	/* now normalize the light's direction. Note that according to the
	OpenGL specification, the light is stored in eye space. Also since 
	we're talking about a directional light, the position field is actually 
	direction */
	lightDirection = normalize((gl_LightSource[0].position).xyz);
	
	/* compute the cos of the angle between the normal and lights direction. 
	The light is directional so the direction is constant for every vertex.
	Since these two are normalized the cosine is the dot product. We also 
	need to clamp the result to the [0,1] range. */
	NdotL = max(dot(normal, lightDirection), 0.0);
	
	/* Compute the diffuse term */
	diffuse = gl_FrontMaterial.diffuse * gl_LightSource[0].diffuse;
	
	gl_FrontColor =  NdotL * diffuse;
	
	gl_Position = ftransform();
}
