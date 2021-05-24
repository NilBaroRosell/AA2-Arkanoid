import GameplayKit
import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }

        guard let nameA = nodeA.name, let nameB = nodeB.name else { return }

        let oneNodeIsBar = nameA == "bar" || nameB == "bar"
        let oneNodeIsLongBar = nameA == "longBar" || nameB == "longBar"
        let oneNodeIsBall = nameA == "ball" || nameB == "ball"
        let oneNodeIsBigBall = nameA == "bigBall" || nameB == "bigBall"
        let oneNodeIsBottom = nameA == "bottom" || nameB == "bottom"
        let oneNodeIsBrick = nameA.hasPrefix("brick") || nameB.hasPrefix("brick")
        let oneNodeIsPU = nameA.hasPrefix("PU") || nameB.hasPrefix("PU")

        if oneNodeIsBall || oneNodeIsBigBall {
            if oneNodeIsBigBall {
                updateVelocity(true)
            } else {
                updateVelocity(false)
            }
        }

        if (oneNodeIsBall || oneNodeIsBigBall), oneNodeIsBrick {
            if nameA.hasPrefix("brick") {
                nodeA.removeFromParent()
                brickLogic(nameA, nodeA.position)
            } else {
                nodeB.removeFromParent()
                brickLogic(nameB, nodeB.position)
            }
            self.destroyedBricks += 1
            return
        }

        if (oneNodeIsBall || oneNodeIsBigBall), (oneNodeIsBar||oneNodeIsLongBar) {
            if oneNodeIsBar {
                self.bar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            } else {
                self.longBar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
        }

        if (oneNodeIsBall || oneNodeIsBigBall), oneNodeIsBottom {
            if oneNodeIsBigBall {
                self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            } else {
                self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
            self.isDead = true
        }

        if oneNodeIsPU, oneNodeIsBottom {
            self.bottom.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            if nameA.hasPrefix("PU") {
                nodeA.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeA.removeFromParent()
            } else {
                nodeB.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeB.removeFromParent()
            }
        }

        if oneNodeIsPU, (oneNodeIsBar||oneNodeIsLongBar) {
            if oneNodeIsBar {
                self.bar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            } else {
                self.longBar.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
            if nameA.hasPrefix("PU") {
                nodeA.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeA.removeFromParent()
                pickUpPowerUp(nameA)
            } else {
                nodeB.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                nodeB.removeFromParent()
                pickUpPowerUp(nameB)
            }
        }

        if self.isBigBall {
            self.lastVelocity = self.bigBall.physicsBody?.velocity ?? CGVector(dx: 0, dy: 0)
        } else {
            self.lastVelocity = self.ball.physicsBody?.velocity ?? CGVector(dx: 0, dy: 0)
        }
    }

    func updateVelocity(_ isBigBall: Bool) {
        var velocityX: CGFloat
        var velocityY: CGFloat
        if isBigBall {
            velocityX = self.bigBall.physicsBody?.velocity.dx ?? 0
            velocityY = self.bigBall.physicsBody?.velocity.dy ?? 0
        } else {
            velocityX = self.ball.physicsBody?.velocity.dx ?? 0
            velocityY = self.ball.physicsBody?.velocity.dy ?? 0
        }
        if velocityX < 0 {
            velocityX = -200
        } else {
            velocityX = 200
        }
        if velocityY < 0 {
            velocityY = -600
        } else {
            velocityY = 600
        }

        if isBigBall {
            self.bigBall.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)
        } else {
            self.ball.physicsBody?.velocity = CGVector(dx: velocityX, dy: velocityY)
        }
    }

    func brickLogic(_ name: String, _ position: CGPoint) {
        let column = Int(name.suffix(1)) ?? 0
        if column != 0 {
            self.currentScore += column * 100
            let row = Int(name.suffix(2).prefix(1)) ?? 0
            if row != 0 {
                self.releasePowerUpIfNeeded(row, column, position)
            }
        }

        if self.isBigBall {
            self.bigBall.physicsBody?.velocity = self.lastVelocity
        }

        self.scoreLabel.text = "\(self.currentScore)"
        if self.currentScore > self.currentHighScore {
            self.currentHighScore = self.currentScore
            self.highScoreLabel.text = "\(self.currentHighScore)"
        }
    }

    func releasePowerUpIfNeeded(_ row: Int, _ column: Int, _ position: CGPoint) {
        if row == Int(self.powerupsPositions[0].x), column == Int(self.powerupsPositions[0].y) {
            self.addLifePU(position)
        } else if row == Int(self.powerupsPositions[1].x), column == Int(self.powerupsPositions[1].y) {
            self.addLongBarPU(position)
            self.lastLongBarPUName = "1"
        } else if row == Int(self.powerupsPositions[2].x), column == Int(self.powerupsPositions[2].y) {
            self.addReverseMovementPU(position)
        } else if row == Int(self.powerupsPositions[3].x), column == Int(self.powerupsPositions[3].y) {
            self.addBigBallPU(position)
        } else if row == Int(self.powerupsPositions[4].x), column == Int(self.powerupsPositions[4].y) {
            self.addTiltMovementPU(position)
        } else if row == Int(self.powerupsPositions[5].y), column == Int(self.powerupsPositions[5].y) {
            self.addLifePU(position)
        } else if row == Int(self.powerupsPositions[6].x), column == Int(self.powerupsPositions[6].y) {
            self.addLongBarPU(position)
            self.lastLongBarPUName = "2"
        }
    }

    func pickUpPowerUp(_ name: String) {
        switch name {
        case "PUbigBall":
            if !self.ball.isHidden {
                let position = self.ball.position
                let velocity = self.ball.physicsBody?.velocity ?? CGVector(dx: 0, dy: 0)
                self.ball.isHidden = true
                self.ball.position.x = -self.size.width
                var action = SKAction.moveTo(x: -self.size.width, duration: 0.01)
                self.ball.run(action)
                self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.bigBall.isHidden = false
                self.bigBall.physicsBody?.velocity = velocity
                action = SKAction.moveTo(x: position.x, duration: 0.001)
                self.bigBall.run(action)
                action = SKAction.moveTo(y: position.y, duration: 0.001)
                self.bigBall.run(action)
                self.isBigBall = true
                checkActivePowerUps("bigBall")
                self.timerPU = Timer.scheduledTimer(timeInterval: 5,
                                                             target: self,
                                                             selector: #selector(undoBigBall),
                                                             userInfo: nil,
                                                             repeats: false)
            }
        case "PUlongBar":
            if !self.isLongBar {
                let position = self.bar.position
                self.bar.isHidden = true
                self.bar.position.x = self.size.width
                var action = SKAction.moveTo(x: self.size.width, duration: 0.01)
                self.bar.run(action)
                self.longBar.isHidden = false
                action = SKAction.moveTo(x: position.x, duration: 0.001)
                self.longBar.run(action)
                action = SKAction.moveTo(y: position.y, duration: 0.001)
                self.longBar.run(action)
                self.isLongBar = true
                checkActivePowerUps("longBar")
                if self.lastLongBarPUName == "1" {
                    self.timerPU = Timer.scheduledTimer(timeInterval: 15,
                                                                 target: self,
                                                                 selector: #selector(self.undoLongBar),
                                                                 userInfo: nil,
                                                                 repeats: false)
                } else {
                    self.timerPU2 = Timer.scheduledTimer(timeInterval: 15,
                                                                 target: self,
                                                                 selector: #selector(self.undoLongBar2),
                                                                 userInfo: nil,
                                                                 repeats: false)
                }
            }
        case "PUlife":
            self.currentLifes += 1
            self.lifesLabel.text = "\(self.currentLifes)"
            checkActivePowerUps("extraLife")
        case "PUtiltMovement":
            self.isTiltMovement = true
            checkActivePowerUps("tiltMovement")
            self.timerPU = Timer.scheduledTimer(timeInterval: 10,
                                                         target: self,
                                                         selector: #selector(undoTiltMovement),
                                                         userInfo: nil,
                                                         repeats: false)
        case "PUreverseMovement":
            self.isReverseMovement = true
            checkActivePowerUps("reverseMovement")
            self.timerPU2 = Timer.scheduledTimer(timeInterval: 15,
                                                         target: self,
                                                         selector: #selector(undoReverseMovement),
                                                         userInfo: nil,
                                                         repeats: false)
        default:
            break
        }
    }

    @objc
    private func undoBigBall() {
        if self.isBigBall {
            let position = self.bigBall.position
            let velocity = self.bigBall.physicsBody?.velocity ?? CGVector(dx: 0, dy: 0)
            self.bigBall.isHidden = true
            self.bigBall.position.x = -self.size.width
            var action = SKAction.moveTo(x: -self.size.width, duration: 0.001)
            self.bigBall.run(action)
            self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.ball.isHidden = false
            self.ball.physicsBody?.velocity = velocity
            action = SKAction.moveTo(x: position.x, duration: 0.001)
            self.ball.run(action)
            action = SKAction.moveTo(y: position.y, duration: 0.001)
            self.ball.run(action)
            self.isBigBall = false
        }
    }

    @objc
    private func undoLongBar() {
        if isLongBar, self.lastLongBarPUName == "1" {
            let position = self.longBar.position
            self.longBar.isHidden = true
            self.longBar.position.x = self.size.width
            var action = SKAction.moveTo(x: self.size.width, duration: 0.001)
            self.longBar.run(action)
            self.bar.isHidden = false
            action = SKAction.moveTo(x: position.x, duration: 0.001)
            self.bar.run(action)
            action = SKAction.moveTo(y: position.y, duration: 0.001)
            self.bar.run(action)
            self.isLongBar = false
        }
    }

    @objc
    private func undoLongBar2() {
        if isLongBar, self.lastLongBarPUName == "2" {
            let position = self.longBar.position
            self.longBar.isHidden = true
            self.longBar.position.x = self.size.width
            var action = SKAction.moveTo(x: self.size.width, duration: 0.001)
            self.longBar.run(action)
            self.bar.isHidden = false
            action = SKAction.moveTo(x: position.x, duration: 0.001)
            self.bar.run(action)
            action = SKAction.moveTo(y: position.y, duration: 0.001)
            self.bar.run(action)
            self.isLongBar = false
        }
    }

    @objc
    private func undoTiltMovement() {
        if isTiltMovement {
            isTiltMovement = false
        }
    }

    @objc
    private func undoReverseMovement() {
        if isReverseMovement {
            isReverseMovement = false
        }
    }

    func checkActivePowerUps(_ newPowerUp: String) {
        if self.isBigBall, newPowerUp != "bigBall" {
            let position = self.bigBall.position
            let velocity = self.bigBall.physicsBody?.velocity ?? CGVector(dx: 0, dy: 0)
            self.bigBall.isHidden = true
            self.bigBall.position.x = -self.size.width
            var action = SKAction.moveTo(x: -self.size.width, duration: 0.001)
            self.bigBall.run(action)
            self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.ball.isHidden = false
            self.ball.physicsBody?.velocity = velocity
            action = SKAction.moveTo(x: position.x, duration: 0.001)
            self.ball.run(action)
            action = SKAction.moveTo(y: position.y, duration: 0.001)
            self.ball.run(action)
            self.isBigBall = false
        }
        if self.isLongBar, newPowerUp != "longBar" {
            let position = self.longBar.position
            self.longBar.isHidden = true
            self.longBar.position.x = self.size.width
            var action = SKAction.moveTo(x: self.size.width, duration: 0.001)
            self.longBar.run(action)
            self.bar.isHidden = false
            action = SKAction.moveTo(x: position.x, duration: 0.001)
            self.bar.run(action)
            action = SKAction.moveTo(y: position.y, duration: 0.001)
            self.bar.run(action)
            self.isLongBar = false
        }
        if self.isTiltMovement, newPowerUp != "tiltMovement" {
            self.isTiltMovement = false
        }
        if self.isReverseMovement, newPowerUp != "reverseMovement" {
            self.isReverseMovement = false
        }
    }
}
