//
//  WelcomeViewController.swift
//  Final Project~ Connect4
//
//  Created by Kameko Duplessy on 5/10/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     
         
    @IBAction func playButtonisTapped(_ sender: UIButton) 
    {
    
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                viewController.modalPresentationStyle = .fullScreen
                present(viewController, animated: true, completion: nil)
            }
        }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
