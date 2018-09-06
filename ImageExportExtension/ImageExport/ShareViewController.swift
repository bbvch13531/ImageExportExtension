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
import Alamofire

class ShareViewController: SLComposeServiceViewController {
	
	override func viewDidLoad() {
		
	}
	
    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }
	
    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
		
		if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem {
//			print(item.attachments)
			for ele in item.attachments!{
			
				
				let itemProvider = ele as! NSItemProvider
				
				if itemProvider.hasItemConformingToTypeIdentifier("public.png"){
					print(itemProvider)
//					itemProvider.loadItem(forTypeIdentifier: "public.jpeg", options: nil, completionHandler: { (item, error) in
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
							var imgData = UIImage()
//							if let data = item {
//								imgData = UIImage(data: NSData(contentsOfURL: data as! NSURL)!)
//							}
							if let url = item as? NSURL{
								if let data = NSData(contentsOf: url as URL){
									imgData = UIImage(data: data as Data)!
//									self.uploadImage(data: data as Data)
								}
							}
//							if let img = item as? UIImage{
//								imgData = UIImagePNGRepresentation(img)
//
//							} else {
//
//							}
							if let uploadImgData = UIImagePNGRepresentation(imgData) {
								
								self.uploadImage(data: uploadImgData)
							}
							
							print("imgData = \(imgData), item = \(item)")

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
	func uploadImage(data:Data){
		var params: Parameters = [
			"file" : data
		]
//		let encoding = URLEncoding.httpBody
//		Alamofire.request("http://neinsys.io:5000/insertImagePost", method: .post, parameters: params, encoding: encoding)
//			.validate(contentType: ["multipart/form-data"])
//			.response { response in
////			print(response.result)
//			debugPrint(response)
//		}
		print("data = \(data)")
		Alamofire.upload(
			multipartFormData: { multipartFormData in
				multipartFormData.append(data, withName:"file", fileName: "extension.jpg", mimeType: "image/jpg")
			},
			to : "http://neinsys.io:5000/insertImagePost",
			encodingCompletion: { encodingResult in
				switch encodingResult {
				case .success(let upload, _, _):
					upload.responseString { response in
						debugPrint(response.result.value)
					}
					print("success")
				case .failure(let encodingError):
					print("fail! \(encodingError)")
				}
			}
		)
	}
}
