using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class OnLoad : MonoBehaviour
{
    static GameObject[] gameObjects;

    public void Start()
    {
        gameObjects = GameObject.FindGameObjectsWithTag("DisableOnLoad");
        foreach (var obj in gameObjects)
        {
            obj.SetActive(false);
        }
    }
}
