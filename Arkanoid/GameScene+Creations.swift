import GameplayKit
import SpriteKit

extension GameScene {
    func addBlackBackground() {
        self.blackBackground = SKSpriteNode(imageNamed: "BlackBackground")
        self.blackBackground.name = "blackBackground"
        self.blackBackground.size = CGSize(width: self.size.width, height: self.size.height)
        self.blackBackground.position = CGPoint(x: 0, y: 0)
        self.blackBackground.zPosition = 2
        self.addChild(self.blackBackground)
    }

    func addLogo() {
        self.logo = SKSpriteNode(imageNamed: "ArkanoidLogo")
        self.logo.name = "logo"
        self.logo.size = CGSize(width: (2/3) * self.size.width, height: self.size.height/6)
        self.logo.position = CGPoint(x: 0, y: 350)
        self.logo.zPosition = 3
        self.addChild(self.logo)
    }

    func addName() {
        self.nameLabel = SKLabelNode(text: "BY NIL BARO")
        self.nameLabel.fontName = "iomanoid"
        self.nameLabel.fontColor = UIColor.white
        self.nameLabel.fontSize = 75
        self.nameLabel.position = CGPoint(x: 0, y: -100)
        self.nameLabel.zPosition = 3
        self.addChild(self.nameLabel)
    }

    func addPlayButton() {
        self.playButtonLabel = SKLabelNode(text: "PLAY")
        self.playButtonLabel.fontName = "iomanoid"
        self.playButtonLabel.fontColor = UIColor.white
        self.playButtonLabel.fontSize = 100
        self.playButtonLabel.position = CGPoint(x: 0, y: -50)
        self.playButtonLabel.zPosition = 3
        self.addChild(self.playButtonLabel)
        self.playButtonLabel.isHidden = true
    }

    func addExitButton() {
        self.exitButtonLabel = SKLabelNode(text: "EXIT")
        self.exitButtonLabel.fontName = "iomanoid"
        self.exitButtonLabel.fontColor = UIColor.white
        self.exitButtonLabel.fontSize = 100
        self.exitButtonLabel.position = CGPoint(x: 0, y: -300)
        self.exitButtonLabel.zPosition = 3
        self.addChild(self.exitButtonLabel)
        self.exitButtonLabel.isHidden = true
    }

    func addFinalScore() {
        self.finalScoreLabel = SKLabelNode(text: "YOUR FINAL SCORE IS: 5555")
        self.finalScoreLabel.fontName = "iomanoid"
        self.finalScoreLabel.fontColor = UIColor.red
        self.finalScoreLabel.fontSize = 60
        self.finalScoreLabel.position = CGPoint(x: 0, y: 350)
        self.finalScoreLabel.zPosition = 3
        self.addChild(self.finalScoreLabel)
        self.finalScoreLabel.isHidden = true
    }

    func addNewPersonalBest() {
        self.newPersonalRecordLabel = SKLabelNode(text: "NEW PERSONAL RECORD!")
        self.newPersonalRecordLabel.fontName = "iomanoid"
        self.newPersonalRecordLabel.fontColor = UIColor.red
        self.newPersonalRecordLabel.fontSize = 60
        self.newPersonalRecordLabel.position = CGPoint(x: 0, y: 200)
        self.newPersonalRecordLabel.zPosition = 3
        self.addChild(self.newPersonalRecordLabel)
        self.newPersonalRecordLabel.isHidden = true
    }

    func addPlayAgain() {
        self.playAgainLabel = SKLabelNode(text: "DO YOU WANT TO PLAY AGAIN?")
        self.playAgainLabel.fontName = "iomanoid"
        self.playAgainLabel.fontColor = UIColor.white
        self.playAgainLabel.fontSize = 60
        self.playAgainLabel.position = CGPoint(x: 0, y: -50)
        self.playAgainLabel.zPosition = 3
        self.addChild(self.playAgainLabel)
        self.playAgainLabel.isHidden = true
    }

    func addYes() {
        self.yesLabel = SKLabelNode(text: "YES")
        self.yesLabel.fontName = "iomanoid"
        self.yesLabel.fontColor = UIColor.white
        self.yesLabel.fontSize = 60
        self.yesLabel.position = CGPoint(x: 0, y: -200)
        self.yesLabel.zPosition = 3
        self.addChild(self.yesLabel)
        self.yesLabel.isHidden = true
    }

    func addNo() {
        self.noLabel = SKLabelNode(text: "NO")
        self.noLabel.fontName = "iomanoid"
        self.noLabel.fontColor = UIColor.white
        self.noLabel.fontSize = 60
        self.noLabel.position = CGPoint(x: 0, y: -350)
        self.noLabel.zPosition = 3
        self.addChild(self.noLabel)
        self.noLabel.isHidden = true
    }

    func addBackground() {
        self.background = SKSpriteNode(imageNamed: "Background")
        self.background.name = "background"
        self.background.size = CGSize(width: self.size.width - 20, height: self.size.height - 125)
        self.background.position = CGPoint(x: 0, y: -65)
        self.background.zPosition = 0
        self.addChild(self.background)
    }

    func addLeftBorder() {
        self.leftBorder = SKSpriteNode(imageNamed: "LeftBorder")
        self.leftBorder.name = "borderleft"
        self.leftBorder.size = CGSize(width: 25, height: self.size.height - 125)
        self.leftBorder.position = CGPoint(x: -(self.size.width / 2) + 15, y: -63)
        self.leftBorder.zPosition = 1
        self.addChild(self.leftBorder)
        self.leftBorder.physicsBody = SKPhysicsBody(texture: self.leftBorder.texture!, size: self.leftBorder.size)
        self.leftBorder.physicsBody?.allowsRotation = false
        self.leftBorder.physicsBody?.affectedByGravity = false
        self.leftBorder.physicsBody?.isDynamic = false
        self.leftBorder.physicsBody?.restitution = 1.0
        self.leftBorder.physicsBody?.friction = 0.0
        self.leftBorder.physicsBody?.linearDamping = 0.0
        self.leftBorder.physicsBody?.categoryBitMask = 0x0000_0001
    }

    func addRightBorder() {
        self.rightBorder = SKSpriteNode(imageNamed: "RightBorder")
        self.rightBorder.name = "borderright"
        self.rightBorder.size = CGSize(width: 25, height: self.size.height - 130)
        self.rightBorder.position = CGPoint(x: (self.size.width / 2) - 15, y: -63)
        self.rightBorder.zPosition = 1
        self.addChild(self.rightBorder)
        self.rightBorder.physicsBody = SKPhysicsBody(texture: self.rightBorder.texture!, size: self.rightBorder.size)
        self.rightBorder.physicsBody?.allowsRotation = false
        self.rightBorder.physicsBody?.affectedByGravity = false
        self.rightBorder.physicsBody?.isDynamic = false
        self.rightBorder.physicsBody?.restitution = 1.0
        self.rightBorder.physicsBody?.friction = 0.0
        self.rightBorder.physicsBody?.linearDamping = 0.0
        self.rightBorder.physicsBody?.categoryBitMask = 0x0000_0001
    }

    func addTopBorder() {
        self.topBorder = SKSpriteNode(imageNamed: "TopBorder")
        self.topBorder.name = "bordertop"
        self.topBorder.size = CGSize(width: self.size.width - 9, height: 25)
        self.topBorder.position = CGPoint(x: 0, y: (self.size.height / 2) - 130)
        self.topBorder.zPosition = 1
        self.addChild(self.topBorder)
        self.topBorder.physicsBody = SKPhysicsBody(texture: self.topBorder.texture!, size: self.topBorder.size)
        self.topBorder.physicsBody?.allowsRotation = false
        self.topBorder.physicsBody?.affectedByGravity = false
        self.topBorder.physicsBody?.isDynamic = false
        self.topBorder.physicsBody?.restitution = 1.0
        self.topBorder.physicsBody?.friction = 0.0
        self.topBorder.physicsBody?.linearDamping = 0.0
        self.topBorder.physicsBody?.categoryBitMask = 0x0000_0001
    }

    func addBar() {
        self.barYPositon = -(self.size.height / 2) + 100
        self.bar = SKSpriteNode(imageNamed: "ShortBar")
        self.bar.name = "bar"
        self.bar.size = CGSize(width: 100, height: 25)
        self.bar.position = CGPoint(x: 0, y: barYPositon)
        self.bar.zPosition = 1
        self.addChild(self.bar)
        sizeW = self.bar.size.width
        sizeH = self.bar.size.height
        self.bar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.bar.physicsBody?.allowsRotation = false
        self.bar.physicsBody?.affectedByGravity = false
        self.bar.physicsBody?.restitution = 1.0
        self.bar.physicsBody?.friction = 0.0
        self.bar.physicsBody?.linearDamping = 0.0
        self.bar.physicsBody?.categoryBitMask = 0x0001_0010
    }

    func addLongBar() {
        self.longBar = SKSpriteNode(imageNamed: "LongBar")
        self.longBar.name = "longBar"
        self.longBar.size = CGSize(width: 150, height: 25)
        self.longBar.position = CGPoint(x: self.size.width, y: barYPositon)
        self.longBar.zPosition = 1
        self.addChild(self.longBar)
        sizeW = self.longBar.size.width
        sizeH = self.longBar.size.height
        self.longBar.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.longBar.physicsBody?.allowsRotation = false
        self.longBar.physicsBody?.affectedByGravity = false
        self.longBar.physicsBody?.restitution = 1.0
        self.longBar.physicsBody?.friction = 0.0
        self.longBar.physicsBody?.linearDamping = 0.0
        self.longBar.physicsBody?.categoryBitMask = 0x0001_0010
    }

    func addBall() {
        self.ball = SKSpriteNode(imageNamed: "SmallBall")
        self.ball.name = "ball"
        self.ball.size = CGSize(width: 17, height: 17)
        self.ball.position = CGPoint(x: 0, y: self.barYPositon + 22)
        self.ball.zPosition = 1
        self.addChild(self.ball)
        sizeW = self.ball.size.width
        sizeH = self.ball.size.height
        self.ball.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.ball.physicsBody?.affectedByGravity = false
        self.ball.physicsBody?.allowsRotation = false
        self.ball.physicsBody?.restitution = 1.0
        self.ball.physicsBody?.friction = 0.0
        self.ball.physicsBody?.linearDamping = 0.0
        self.ball.physicsBody?.contactTestBitMask = 0x0000_1111
        self.ball.physicsBody?.collisionBitMask = 0x0000_1111
        self.ball.physicsBody?.categoryBitMask = 0x0000_0111
    }

    func addBigBall() {
        self.bigBall = SKSpriteNode(imageNamed: "BigBall")
        self.bigBall.name = "bigBall"
        self.bigBall.size = CGSize(width: 25, height: 25)
        self.bigBall.position = CGPoint(x: -self.size.width, y: self.barYPositon + 30)
        self.bigBall.zPosition = 1
        self.addChild(self.bigBall)
        sizeW = self.bigBall.size.width
        sizeH = self.bigBall.size.height
        self.bigBall.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.bigBall.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        self.bigBall.physicsBody?.affectedByGravity = false
        self.bigBall.physicsBody?.allowsRotation = false
        self.bigBall.physicsBody?.restitution = 1.0
        self.bigBall.physicsBody?.friction = 0.0
        self.bigBall.physicsBody?.linearDamping = 0.0
        self.bigBall.physicsBody?.contactTestBitMask = 0x0000_1111
    }

    func addBricks() {
        let startX = -(self.size.width / 2) + 85
        var startY = (self.size.height / 2) - 200
        var auxNum: Int

        auxNum = 1
        for brick in 0 ... 7 {
            self.addBrick(5, auxNum, at: CGPoint(x: startX + (1.5 * CGFloat(brick) * 55.0), y: startY))
            auxNum += 1
        }

        startY -= 50.0
        auxNum = 1
        for brick in 0 ... 7 {
            self.addBrick(4, auxNum, at: CGPoint(x: startX + (1.5 * CGFloat(brick) * 55.0), y: startY))
            auxNum += 1
        }

        startY -= 50.0
        auxNum = 1
        for brick in 0 ... 7 {
            self.addBrick(3, auxNum, at: CGPoint(x: startX + (1.5 * CGFloat(brick) * 55.0), y: startY))
            auxNum += 1
        }

        startY -= 50.0
        auxNum = 1
        for brick in 0 ... 7 {
            self.addBrick(2, auxNum, at: CGPoint(x: startX + (1.5 * CGFloat(brick) * 55.0), y: startY))
            auxNum += 1
        }

        startY -= 50.0
        auxNum = 1
        for brick in 0 ... 7 {
            self.addBrick(1, auxNum, at: CGPoint(x: startX + (1.5 * CGFloat(brick) * 55.0), y: startY))
            auxNum += 1
        }
    }

    private func addBrick(_ number: Int, _ secondNumber: Int, at position: CGPoint) {
        let brick = SKSpriteNode(imageNamed: "Brick\(number)")
        brick.position = position
        brick.zPosition = 1
        brick.size = CGSize(width: 75, height: 25)
        brick.name = "brick\(secondNumber)\(number)"
        brick.physicsBody = SKPhysicsBody(texture: brick.texture!, size: brick.size)
        brick.physicsBody?.allowsRotation = false
        brick.physicsBody?.affectedByGravity = false
        brick.physicsBody?.isDynamic = false
        brick.physicsBody?.restitution = 1.0
        brick.physicsBody?.friction = 0.0
        brick.physicsBody?.linearDamping = 0.0
        brick.physicsBody?.categoryBitMask = 0x0000_0010
        self.addChild(brick)
    }

    func addScoreLabels() {
        self.scoreTitleLabel = SKLabelNode(text: "SCORE")
        self.scoreTitleLabel.fontName = "iomanoid"
        self.scoreTitleLabel.fontColor = UIColor.red
        self.scoreTitleLabel.position = CGPoint(x: (-(self.size.width / 2) + 150), y: (self.size.height / 2) - 25)
        self.scoreTitleLabel.zPosition = 1
        self.addChild(self.scoreTitleLabel)

        self.scoreLabel = SKLabelNode(text: "\(self.currentScore)")
        self.scoreLabel.fontName = "iomanoid"
        self.scoreLabel.fontColor = UIColor.white
        self.scoreLabel.position = CGPoint(x: (-(self.size.width / 2) + 150), y: (self.size.height / 2) - 75)
        self.scoreLabel.zPosition = 1
        self.addChild(self.scoreLabel)
    }

    func addLifesLabels() {
        self.lifesTitleLabel = SKLabelNode(text: "LIFES")
        self.lifesTitleLabel.fontName = "iomanoid"
        self.lifesTitleLabel.fontColor = UIColor.red
        self.lifesTitleLabel.position = CGPoint(x: 0, y: (self.size.height / 2) - 25)
        self.lifesTitleLabel.zPosition = 1
        self.addChild(self.lifesTitleLabel)

        self.lifesLabel = SKLabelNode(text: "\(self.currentLifes)")
        self.lifesLabel.fontName = "iomanoid"
        self.lifesLabel.fontColor = UIColor.white
        self.lifesLabel.position = CGPoint(x: 0, y: (self.size.height / 2) - 75)
        self.lifesLabel.zPosition = 1
        self.addChild(self.lifesLabel)
    }

    func addHighScoreLabels() {
        self.highScoreTitleLabel = SKLabelNode(text: "HIGH SCORE")
        self.highScoreTitleLabel.fontName = "iomanoid"
        self.highScoreTitleLabel.fontColor = UIColor.red
        self.highScoreTitleLabel.position = CGPoint(x: ((self.size.width / 2) - 150), y: (self.size.height / 2) - 25)
        self.highScoreTitleLabel.zPosition = 1
        self.addChild(self.highScoreTitleLabel)

        if let highScore = UserDefaults.standard.value(forKey: self.highScoreKey) as? Int {
            self.highScoreLabel = SKLabelNode(text: "\(highScore)")
            self.currentHighScore = highScore
        } else {
            self.highScoreLabel = SKLabelNode(text: "\(self.currentHighScore)")
        }
        self.highScoreLabel.fontName = "iomanoid"
        self.highScoreLabel.fontColor = UIColor.white
        self.highScoreLabel.position = CGPoint(x: ((self.size.width / 2) - 150), y: (self.size.height / 2) - 75)
        self.highScoreLabel.zPosition = 1
        self.addChild(highScoreLabel)
    }

    func addBottom() {
        self.bottom = SKSpriteNode(imageNamed: "")
        self.bottom.name = "bottom"
        self.bottom.position  = CGPoint(x: 0, y: -(self.size.height / 2) - 50)
        self.bottom.zPosition = 1
        self.bottom.size = CGSize(width: self.size.width, height: 25)
        self.addChild(self.bottom)
        sizeW = self.bottom.size.width
        sizeH = self.bottom.size.height
        self.bottom.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.bottom.physicsBody?.allowsRotation = false
        self.bottom.physicsBody?.affectedByGravity = false
        self.bottom.physicsBody?.isDynamic = false
        self.bottom.physicsBody?.restitution = 1.0
        self.bottom.physicsBody?.friction = 0.0
        self.bottom.physicsBody?.linearDamping = 0.0
        self.bottom.physicsBody?.categoryBitMask = 0x0000_1000
    }

    func addBigBallPU(_ brickPosition: CGPoint) {
        self.bigBallPU = SKSpriteNode(imageNamed: "GreenPowerUp")
        self.bigBallPU.name = "PUbigBall"
        self.bigBallPU.position  = brickPosition
        self.bigBallPU.zPosition = 1
        self.bigBallPU.size = CGSize(width: 75, height: 25)
        self.addChild(self.bigBallPU)
        sizeW = self.bigBallPU.size.width
        sizeH = self.bigBallPU.size.height
        self.bigBallPU.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.bigBallPU.physicsBody?.allowsRotation = false
        self.bigBallPU.physicsBody?.affectedByGravity = false
        self.bigBallPU.physicsBody?.velocity = CGVector(dx: 0, dy: -400)
        self.bigBallPU.physicsBody?.linearDamping = 0.0
        self.bigBallPU.physicsBody?.contactTestBitMask = 0x0001_1000
        self.bigBallPU.physicsBody?.collisionBitMask = 0x0001_1000
        self.bigBallPU.physicsBody?.categoryBitMask = 0x0010_0000
    }

    func addLongBarPU(_ brickPosition: CGPoint) {
        self.longBarPU = SKSpriteNode(imageNamed: "BluePowerUp")
        self.longBarPU.name = "PUlongBar"
        self.longBarPU.position  = brickPosition
        self.longBarPU.zPosition = 1
        self.longBarPU.size = CGSize(width: 75, height: 25)
        self.addChild(self.longBarPU)
        sizeW = self.longBarPU.size.width
        sizeH = self.longBarPU.size.height
        self.longBarPU.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.longBarPU.physicsBody?.allowsRotation = false
        self.longBarPU.physicsBody?.affectedByGravity = false
        self.longBarPU.physicsBody?.velocity = CGVector(dx: 0, dy: -400)
        self.longBarPU.physicsBody?.linearDamping = 0.0
        self.longBarPU.physicsBody?.contactTestBitMask = 0x0001_1000
        self.longBarPU.physicsBody?.collisionBitMask = 0x0001_1000
        self.longBarPU.physicsBody?.categoryBitMask = 0x0010_0000
    }

    func addLifePU(_ brickPosition: CGPoint) {
        self.lifePU = SKSpriteNode(imageNamed: "YellowPowerUp")
        self.lifePU.name = "PUlife"
        self.lifePU.position  = brickPosition
        self.lifePU.zPosition = 1
        self.lifePU.size = CGSize(width: 75, height: 25)
        self.addChild(self.lifePU)
        sizeW = self.lifePU.size.width
        sizeH = self.lifePU.size.height
        self.lifePU.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.lifePU.physicsBody?.allowsRotation = false
        self.lifePU.physicsBody?.affectedByGravity = false
        self.lifePU.physicsBody?.velocity = CGVector(dx: 0, dy: -400)
        self.lifePU.physicsBody?.linearDamping = 0.0
        self.lifePU.physicsBody?.contactTestBitMask = 0x0001_1000
        self.lifePU.physicsBody?.collisionBitMask = 0x0001_1000
        self.lifePU.physicsBody?.categoryBitMask = 0x0010_0000
    }

    func addTiltMovementPU(_ brickPosition: CGPoint) {
        self.tiltMovementPU = SKSpriteNode(imageNamed: "RedPowerUp")
        self.tiltMovementPU.name = "PUtiltMovement"
        self.tiltMovementPU.position  = brickPosition
        self.tiltMovementPU.zPosition = 1
        self.tiltMovementPU.size = CGSize(width: 75, height: 25)
        self.addChild(self.tiltMovementPU)
        sizeW = self.tiltMovementPU.size.width
        sizeH = self.tiltMovementPU.size.height
        self.tiltMovementPU.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.tiltMovementPU.physicsBody?.allowsRotation = false
        self.tiltMovementPU.physicsBody?.affectedByGravity = false
        self.tiltMovementPU.physicsBody?.velocity = CGVector(dx: 0, dy: -400)
        self.tiltMovementPU.physicsBody?.linearDamping = 0.0
        self.tiltMovementPU.physicsBody?.contactTestBitMask = 0x0001_1000
        self.tiltMovementPU.physicsBody?.collisionBitMask = 0x0001_1000
        self.tiltMovementPU.physicsBody?.categoryBitMask = 0x0010_0000
    }

    func addReverseMovementPU(_ brickPosition: CGPoint) {
        self.reverseMovementPU = SKSpriteNode(imageNamed: "OrangePowerUp")
        self.reverseMovementPU.name = "PUreverseMovement"
        self.reverseMovementPU.position  = brickPosition
        self.reverseMovementPU.zPosition = 1
        self.reverseMovementPU.size = CGSize(width: 75, height: 25)
        self.addChild(self.reverseMovementPU)
        sizeW = self.reverseMovementPU.size.width
        sizeH = self.reverseMovementPU.size.height
        self.reverseMovementPU .physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.reverseMovementPU.physicsBody?.allowsRotation = false
        self.reverseMovementPU.physicsBody?.affectedByGravity = false
        self.reverseMovementPU.physicsBody?.velocity = CGVector(dx: 0, dy: -400)
        self.reverseMovementPU.physicsBody?.linearDamping = 0.0
        self.reverseMovementPU.physicsBody?.contactTestBitMask = 0x0001_1000
        self.reverseMovementPU.physicsBody?.collisionBitMask = 0x0001_1000
        self.reverseMovementPU.physicsBody?.categoryBitMask = 0x0010_0000
    }

    /*func aux() {
        self.tiltMovementPU = SKSpriteNode(imageNamed: "BluePowerUp")
        self.tiltMovementPU.name = "PUlongBar"
        self.tiltMovementPU.position  = CGPoint(x: 0, y: self.size.width / 2 - 150)
        self.tiltMovementPU.zPosition = 1
        self.tiltMovementPU.size = CGSize(width: 75, height: 25)
        self.addChild(self.tiltMovementPU)
        sizeW = self.tiltMovementPU.size.width
        sizeH = self.tiltMovementPU.size.height
        self.tiltMovementPU.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: sizeW, height: sizeH))
        self.tiltMovementPU.physicsBody?.allowsRotation = false
        self.tiltMovementPU.physicsBody?.affectedByGravity = false
        self.tiltMovementPU.physicsBody?.velocity = CGVector(dx: 0, dy: -400)
        self.tiltMovementPU.physicsBody?.linearDamping = 0.0
        self.tiltMovementPU.physicsBody?.contactTestBitMask = 0x0001_1000
        self.tiltMovementPU.physicsBody?.collisionBitMask = 0x0001_1000
        self.tiltMovementPU.physicsBody?.categoryBitMask = 0x0010_0000
    }*/
}
