//
//  ListViewController.swift
//  CarShare
//
//  Created by herongjin on 2021/12/21.
//

import UIKit
import Kingfisher
import SnapKit

class ListViewController: UIViewController {
    
    let imgView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.center.equalToSuperview()
            make.top.equalTo(100)
            make.height.lessThanOrEqualTo(200)
        }
        
        imgView.kf.setImage(with: URL(string: "https://s2.loli.net/2021/12/21/4wzUqSflsbaOZ3J.jpg"))
    }

}
