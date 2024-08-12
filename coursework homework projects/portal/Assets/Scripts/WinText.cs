using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using UnityEngine;

public class WinText : MonoBehaviour
{
    public GameObject goal;
    public GameObject goalpost;
    private Text text;
    // Start is called before the first frame update
    void Start()
    {
        text = GetComponent<Text>();
        text.text = "You won!";
		// start text off as completely transparent black
		text.color = new Color(0, 0, 0, 0);  
    }

    // Update is called once per frame
    void Update()
    {
        if (goal.GetComponent<Goal>().gamewon == true || goalpost.GetComponent<Goal>().gamewon == true){
		    text.color = new Color(0, 0, 0, 1);  
        }
                
    }

}
