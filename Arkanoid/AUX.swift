//
//  GameScene.swift
//  BattleStar
//
//  Created by Alumne on 23/3/21.
//

import SpriteKit
import GameplayKit
import CoreMotion

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        self.checkLostBullets()
        
        /*if(self.cloud.position.x < -400)
        {
            self.cloud.position.x = 600
        }*/
        if let accelerometerData = self.motionManager.accelerometerData
        {
            let changeY = (CGFloat(accelerometerData.acceleration.x - self.initialTilt) * -100 )
            
            guard self.initialTilt != 0 else {
                self.initialTilt = accelerometerData.acceleration.x
                return
            }
            guard self.pilotNode.position.y + changeY >= -200 else
            {
                return
            }
            guard self.pilotNode.position.y + changeY <= 200 else
            {
                return
            }
            self.pilotNode.position.y += changeY
            
        }
    }
}
