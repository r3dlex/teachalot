uniform vec3 lightDirection; //directional lighting. You may also obtain from gl_LightSource[0].position.xyz
varying float intensity;

void main() {
	/** normal = gl_Normal **/

	/** intensity = lightDirection X normal, where 0 <= normal <= 1 and 0 <= lightDirection <= 1 **/

	gl_Position = ftransform();
} 

