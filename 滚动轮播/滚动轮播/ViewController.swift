//
//  ViewController.swift
//  滚动轮播
//
//  Created by mac on 2023/1/5.
//

import UIKit

class ViewController: UIViewController {

    var dataList = ["1","2","3","4","5","6"]
    
    var tableView = UITableView(frame: CGRect(x: 0, y: 200, width: 414, height: 40), style: .plain)
    
    var timer = Timer()

    var addDataList = ["1","2","3","4","5","6"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {[weak self] in
            self?.initTimer()
        }
    }

    func initTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.autoScrollView), userInfo: nil, repeats: true)
        self.timer.fire()

    }
    
    @objc func autoScrollView() {
        var y = self.tableView.contentOffset.y
        print(y)
        y = y + 45
        self.tableView.setContentOffset(CGPoint.init(x: 0, y: y), animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView == tableView{
            let y = scrollView.contentOffset.y
            if  y > CGFloat(45*(self.dataList.count - 2)){
                self.dataList.append(contentsOf: self.addDataList)
                self.tableView.reloadData()
            }
        }
    }
    
    deinit {
        
        self.timer.invalidate()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = dataList[indexPath.row]
        cell.textLabel?.textColor = .red
        if indexPath.row % 2 == 1 {
            cell.backgroundColor = .blue
        }else
        {
            cell.backgroundColor = .yellow

        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
