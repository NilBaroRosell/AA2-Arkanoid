import GameplayKit
import SpriteKit
import CoreMotion

class GameScene: SKScene {
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
    var highScoreTitleLabel: SKLabelNode!
    var highScoreLabel: SKLabelNode!
    var scoreTitleLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var lifesTitleLabel: SKLabelNode!
    var lifesLabel: SKLabelNode!

    var timerPU: Timer?

    var currentHighScore: Int = 0
    var currentScore: Int = 0
    var currentLifes: Int = 3

    var barYPositon: CGFloat = 0.0
    var sizeW: CGFloat = 0
    var sizeH: CGFloat = 0

    var lastVelocity: CGVector = CGVector(dx: 0, dy: 0)

    var isDead: Bool = false
    var isLongBar: Bool = false
    var isBigBall: Bool = false
    var isTiltMovement: Bool = false
    var isReverseMovement: Bool = false

    private let motionManager = CMMotionManager()

    override func didMove(to _: SKView) {
        self.backgroundColor = .black

        self.addBackground()
        self.addLeftBorder()
        self.addRightBorder()
        self.addTopBorder()

        self.addBar()
        self.addLongBar()

        self.addBall()
        self.addBigBall()

        self.addBricks(at: 100)

        self.physicsWorld.contactDelegate = self

        self.addScoreLabels()
        self.addLifesLabels()
        self.addHighScoreLabels()

        self.addBottom()

        self.aux()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        if let touch = touches.first {
            self.barTouch = touch
            if !isTiltMovement {
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
    }

    override func touchesMoved(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let barTouch = self.barTouch else { return }
        guard let touchIndex = touches.firstIndex(of: barTouch) else { return }

        let touch = touches[touchIndex]

        if !isTiltMovement {
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

    override func update(_: TimeInterval) {
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
            print("TILT")
            if let accelerometerData = self.motionManager.accelerometerData {
                print("ENTRA")
                let changeX = CGFloat(accelerometerData.acceleration.x) * (self.size.width/2)
                /*guard self.initialTilt != 0 else {
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
                }*/
                let action = SKAction.moveTo(x: changeX, duration: 0.05)
                action.timingMode = .easeInEaseOut
                self.bar.run(action)
            }
        }
    }
}

extension GameScene {
    func resetPosition() {
        if self.currentLifes > 0 {
            if self.isBigBall {
                let position = CGPoint(x: self.bar.position.x, y: self.barYPositon + 22)
                self.bigBall.isHidden = true
                self.bigBall.position.x = -self.size.width
                var action = SKAction.moveTo(x: -self.size.width, duration: 0.01)
                self.bigBall.run(action)
                self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                self.ball.isHidden = false
                action = SKAction.moveTo(x: position.x, duration: 0.01)
                self.ball.run(action)
                action = SKAction.moveTo(y: position.y, duration: 0.01)
                self.ball.run(action)
                self.isBigBall = false
            }
            if self.isLongBar {
                let position = self.longBar.position
                self.longBar.isHidden = true
                self.longBar.position.x = self.size.width
                var action = SKAction.moveTo(x: self.size.width, duration: 0.01)
                self.longBar.run(action)
                self.bar.isHidden = false
                action = SKAction.moveTo(x: position.x, duration: 0.01)
                self.bar.run(action)
                action = SKAction.moveTo(y: position.y, duration: 0.01)
                self.bar.run(action)
                self.isLongBar = false
                self.ball.position = CGPoint(x: position.x, y: self.barYPositon + 22)
            } else {
                self.ball.position = CGPoint(x: self.bar.position.x, y: self.barYPositon + 22)
            }
            print(self.ball.position)
            let random = Int.random(in: 1...2)
            if random == 1 {
                self.ball.physicsBody?.velocity = CGVector(dx: 200, dy: 600)
            } else {
                self.ball.physicsBody?.velocity = CGVector(dx: -200, dy: 600)
            }

            self.currentLifes -= 1
            self.lifesLabel.text = "\(self.currentLifes)"
        } else {
            print("DEAD, BITCH")
        }
    }
}
