using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class FallDespawn : MonoBehaviour
{

    public GameObject characterController;
    // Start is called before the first frame update

    ScoreManager roomcounter; 
    
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        float ypos = characterController.transform.position.y;
        if (ypos < -2)
        {
            ScoreManager.Score = 0; 
            SceneManager.LoadScene("GameOver");
        } 
    }
}
