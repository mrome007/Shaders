﻿Shader "MikeShader/NormalShader" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_NormalTex ("Normal Map", 2D) = "bump" {}
		_NormalMapIntensity("Normal intensity", Range(0,1)) = 1
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		struct Input {
			float2 uv_NormalTex;
		};

		sampler2D _NormalTex;
		float4 _Color;
		float _NormalMapIntensity;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			o.Albedo = _Color;
			float3 normalMap = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));
			normalMap.x *= _NormalMapIntensity;
			normalMap.y *= _NormalMapIntensity;
			o.Normal = normalMap.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
