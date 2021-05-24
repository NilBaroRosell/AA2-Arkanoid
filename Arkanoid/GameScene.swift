import GameplayKit
import SpriteKit
import CoreMotion

class GameScene: SKScene {
    var blackBackground: SKSpriteNode!
    var logo: SKSpriteNode!
    var background: SKSpriteNode!
    var leftBorder: SKSpriteNode!
    var rightBorder: SKSpriteNode!
    var topBorder: SKSpriteNode!
    var bar: SKSpriteNode!
    var longBar: SKSpriteNode!
    var ball: SKSpriteNode!
    var bigBall: SKSpriteNode!
    var bigBallPU: SKSpriteNode!
    var longBarPU: SKSpriteNode!
    var lifePU: SKSpriteNode!
    var tiltMovementPU: SKSpriteNode!
    var reverseMovementPU: SKSpriteNode!

    var bottom: SKSpriteNode!

    private var barTouch: UITouch?
    var nameLabel: SKLabelNode!
    var playButtonLabel: SKLabelNode!
    var exitButtonLabel: SKLabelNode!
    var highScoreTitleLabel: SKLabelNode!
    var highScoreLabel: SKLabelNode!
    var scoreTitleLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var lifesTitleLabel: SKLabelNode!
    var lifesLabel: SKLabelNode!
    var finalScoreLabel: SKLabelNode!
    var newPersonalRecordLabel: SKLabelNode!
    var playAgainLabel: SKLabelNode!
    var yesLabel: SKLabelNode!
    var noLabel: SKLabelNode!

    var timer: Timer?
    var timerPU: Timer?
    var timerPU2: Timer?

    var highScoreKey: String = "HighScore"
    var lastLongBarPUName: String = ""

    var currentHighScore: Int = 0
    var currentScore: Int = 0
    var currentLifes: Int = 3
    var destroyedBricks: Int = 0

    var barYPositon: CGFloat = 0.0
    var sizeW: CGFloat = 0
    var sizeH: CGFloat = 0

    var powerupsPositions: [CGPoint] = []
    var bricks: [Bricks] = []

    var lastVelocity: CGVector = CGVector(dx: 0, dy: 0)

    var isBlocked: Bool = true
    var isMenu: Bool = false
    var isEndGame: Bool = false
    var isDead: Bool = false
    var isLongBar: Bool = false
    var isBigBall: Bool = false
    var isTiltMovement: Bool = false
    var isReverseMovement: Bool = false

    private let motionManager = CMMotionManager()

    let barSound = SKAction.playSoundFileNamed("bar sound.wav", waitForCompletion: false)
    let brickSound = SKAction.playSoundFileNamed("brick sound.wav", waitForCompletion: false)
    let brickHitSound = SKAction.playSoundFileNamed("brick hit sound.wav", waitForCompletion: false)
    let deadSound = SKAction.playSoundFileNamed("dead.wav", waitForCompletion: false)
    let longBarSound = SKAction.playSoundFileNamed("long bar sound.wav", waitForCompletion: false)
    let lostSound = SKAction.playSoundFileNamed("lost.wav", waitForCompletion: false)
    let powerupSound = SKAction.playSoundFileNamed("powerup sound.wav", waitForCompletion: false)
    let startSound = SKAction.playSoundFileNamed("start.wav", waitForCompletion: false)
    let clickSound = SKAction.playSoundFileNamed("click sound.wav", waitForCompletion: false)

    override func didMove(to _: SKView) {
        self.backgroundColor = .black

        self.addBlackBackground()
        self.addLogo()
        self.addName()
        self.addPlayButton()
        self.addExitButton()

        self.addFinalScore()
        self.addNewPersonalBest()
        self.addPlayAgain()
        self.addYes()
        self.addNo()

        self.addBackground()
        self.addLeftBorder()
        self.addRightBorder()
        self.addTopBorder()

        self.addBar()
        self.addLongBar()

        self.addBall()
        self.addBigBall()

        self.addBricks()

        self.physicsWorld.contactDelegate = self
        self.setPowerupPositions()

        self.addScoreLabels()
        self.addLifesLabels()
        self.addHighScoreLabels()

        self.addBottom()

        self.motionManager.startAccelerometerUpdates()

        self.timer = Timer.scheduledTimer(timeInterval: 3,
                                          target: self,
                                          selector: #selector(self.showMenu),
                                          userInfo: nil,
                                          repeats: false)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        if let touch = touches.first {
            self.barTouch = touch
            if !self.isTiltMovement, !self.isBlocked {
                let newPosition = touch.location(in: self)
                let action: SKAction
                if self.isReverseMovement {
                    action = SKAction.moveTo(x: -newPosition.x, duration: 0.05)
                } else {
                    action = SKAction.moveTo(x: newPosition.x, duration: 0.05)
                }
                action.timingMode = .easeInEaseOut
                if self.isLongBar {
                    self.longBar.run(action)
                } else {
                    self.bar.run(action)
                }
            } else if self.isBlocked, self.isMenu {
                let position = touch.location(in: self)
                if position.x > -100, position.x < 100, position.y > -100, position.y < 100 {
                    run(self.clickSound)
                    self.startGame()
                } else if position.x > -100, position.x < 100, position.y > -350, position.y < -150 {
                    run(self.clickSound)
                    self.exitButtonPressed()
                }
            } else if self.isBlocked, self.isEndGame {
                let position = touch.location(in: self)
                if position.x > -75, position.x < 75, position.y > -250, position.y < 100 {
                    run(self.clickSound)
                    self.startGame()
                } else if position.x > -75, position.x < 75, position.y > -400, position.y < -250 {
                    run(self.clickSound)
                    self.showMenu()
                }
            }
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let barTouch = self.barTouch else { return }
        guard let touchIndex = touches.firstIndex(of: barTouch) else { return }

        let touch = touches[touchIndex]

        if !self.isTiltMovement, !self.isBlocked {
            let newPosition = touch.location(in: self)
            let action: SKAction
            if self.isReverseMovement {
                action = SKAction.moveTo(x: -newPosition.x, duration: 0.05)
            } else {
                action = SKAction.moveTo(x: newPosition.x, duration: 0.05)
            }
            action.timingMode = .easeInEaseOut
            if self.isLongBar {
                self.longBar.run(action)
            } else {
                self.bar.run(action)
            }
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let spaceshipTouch = self.barTouch else { return }
        guard touches.firstIndex(of: spaceshipTouch) != nil else { return }

        self.barTouch = nil
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let barTouch = self.barTouch else { return }
        guard touches.firstIndex(of: barTouch) != nil else { return }

        self.barTouch = nil
    }

    override func update(_ currentTime: TimeInterval) {
        if self.destroyedBricks >= 40, !self.isEndGame {
            self.updateHighScore(self.currentScore)
            if self.isBigBall {
                self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            } else {
                self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
            self.bigBallPU?.removeFromParent()
            self.longBarPU?.removeFromParent()
            self.lifePU?.removeFromParent()
            self.tiltMovementPU?.removeFromParent()
            self.reverseMovementPU?.removeFromParent()
            self.isBlocked = true
            self.isEndGame = true
            self.timer = Timer.scheduledTimer(timeInterval: 2,
                                              target: self,
                                              selector: #selector(self.showPlayAgainMenu),
                                              userInfo: nil,
                                              repeats: false)
        } else {
            if self.isDead && self.ball.position != CGPoint(x: 0, y: self.barYPositon + 22) {
                self.resetPosition()
                self.isDead = false
            }
            if self.isLongBar {
                if self.longBar.position.y != self.barYPositon {
                    self.longBar.position.y = self.barYPositon
                }
            } else {
                if self.bar.position.y != self.barYPositon {
                    self.bar.position.y = self.barYPositon
                }
            }

            if self.isTiltMovement {
                if let accelerometerData = self.motionManager.accelerometerData {
                    let changeX = CGFloat(accelerometerData.acceleration.x) * (self.size.width/2)
                    let action = SKAction.moveTo(x: changeX, duration: 0.05)
                    action.timingMode = .easeInEaseOut
                    self.bar.run(action)
                }
            }
        }
    }
}

extension GameScene {
    @objc
    private func showMenu() {
        self.blackBackground.isHidden = false
        self.logo.isHidden = false
        self.nameLabel.isHidden = true
        self.playButtonLabel.isHidden = false
        self.exitButtonLabel.isHidden = false
        self.finalScoreLabel.isHidden = true
        self.newPersonalRecordLabel.isHidden = true
        self.playAgainLabel.isHidden = true
        self.yesLabel.isHidden = true
        self.noLabel.isHidden = true
        self.isEndGame = false
        self.isMenu = true
    }

    func startGame() {
        self.blackBackground.isHidden = true
        self.logo.isHidden = true
        self.nameLabel.isHidden = true
        self.playButtonLabel.isHidden = true
        self.exitButtonLabel.isHidden = true
        self.finalScoreLabel.isHidden = true
        self.newPersonalRecordLabel.isHidden = true
        self.playAgainLabel.isHidden = true
        self.yesLabel.isHidden = true
        self.noLabel.isHidden = true
        self.isBlocked = false
        self.isMenu = false
        self.isEndGame = false
        let random = Int.random(in: 1...2)
        if random == 1 {
            self.ball.physicsBody?.velocity = CGVector(dx: 200, dy: 600)
        } else {
            self.ball.physicsBody?.velocity = CGVector(dx: -200, dy: 600)
        }
        run(self.startSound)
    }

    func exitButtonPressed() {
        exit(0)
    }

    @objc
    private func showPlayAgainMenu() {
        self.blackBackground.isHidden = false
        self.finalScoreLabel.isHidden = false
        self.finalScoreLabel.text = "YOUR FINAL SCORE IS: \(self.currentScore)"
        if self.currentScore == self.currentHighScore {
            self.newPersonalRecordLabel.isHidden = false
        }
        self.playAgainLabel.isHidden = false
        self.yesLabel.isHidden = false
        self.noLabel.isHidden = false
        self.restart()
    }

    func resetPosition() {
        if self.currentLifes > 0 {
            run(self.deadSound)
            self.positions()
            let random = Int.random(in: 1...2)
            if random == 1 {
                self.ball.physicsBody?.velocity = CGVector(dx: 200, dy: 600)
            } else {
                self.ball.physicsBody?.velocity = CGVector(dx: -200, dy: 600)
            }
            self.currentLifes -= 1
            self.lifesLabel.text = "\(self.currentLifes)"
        } else {
            run(self.lostSound)
            self.updateHighScore(self.currentScore)
            if self.isBigBall {
                self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            } else {
                self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            }
            self.bigBallPU?.removeFromParent()
            self.longBarPU?.removeFromParent()
            self.lifePU?.removeFromParent()
            self.tiltMovementPU?.removeFromParent()
            self.reverseMovementPU?.removeFromParent()
            self.isBlocked = true
            self.isEndGame = true
            self.timer = Timer.scheduledTimer(timeInterval: 2,
                                              target: self,
                                              selector: #selector(self.showPlayAgainMenu),
                                              userInfo: nil,
                                              repeats: false)
        }
    }

    func positions() {
        if self.isBigBall {
            var position = CGPoint(x: self.bar.position.x, y: self.barYPositon + 22)
            if position.x >= self.size.width/2 {
                position = CGPoint(x: self.size.width/2 - 50, y: position.y)
            } else if position.x <= -self.size.width/2 {
                position = CGPoint(x: -self.size.width/2 + 50, y: position.y)
            }
            self.bigBall.isHidden = true
            self.bigBall.position.x = -self.size.width
            var action = SKAction.moveTo(x: -self.size.width, duration: 0.001)
            self.bigBall.run(action)
            self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            self.ball.isHidden = false
            action = SKAction.moveTo(x: position.x, duration: 0.001)
            self.ball.run(action)
            action = SKAction.moveTo(y: position.y, duration: 0.001)
            self.ball.run(action)
            self.isBigBall = false
            self.bar.position = CGPoint(x: position.x, y: self.bar.position.y)
        }
        if self.isLongBar {
            var position = self.longBar.position
            if position.x >= self.size.width/2 {
                position = CGPoint(x: self.size.width/2 - 50, y: position.y)
            } else if position.x <= -self.size.width/2 {
                position = CGPoint(x: -self.size.width/2 + 50, y: position.y)
            }
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
            self.ball.position = CGPoint(x: position.x, y: self.barYPositon + 22)
            self.bar.position = CGPoint(x: position.x, y: self.bar.position.y)
        } else {
            var position = self.bar.position
            if position.x >= self.size.width/2 {
                position = CGPoint(x: self.size.width/2 - 50, y: position.y)
            } else if position.x <= -self.size.width/2 {
                position = CGPoint(x: -self.size.width/2 + 50, y: position.y)
            }
            self.ball.position = CGPoint(x: position.x, y: self.barYPositon + 22)
            self.bar.position = CGPoint(x: position.x, y: self.bar.position.y)
        }
    }

    func restart() {
        self.positions()
        self.setPowerupPositions()
        self.deleteBricksAndPowerUps()
        self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.isTiltMovement = false
        self.isReverseMovement = false
        self.currentScore = 0
        self.scoreLabel.text = "\(self.currentScore)"
        self.currentLifes = 3
        self.lifesLabel.text = "\(self.currentLifes)"
        self.destroyedBricks = 0
    }

    func deleteBricksAndPowerUps() {
        for brick in 0 ... 7 {
            self.childNode(withName: "brick\(brick + 1)\(1)")?.removeFromParent()
        }
        for brick in 0 ... 7 {
            self.childNode(withName: "brick\(brick + 1)\(2)")?.removeFromParent()
        }
        for brick in 0 ... 7 {
            self.childNode(withName: "brick\(brick + 1)\(3)")?.removeFromParent()
        }
        for brick in 0 ... 7 {
            self.childNode(withName: "brick\(brick + 1)\(4)")?.removeFromParent()
        }
        for brick in 0 ... 7 {
            self.childNode(withName: "brick\(brick + 1)\(5)")?.removeFromParent()
        }
        self.childNode(withName: "PUbigBall")?.removeFromParent()
        self.childNode(withName: "PUlongBar")?.removeFromParent()
        self.childNode(withName: "PUlife")?.removeFromParent()
        self.childNode(withName: "PUtiltMovement")?.removeFromParent()
        self.childNode(withName: "PUreverseMovement")?.removeFromParent()
        self.addBricks()
    }

    func updateHighScore(_ score: Int) {
        self.currentHighScore = max(score, self.currentHighScore)
        UserDefaults.standard.setValue(self.currentHighScore, forKey: self.highScoreKey)
    }
}
