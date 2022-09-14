﻿//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using Boxophobic.StyledGUI;

public class HeightFogShaderGUI : ShaderGUI
{
    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var material0 = materialEditor.target as Material;
        var materials = materialEditor.targets;

        if (material0.HasProperty("_HeightFogGlobal") == true)
        {
            StyledGUI.DrawInspectorBanner("Height Fog Global");

            GUILayout.Space(5);
            EditorGUILayout.HelpBox("Render Queue controlled by the Height Fog script Render Priority value!", MessageType.Info);
            GUILayout.Space(5);

            GUI.enabled = false;
            materialEditor.RenderQueueField();
            GUI.enabled = true;

            GUILayout.Space(10);
        }
        else
        {
            DrawDynamicInspector(material0, materialEditor, props);
        }

        foreach (Material material in materials)
        {
            if (material.HasProperty("_HeightFogGlobal") == false)
            {
                SetBlendProps(material);
            }
        }
    }

    void SetBlendProps(Material material)
    {
        if (material.HasProperty("_FogAxisMode"))
        {
            if (material.GetInt("_FogAxisMode") == 0)
            {
                material.SetVector("_FogAxisOption", new Vector4(1, 0, 0, 0));
            }
            else if (material.GetInt("_FogAxisMode") == 1)
            {
                material.SetVector("_FogAxisOption", new Vector4(0, 1, 0, 0));
            }
            else if (material.GetInt("_FogAxisMode") == 2)
            {
                material.SetVector("_FogAxisOption", new Vector4(0, 0, 1, 0));
            }
        }
    }

    void DrawDynamicInspector(Material material, MaterialEditor materialEditor, MaterialProperty[] props)
    {
        var customPropsList = new List<MaterialProperty>();

        for (int i = 0; i < props.Length; i++)
        {
            var prop = props[i];

            if (prop.flags == MaterialProperty.PropFlags.HideInInspector)
            {
                continue;
            }

            //if (material.HasProperty("_ElementMode"))
            //{
            //    if (material.GetInt("_ElementMode") == 1 && prop.name == "_MainColor")
            //        continue;
            //}

            customPropsList.Add(prop);
        }

        //Draw Custom GUI
        for (int i = 0; i < customPropsList.Count; i++)
        {
            var prop = customPropsList[i];

            if (prop.type == MaterialProperty.PropType.Texture)
            {
                EditorGUI.BeginChangeCheck();

                EditorGUI.showMixedValue = prop.hasMixedValue;
                var tex = (Texture2D)EditorGUILayout.ObjectField(prop.displayName, prop.textureValue, typeof(Texture2D), true, GUILayout.Height(50));

                EditorGUI.showMixedValue = false;

                if (EditorGUI.EndChangeCheck())
                {
                    prop.textureValue = tex;
                }
            }
            else
            {
                materialEditor.ShaderProperty(customPropsList[i], customPropsList[i].displayName);
            }
        }

        if (material.HasProperty("_HeightFogStandalone") == true)
        {
            materialEditor.RenderQueueField();
        }

        GUILayout.Space(10);
    }
}
