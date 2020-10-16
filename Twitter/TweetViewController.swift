//
//  TweetViewController.swift
//  Twitter
//
//  Created by Thu Do on 10/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var countLabel: UILabel!
    let charLim = 280
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()
        tweetTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweet(_ sender: Any) {
        if (!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success:{
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Oops I can't post your tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            // todo: post an alert
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func initialCounterValue(text: String?) -> String {
        if let text = text {
            return "\(text.utf16.count)/\(charLim)"
        } else {
            return "0/\(charLim)"
        }
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = NSString(string: tweetTextView.text!).replacingCharacters(in: range, with: text)
        self.countLabel.text = initialCounterValue(text: self.tweetTextView.text)
        return newText.count <= charLim
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
