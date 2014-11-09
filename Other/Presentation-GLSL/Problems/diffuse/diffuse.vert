void main() {
	vec3 normal, lightDirection;
	vec4 diffuse;
	float NdotL;
		
	/* first transform the normal into eye space and normalize the result */
	/** normal = gl_NormalMatrix * gl_Normal, where 0 <= normal <= 1 **/
		
	/* now normalize the light's direction. Note that according to the
	OpenGL specification, the light is stored in eye space. Also since 
	we're talking about a directional light, the position field is actually 
	direction */
	/** lightDirection = position of gl_LightSource[0], where 0 <= lightDirection <= 1 **/
	
	/* compute the cos of the angle between the normal and lights direction. 
	The light is directional so the direction is constant for every vertex.
	Since these two are normalized the cosine is the dot product. We also 
	need to clamp the result to the [0,1] range. */
	/** NdotL = max(normal X lightDirection, 0) **/
	
	/* Compute the diffuse term */
	/** difuse = materialDiffuse * lightSourceDiffuse (see how to obtain these two) **/
	
	/** color = (max(normal X lightDirection, 0) * diffuse) **/

	gl_Position = ftransform();
}
