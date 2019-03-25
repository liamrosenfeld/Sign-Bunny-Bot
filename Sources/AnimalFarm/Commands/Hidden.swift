//
//  Hidden.swift
//  AnimalFarm
//
//  Created by Liam on 2/19/19.
//

import Foundation
import Sword
import HeliumLogger
import LoggerAPI

extension Shield {
    func addHidden() {
        self.register("stats") { msg, args in
            if !self.auth(args.first ?? "") {
                return
            }
            
            let message = """
                        I Am In:
                        \(self.guilds.count) Servers
                        \(self.dms.count) DMs
                        \(self.groups.count) Groups
                        """
            msg.reply(with: message)
        }
        
        self.register("servers") { _, args in
            if !self.auth(args.first ?? "") {
                return
            }
            
            var log = "\nServers:"
            for guild in self.guilds {
                log += "\n - \(guild.value.name)"
            }
            
            Log.info(log)
        }
    }
    
    fileprivate func auth(_ pass: String) -> Bool {
        guard let password = ProcessInfo.processInfo.environment[SecretNames.stats.rawValue] else {
            Log.warning("No Stat Password Provided")
            return false
        }
        
        return pass == password
    }
}
