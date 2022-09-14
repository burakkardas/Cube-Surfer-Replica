// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Atmospherics/Height Fog Preset"
{
	Properties
	{
		[HideInInspector]_IsHeightFogPreset("_IsHeightFogPreset", Float) = 1
		[HideInInspector]_IsHeightFogShader("_IsHeightFogShader", Float) = 1
		[StyledBanner(Height Fog Preset)]_Banner("[ Banner ]", Float) = 1
		[StyledCategory(Fog)]_FogCat("[ FogCat]", Float) = 1
		_FogIntensity("Fog Intensity", Range( 0 , 1)) = 1
		[Enum(X Axis,0,Y Axis,1,Z Axis,2)]_FogAxisMode("Fog Axis Mode", Float) = 1
		[Enum(Multiply Distance And Height,0,Additive Distance And Height,1)]_FogLayersMode("Fog Layers Mode", Float) = 0
		[HideInInspector]_FogAxisOption("_FogAxisOption", Vector) = (0,0,0,0)
		[HDR][Space(10)]_FogColorStart("Fog Color Start", Color) = (0.4411765,0.722515,1,1)
		[HDR]_FogColorEnd("Fog Color End", Color) = (0.8862745,1.443137,2,1)
		_FogColorDuo("Fog Color Duo", Range( 0 , 1)) = 1
		[Space(10)]_FogDistanceStart("Fog Distance Start", Float) = -200
		_FogDistanceEnd("Fog Distance End", Float) = 200
		_FogDistanceFalloff("Fog Distance Falloff", Range( 1 , 8)) = 2
		[Space(10)]_FogHeightStart("Fog Height Start", Float) = 0
		_FogHeightEnd("Fog Height End", Float) = 200
		_FogHeightFalloff("Fog Height Falloff", Range( 1 , 8)) = 2
		[StyledCategory(Skybox)]_SkyboxCat("[ SkyboxCat ]", Float) = 1
		_SkyboxFogIntensity("Skybox Fog Intensity", Range( 0 , 1)) = 1
		_SkyboxFogHeight("Skybox Fog Height", Range( 0 , 1)) = 1
		_SkyboxFogFalloff("Skybox Fog Falloff", Range( 1 , 8)) = 1
		_SkyboxFogOffset("Skybox Fog Offset", Range( -1 , 1)) = 0
		_SkyboxFogBottom("Skybox Fog Bottom", Range( -1 , 1)) = 0
		_SkyboxFogFill("Skybox Fog Fill", Range( 0 , 1)) = 1
		[StyledCategory(Directional)]_DirectionalCat("[ DirectionalCat ]", Float) = 1
		[HDR]_DirectionalColor("Directional Color", Color) = (1,0.7793103,0.5,1)
		_DirectionalIntensity("Directional Intensity", Range( 0 , 1)) = 1
		_DirectionalFalloff("Directional Falloff", Range( 1 , 8)) = 2
		[HideInInspector]_DirectionalDir("Directional Dir", Vector) = (0,0,0,0)
		[StyledCategory(Noise)]_NoiseCat("[ NoiseCat ]", Float) = 1
		[HideInInspector]_NoiseModeBlend("_NoiseModeBlend", Float) = 1
		_NoiseIntensity("Noise Intensity", Range( 0 , 1)) = 1
		_NoiseDistanceEnd("Noise Distance End", Float) = 50
		_NoiseScale("Noise Scale", Float) = 30
		[ASEEnd]_NoiseSpeed("Noise Speed", Vector) = (0.5,0,0.5,0)

	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Overlay" "Queue"="Overlay" }
	LOD 0

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend SrcAlpha OneMinusSrcAlpha
		AlphaToMask Off
		Cull Off
		ColorMask RGBA
		ZWrite Off
		ZTest Always
		
		
		
		Pass
		{
			Name "Unlit"

			CGPROGRAM

			

			#ifndef UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX
			//only defining to not throw compilation error over Unity 5.5
			#define UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input)
			#endif
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 worldPos : TEXCOORD0;
				#endif
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			uniform half _FogDistanceEnd;
			uniform half3 _DirectionalDir;
			uniform half _DirectionalCat;
			uniform half3 _NoiseSpeed;
			uniform half _IsHeightFogShader;
			uniform half4 _FogColorStart;
			uniform float4 _FogAxisOption;
			uniform half _FogAxisMode;
			uniform half _FogCat;
			uniform half _SkyboxFogFill;
			uniform half _SkyboxCat;
			uniform half _FogColorDuo;
			uniform half _FogHeightFalloff;
			uniform half _NoiseCat;
			uniform half4 _FogColorEnd;
			uniform half _SkyboxFogOffset;
			uniform half _FogLayersMode;
			uniform half _Banner;
			uniform half _SkyboxFogHeight;
			uniform half _DirectionalIntensity;
			uniform half _DirectionalFalloff;
			uniform half _FogHeightEnd;
			uniform half _NoiseModeBlend;
			uniform half _FogDistanceStart;
			uniform half _NoiseDistanceEnd;
			uniform half4 _DirectionalColor;
			uniform half _SkyboxFogIntensity;
			uniform half _FogDistanceFalloff;
			uniform half _FogIntensity;
			uniform half _FogHeightStart;
			uniform half _NoiseIntensity;
			uniform half _NoiseScale;
			uniform half _SkyboxFogFalloff;
			uniform half _IsHeightFogPreset;
			uniform half _SkyboxFogBottom;

			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				
				float3 vertexValue = float3(0, 0, 0);
				#if ASE_ABSOLUTE_VERTEX_POS
				vertexValue = v.vertex.xyz;
				#endif
				vertexValue = vertexValue;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);

				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				#endif
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				fixed4 finalColor;
				#ifdef ASE_NEEDS_FRAG_WORLD_POSITION
				float3 WorldPosition = i.worldPos;
				#endif
				
				
				finalColor = fixed4(1,1,1,1);
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "HeightFogShaderGUI"
	
	
}
/*ASEBEGIN
Version=18934
1920;0;1920;1029;3000.124;3825.837;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;107;-3072,-3712;Half;False;Property;_FogDistanceEnd;Fog Distance End;12;0;Create;True;0;0;0;True;0;False;200;200;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;227;-3328,-2560;Half;False;Property;_NoiseSpeed;Noise Speed;36;0;Create;True;0;0;0;True;0;False;0.5,0,0.5;0.5,0,0.5;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;643;-3104,-4736;Half;False;Property;_IsHeightFogShader;_IsHeightFogShader;1;1;[HideInInspector];Create;False;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;137;-3328,-3968;Half;False;Property;_FogColorStart;Fog Color Start;8;1;[HDR];Create;True;0;0;0;True;1;Space(10);False;0.4411765,0.722515,1,1;0.4411765,0.722515,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;655;-2432,-4224;Inherit;False;Property;_FogAxisOption;_FogAxisOption;7;1;[HideInInspector];Create;True;0;0;0;True;0;False;0,0,0,0;0,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;645;-3328,-4224;Half;False;Property;_FogAxisMode;Fog Axis Mode;5;1;[Enum];Create;True;0;3;X Axis;0;Y Axis;1;Z Axis;2;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;558;-3328,-4864;Half;False;Property;_Banner;[ Banner ];2;0;Create;True;0;0;0;True;1;StyledBanner(Height Fog Preset);False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;625;-1952,-3072;Half;False;Property;_DirectionalDir;Directional Dir;29;1;[HideInInspector];Create;True;0;0;0;True;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;628;-2848,-4864;Half;False;Property;_DirectionalCat;[ DirectionalCat ];24;0;Create;True;0;0;0;True;1;StyledCategory(Directional);False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;639;-3072,-2560;Half;False;Property;_NoiseMode;Noise Mode;31;1;[Enum];Create;True;0;2;Off;0;Procedural 3D;2;0;False;0;False;2;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;653;-2816,-3968;Half;False;Property;_FogColorDuo;Fog Color Duo;10;0;Create;True;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;650;-2816,-3584;Half;False;Property;_FogHeightFalloff;Fog Height Falloff;16;0;Create;True;0;0;0;True;0;False;2;2;1;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;629;-2640,-4864;Half;False;Property;_NoiseCat;[ NoiseCat ];30;0;Create;True;0;0;0;True;1;StyledCategory(Noise);False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;648;-3072,-3968;Half;False;Property;_FogColorEnd;Fog Color End;9;1;[HDR];Create;True;0;0;0;True;0;False;0.8862745,1.443137,2,1;0.8862745,1.443137,2,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;658;-2176,-3328;Half;False;Property;_SkyboxFogOffset;Skybox Fog Offset;21;0;Create;True;0;0;0;True;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;657;-3072,-4224;Half;False;Property;_FogLayersMode;Fog Layers Mode;6;1;[Enum];Create;True;0;2;Multiply Distance And Height;0;Additive Distance And Height;1;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;266;-2464,-3328;Half;False;Property;_SkyboxFogFill;Skybox Fog Fill;23;0;Create;True;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;627;-3024,-4864;Half;False;Property;_SkyboxCat;[ SkyboxCat ];17;0;Create;True;0;0;0;True;1;StyledCategory(Skybox);False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;633;-3072,-3072;Half;False;Property;_DirectionalIntensity;Directional Intensity;27;0;Create;True;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;626;-3168,-4864;Half;False;Property;_FogCat;[ FogCat];3;0;Create;True;0;0;0;True;1;StyledCategory(Fog);False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;654;-2784,-3072;Half;False;Property;_DirectionalFalloff;Directional Falloff;28;0;Create;True;0;0;0;True;0;False;2;2;1;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;635;-2224,-2560;Half;False;Property;_NoiseModeBlend;_NoiseModeBlend;32;1;[HideInInspector];Create;True;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-3328,-3712;Half;False;Property;_FogDistanceStart;Fog Distance Start;11;0;Create;True;0;0;0;True;1;Space(10);False;-200;-200;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;349;-2608,-2560;Half;False;Property;_NoiseDistanceEnd;Noise Distance End;34;0;Create;True;0;0;0;True;0;False;50;50;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;102;-2432,-3072;Half;False;Property;_DirectionalColor;Directional Color;25;1;[HDR];Create;True;0;0;0;True;0;False;1,0.7793103,0.5,1;1,0.7793103,0.5,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;640;-3328,-3072;Half;False;Property;_DirectionalMode;Directional Mode;26;2;[HideInInspector];[Enum];Create;True;0;2;Off;0;On;1;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;656;-3328,-3328;Half;False;Property;_SkyboxFogIntensity;Skybox Fog Intensity;18;0;Create;True;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-3040,-3328;Half;False;Property;_SkyboxFogHeight;Skybox Fog Height;19;0;Create;True;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;74;-3072,-3584;Half;False;Property;_FogHeightEnd;Fog Height End;15;0;Create;True;0;0;0;True;0;False;200;200;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;649;-2816,-3712;Half;False;Property;_FogDistanceFalloff;Fog Distance Falloff;13;0;Create;True;0;0;0;True;0;False;2;2;1;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;103;-3328,-3584;Half;False;Property;_FogHeightStart;Fog Height Start;14;0;Create;True;0;0;0;True;1;Space(10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;345;-2896,-2560;Half;False;Property;_NoiseIntensity;Noise Intensity;33;0;Create;True;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;230;-2384,-2560;Half;False;Property;_NoiseScale;Noise Scale;35;0;Create;True;0;0;0;True;0;False;30;30;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;651;-2752,-3328;Half;False;Property;_SkyboxFogFalloff;Skybox Fog Falloff;20;0;Create;True;0;0;0;True;0;False;1;1;1;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;644;-3328,-4736;Half;False;Property;_IsHeightFogPreset;_IsHeightFogPreset;0;1;[HideInInspector];Create;False;0;0;0;True;0;False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;659;-1904,-3328;Half;False;Property;_SkyboxFogBottom;Skybox Fog Bottom;22;0;Create;True;0;0;0;True;0;False;0;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;632;-2480,-4864;Half;False;Property;_AdvancedCat;[ AdvancedCat ];37;0;Create;True;0;0;0;False;1;StyledCategory(Advanced);False;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;278;-3328,-4352;Half;False;Property;_FogIntensity;Fog Intensity;4;0;Create;True;0;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;383;-320,-4352;Float;False;True;-1;2;HeightFogShaderGUI;0;1;BOXOPHOBIC/Atmospherics/Height Fog Preset;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;False;True;2;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;True;0;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;2;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;594;True;7;False;595;True;False;0;False;500;0;False;500;True;2;RenderType=Overlay=RenderType;Queue=Overlay=Queue=0;True;2;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;0;1;True;False;;False;0
Node;AmplifyShaderEditor.CommentaryNode;612;-3326,-4480;Inherit;False;3198.742;100;Props;0;;0.497,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;557;-3328,-4992;Inherit;False;1022.024;100;Drawers / Settings;0;;1,0.4980392,0,1;0;0
ASEEND*/
//CHKSM=39D1C4D4265746BD77C9A4ECA3A4FDF9CD5BAC33