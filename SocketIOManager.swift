//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by JerryMAc on 2016/4/27.
//  Copyright © 2016年 AppCoda. All rights reserved.
//

import UIKit

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    var socket: SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.107")!)
    //By doing this we can simplt write SocketIOManager.shareInstance anywhere around the code and have access to all public properties and methods of the above class
    
    override init(){
        super.init()
    }
    
    func establishConnection(){
        socket.connect()
    }
    
    func closeConnection(){
        socket.disconnect()
    }
}

