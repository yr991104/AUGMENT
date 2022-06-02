using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Video;

public class ButtonManager : MonoBehaviour
{

    [Header("ButtonType")]
    [SerializeField] private bool isVideoPlayer = false;

    [Header("GameObject")] 
    [SerializeField]private GameObject videoPlayer;
    
    private Button button;

    // Start is called before the first frame update
    void Start()
    {
        if (isVideoPlayer)
        {
            button = GetComponent<Button>();
            button.onClick.AddListener(PlayAVideo);
        }

    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void PlayAVideo()
    {
        if (videoPlayer.activeInHierarchy)
        {
            if (videoPlayer.GetComponent<VideoPlayer>() != null)
                videoPlayer.GetComponent<VideoPlayer>().Play();
            else if (videoPlayer.GetComponentInChildren<VideoPlayer>() != null)
                videoPlayer.GetComponentInChildren<VideoPlayer>().Play();
            else
                Debug.LogWarning("There is no VideoPlayer");
        }
    }
}
