//
//  ViewController.swift
//  AvitoTest
//
//  Created by Artem  on 06.09.2021.
//

import UIKit

let reachability = try! Reachability()

class MainViewController: UICollectionViewController {
    
    var company = ""
    var employees = [Employee]()
    let networkService: NetworkServiceProtocol
    
    
    let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        return layout
    }()
    
    init(networkService: NetworkServiceProtocol){
        self.networkService = networkService
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkReachability()
        
        collectionView.backgroundColor = .white
        collectionView.collectionViewLayout = layout
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: MyCell.identifier)
        
        getData()
        
    }
    
    func checkReachability() {
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.showAlert()
            
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("unable to start notifier")
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "Нет интернет соединения", message: "Упс! Кажется что-то с интернетом", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {_ in
            NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func getData() {
        networkService.getCompanyInfo { result in
            self.company = result.company.name
            self.employees = result.company.employees
            self.employees.sort { $0.name < $1.name }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCell.identifier, for: indexPath) as? MyCell
        cell?.setupData(company: company, employees: employees[indexPath.item])
        return cell ?? UICollectionViewCell()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 30, height: view.frame.height / 5)
    }
    
}


