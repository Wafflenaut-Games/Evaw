//2D Heat Wave Effect Shader by marsonfire
//Feel free to modify this shader in anyway and to use this for anything you want
//This was made by someone learning Shaders, so lots of comments and stuff to help me know what's going on...

//1. Add a Sprite2D
//2. Add a noise texture to that Sprite2D - resize as desired
//3. Check the "Seamless" box
//4. Set the CanvasItem -> Texture -> Repeat to "Enabled"
//5. Apply the shader to the CanvasItem -> Material -> NewShaderMaterial (You can also drag and drop the shader onto the material)
//6. Play with parameters for desired effects

shader_type canvas_item;

//Get the screen texture
uniform sampler2D screenTexture : hint_screen_texture;

//Set the scroll amount - default = 0.05, 0.05
uniform vec2 scrollAmount = vec2(0.05, 0.05);

//How much distortion is desired? - default = 0.01
uniform float multiplierAmount : hint_range(0.0, 0.1) = 0.01;

void fragment() {
	// Called for every pixel the material is visible on.

	//Get the the screen, then add the noise to it based on the red channel.
	//Scroll that noise multiplied by the time, multiply all of that by given amount
	vec2 distortionUV = SCREEN_UV + texture(TEXTURE, UV + scrollAmount * TIME).r * multiplierAmount;

	//Now, get what's underneath the noise texture (the screen) and apply the distorted noise UV to that
	vec4 screen = texture(screenTexture, distortionUV);

	//Set the COLOR to apply the effect
	COLOR = screen;
}