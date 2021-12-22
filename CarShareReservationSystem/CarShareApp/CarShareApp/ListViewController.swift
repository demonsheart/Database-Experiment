//
//  ListViewController.swift
//  CarShareApp
//
//  Created by herongjin on 2021/12/22.
//

import UIKit
import SnapKit
import Kingfisher

class ListViewController: UIViewController {
    
    let imgView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        // Do any additional setup after loading the view.
        self.view.addSubview(imgView)
        imgView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.center.equalToSuperview()
            make.height.greaterThanOrEqualTo(100)
        }
        
        imgView.kf.setImage(with: URL(string: "https://s2.loli.net/2021/12/21/4wzUqSflsbaOZ3J.jpg"))
    }

}
