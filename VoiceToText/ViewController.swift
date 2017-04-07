//
//  ViewController.swift
//  VoiceToText
//
//  Created by Roger on 1/25/17.
//  Copyright © 2017 Yashwanth. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class ViewController: UIViewController ,AVAudioPlayerDelegate{

    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var textView: UITextView!
    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activitySpinner.isHidden = true
    }
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        player.stop()
        activitySpinner.stopAnimating()
    activitySpinner.isHidden = true
    }
    func requestAuth(){
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized{
                if let path = Bundle.main.url(forResource: "test", withExtension: "m4a"){
                    do{
                        let  sound = try AVAudioPlayer(contentsOf: path)
                        self.audioPlayer = sound
                        self.audioPlayer.delegate = self;
                        sound.play()
                        
                    } catch {
                        print("Error!")
                    }
                    
                    let recognizer = SFSpeechRecognizer()
                    let request = SFSpeechURLRecognitionRequest(url: path)
                    recognizer?.recognitionTask(with: request) {(result,error) in
                        
                        if let error = error{
                            print("There was an error: \(error)")
                        }else{
                           self.textView.text =
                            result?.bestTranscription.formattedString
                        }
                        
                    }
                    
                    
                    
                }
                
            }
        }

    }

    

    @IBAction func playBtnPressed(_ sender: Any) {
        activitySpinner.isHidden = false;
        activitySpinner.startAnimating()
        requestAuth()
           }

}

