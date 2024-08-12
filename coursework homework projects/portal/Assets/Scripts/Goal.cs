using System.Collections;
using System.Collections.Generic;
using UnityEngine.UI;
using UnityEngine;

public class Goal : MonoBehaviour
{
    public bool gamewon;
    //private Text text;
    // Start is called before the first frame update
    void Start()
    {
      	//text = GetComponent<Text>();
        gamewon = false; 
		// start text off as completely transparent black
		//text.color = new Color(0, 0, 0, 0);  
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    void OnTriggerEnter(Collider other) {
        gamewon = true;
		// trigger coin pickup function if a helicopter collides with this
		//other.transform.parent.GetComponent<HeliController>().PickupGem();
		//Destroy(gameObject);


			// reveal text only when helicopter is null (destroyed)
        //text.color = new Color(0, 0, 0, 1);
        //text.text = "You have done it!";
        
        // jump is space bar by default
        //if (Input.GetButtonDown("Jump")) {

            // reload entire scene, starting music over again, refreshing score, etc.
       //     SkyscraperSpawner.speed = 10f;
       //     SceneManager.LoadScene("Main");
       // }
    
    
    }

}
