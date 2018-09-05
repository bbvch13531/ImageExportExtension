//
//  ShareViewController.swift
//  ImageExport
//
//  Created by KyungYoung Heo on 2018. 8. 31..
//  Copyright © 2018년 KyungYoung Heo. All rights reserved.
//

import UIKit
import Social
import CoreData


class ShareViewController: SLComposeServiceViewController {

	let container = NSPersistentContainer(name: "DataModel")
	
	override func viewDidLoad() {
		
		
		container.loadPersistentStores(completionHandler: { (description, error) in
			if let error = error {
				fatalError("Unable to load persistent stores: \(error)")
			}
		})
	}
	
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
	
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
		let fileManager = FileManager.default
		
		
		if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem {
//			print(item.attachments)
			for ele in item.attachments!{
			
				
				let itemProvider = ele as! NSItemProvider
				
				if itemProvider.hasItemConformingToTypeIdentifier("public.png"){
					print(itemProvider)
//					itemProvider.loadItem(forTypeIdentifier: "public.jpg", options: nil, completionHandler: { (item, error) in
//						do{
//							var imgData: Data!
//							if let url = item as? URL{
//								imgData = try Data(contentsOf: url)
//							}
//
//							if let img = item as? UIImage{
//								imgData = UIImagePNGRepresentation(img)
//							}
//							print("imgData =  \(imgData)")
//						} catch let err{
//							print(err)
//						}
//					})
					itemProvider.loadItem(forTypeIdentifier: "public.png", options: nil, completionHandler: {(item,error) in
						do{
							print("found image : \(item)")
							Alamofire.request
						} catch let error {
							print(error)
						}
					})
				}
				else	{
					print("Cannot find image")
				}
			}
		}
		
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
		
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
