//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Thu Do on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retButton: UIButton!
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId:Int = -1
    
    @IBAction func onFav(_ sender: Any) {
        if (!favorited){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (Error) in
                print("Can't favorite tweet")
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: {(Error)  in
                print("Can't unfavorite tweet")
            })
        }
    }
    
    @IBAction func onRet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
            self.setRetweet(true)
        }, failure: {(Error) in
            print("Can't retweet:")
        })
    }
    
    func setFavorite(_ isFav: Bool){
        favorited = isFav
        if (favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if (retweeted){
            retButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retButton.isEnabled = false
        } else {
            retButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retButton.isEnabled = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
