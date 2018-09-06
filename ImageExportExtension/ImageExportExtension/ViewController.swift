//
//  ViewController.swift
//  ImageExportExtension
//
//  Created by KyungYoung Heo on 2018. 8. 31..
//  Copyright © 2018년 KyungYoung Heo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var imgView: UIImageView!
	@IBOutlet weak var lblText: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		let userDefault = UserDefaults.standard
		userDefault.addSuite(named: "group.ImageExportor")
		
		if let dict = userDefault.value(forKey: "img") as? NSDictionary{
			
			let data = dict.value(forKey: "imgData") as! Data
			let str = dict.value(forKey: "name") as! String
			
			self.imgView.image = UIImage(data: data)
			self.lblText.text = str
			
			userDefault.removeObject(forKey: "img")
			userDefault.synchronize()
		}
	}

}

