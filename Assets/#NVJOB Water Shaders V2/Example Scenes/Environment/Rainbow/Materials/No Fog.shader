Shader "#NVJOB/Unlit Transparency No Fog" {

Properties {
_Color ("Water Color (RGB) Transparency (A)", COLOR) = (1, 1, 1, 0.5)
[Space]
_MainTex ("Base (RGB)", 2D) = "white" {}
}

SubShader {
Tags { "Queue" = "Geometry+921" "RenderType" = "Transparent" "IgnoreProjector"="True" }
Blend SrcAlpha OneMinusSrcAlpha
LOD 200
Cull Off
ZWrite Off

Pass {  
CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma target 2.0
			
#include "UnityCG.cginc"

struct appdata_t {
float4 vertex : POSITION;
float2 texcoord : TEXCOORD0;
UNITY_VERTEX_INPUT_INSTANCE_ID
};

struct v2f {
float4 vertex : SV_POSITION;
float2 texcoord : TEXCOORD0;
UNITY_VERTEX_OUTPUT_STEREO
};

fixed4 _Color;
sampler2D _MainTex;
float4 _MainTex_ST;			

v2f vert (appdata_t v){
v2f o;
UNITY_SETUP_INSTANCE_ID(v);
UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
o.vertex = UnityObjectToClipPos(v.vertex);
o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
return o;
}			

fixed4 frag (v2f i) : SV_Target {
half sinTime = sin(_Time.y) * _Color.a * 0.4;

half4 color = half4(_Color.r, _Color.g, _Color.b, _Color.a - sinTime);
half4 col = tex2D(_MainTex, i.texcoord) * color;

return col;
}

ENDCG
}
}
}
