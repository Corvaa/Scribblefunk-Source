package;

import flixel.system.FlxAssets.FlxShader;

class HardLight extends FlxShader {
    @:glFragmentSource("
    #pragma header

    uniform sampler2D gradient;

    //HardLight 
    vec3 hardLight(vec3 base, vec3 bl_layer){
        vec3 temp_result;
            if (bl_layer.r < 0.5)
                temp_result.r = 2.0 * base.r * bl_layer.r;
            else
                temp_result.r = 1.0 - 2.0 * (1.0 - base.r) * (1.0 - bl_layer.r);
            if (bl_layer.g < 0.5)
                temp_result.g = 2.0 * base.g * bl_layer.g;
            else
                temp_result.g = 1.0 - 2.0 * (1.0 - base.g) * (1.0 - bl_layer.g);
            if (bl_layer.b < 0.5)
                temp_result.b = 2.0 * base.b * bl_layer.b;
            else
                temp_result.b = 1.0 - 2.0 * (1.0 - base.b) * (1.0 - bl_layer.b);
        return temp_result;
    }

    //Opacity function    
    vec4 opacity(float alpha, vec4 texColor, vec4 blendResult){
        return ((1.0 - alpha) * texColor + alpha * blendResult);
    }

        
    void main()
    {
        // Normalized pixel coordinates (from 0 to 1)
        vec2 uv = openfl_TextureCoordv;
        
        vec4 texColor = flixel_texture2D(bitmap, uv);
        vec4 layer = flixel_texture2D(gradient, uv);
        
        //Change Blendmode here<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        vec4 blendResult = vec4 (hardLight(texColor.rgb, layer.rgb), 1.0);
        
        // Change to 0.0 - 1.0 to set opacity of a blending layer<<<<<<<<<<<<<<<<<<<<<<<<<<<<
        float alpha = 1.;

        gl_FragColor = opacity (alpha, texColor, blendResult);
    }")
    public function new()
    {
        super();
    }
}