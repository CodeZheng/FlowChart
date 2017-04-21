//
//  ViewController.swift
//  FlowChart
//
//  Created by admin on 10/04/2017.
//  Copyright © 2017 admin. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {

    var graphArr = ["矩形","箭头","菱形","圆形"]
    var scrollView = UIScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLeftView()
        setupCenterView()
        setupRightView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK:- leftView
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func setupLeftView() {
        let leftView = UITableView(frame: CGRect(x: 0, y: 0, width: screenWidth/4, height: screenHeight), style: .grouped)
        leftView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.1))
        leftView.backgroundColor = .red
        leftView.delegate = self
        leftView.dataSource = self
        self.view.addSubview(leftView)
    }
    //tableView 代理方法
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return graphArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = graphArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = graphArr[indexPath.row]
        imageViewAddPanGesture(str)
    }
}

//MARK:- centerView
extension ViewController {
    func setupCenterView() {
        scrollView = UIScrollView(frame: CGRect(x: screenWidth/4, y: 0, width: screenWidth/2, height: screenHeight))
        scrollView.backgroundColor = .green
        self.view.addSubview(scrollView)
    }
    
    func imageViewAddPanGesture(_ imageName : String) {
        let imageView = UIImageView(frame: CGRect(x: screenWidth/4 + CGFloat(arc4random()%20), y: 20, width: 80, height: 40))
        imageView.backgroundColor = UIColor.clear
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: imageName)
        scrollView.addSubview(imageView)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGeastureAction(sender:)))
        imageView.addGestureRecognizer(panGesture)
    }
    
    func panGeastureAction(sender : UIPanGestureRecognizer) {
        let point = sender.translation(in: scrollView)
        sender.view?.center = CGPoint(x: (sender.view?.center.x)! + point.x, y: (sender.view?.center.y)! + point.y);
        sender.setTranslation(CGPoint(x: 0, y: 0), in: scrollView)
    }
}

//MARK:- rightView
extension ViewController {
    func setupRightView() {
        let rightView = UIView(frame: CGRect(x: screenWidth*3/4, y: 0, width: screenWidth/4, height: screenHeight))
        rightView.backgroundColor = .blue
        self.view.addSubview(rightView)
    }
}
