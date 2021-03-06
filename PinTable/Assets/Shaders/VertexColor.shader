﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "PinTable/VertexColor"
{
	Properties
	{
		_Color ("Vertex Color", Color) = (1,1,1,1)
		_Factor ("Height Modifier", Float) = 0.5
	}

	SubShader
	{	
		Tags {
			"RenderType" = "Opaque"
		}

		Pass {		
			CGPROGRAM 
				#pragma vertex vert
				#pragma fragment frag

				#include "UnityCG.cginc"

				float4 _Color;
				float _Factor;

				struct VertOut {
				 	float4 position : SV_POSITION;
				 	fixed4 color : COLOR;
				};

				VertOut vert (float4 position : POSITION, fixed4 color : COLOR) {
					VertOut output;
					output.color = color;
					position = position + color * float4(0, _Factor, 0, 0);
					output.position = UnityObjectToClipPos(position);
					return  output;
				}

				fixed4 frag (VertOut input) : SV_TARGET {
					fixed4 output;
					output = input.color * _Color;
					return output;
				}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
