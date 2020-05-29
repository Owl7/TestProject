//
//  ViewController.swift
//  siciDemo
//
//  Created by iOS on 2020/5/6.
//  Copyright © 2020 123. All rights reserved.
//

import UIKit
import GiphyUISDK
import GiphyCoreSDK
import YYImage
import YYWebImage
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
//        if let _ = UserDefaults.standard.object(forKey: "TOKEN") as? String {
//            TestService.getSentence { (isSucc, msg, result) in
//
//            }
//        } else {
//            TestService.getToken { (isSucc, token) in
//                if isSucc {
//                    TestService.getSentence { (isSucc, msg, result) in
//
//                    }
//                }
//            }
//        }
        
//        let giphy = GiphyViewController()
//        giphy.layout = .waterfall
//        giphy.mediaTypeConfig = [.gifs, .stickers, .text, .emoji]
        
        view.addSubview(webImageView)
        webImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
//        https://p7.itc.cn/images01/20200519/eabae8210c4a4adf9ca47baac317fafc.gif
        setImageUrl(url: "https://p0.itc.cn/images01/20200518/730f196bcddd4291afa03537c8e8e8b4.gif")
        
    }
    
    fileprivate lazy var webImageView: YYAnimatedImageView = {
        let iv = YYAnimatedImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .lightGray
        return iv
    }()

    func setImageUrl(url: String) {
        guard let url = URL(string: url) else { return }
        
        webImageView.yy_setImage(with: url,
                                 placeholder: nil,
                                 options: [.progressiveBlur, .showNetworkActivity, .setImageWithFadeAnimation]) {
                                    (image, url, from, stage, error) in
                                    if stage == .finished {
                                        print("加载完成")
                                    }
        }
    }

}

