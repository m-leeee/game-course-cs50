using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class GrabPickups : MonoBehaviour {

	private AudioSource pickupSoundSource;

	ScoreManager roomcounter; 

	void Awake() {
		pickupSoundSource = DontDestroy.instance.GetComponents<AudioSource>()[1];


	}

	void OnControllerColliderHit(ControllerColliderHit hit) {
		if (hit.gameObject.tag == "Pickup") {
			pickupSoundSource.Play();
			SceneManager.LoadScene("Play");

			ScoreManager.Score++; 
		}
	}


}
