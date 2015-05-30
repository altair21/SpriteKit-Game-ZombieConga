import SpriteKit

class GameScene: SKScene {
    let zombie = SKSpriteNode(imageNamed: "zombie1")
    var lastUpdateTime:NSTimeInterval = 0
    var dt: NSTimeInterval = 0
    let zombieMovePointsPerSec: CGFloat = 480.0
    var velocity = CGPointZero
    let playableRect: CGRect
    var lastTouchLocation: CGPoint?
    let zombieRotateRadiansPerSec: CGFloat = 4.0 * π
    
    override init(size: CGSize) {
        let maxAspectRatio: CGFloat = 16.0 / 9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height - playableHeight) / 2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        
        super.init(size:size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        let background = SKSpriteNode(imageNamed: "background1")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
//        background.zRotation = CGFloat(M_PI) / 8
        background.zPosition = -1
        addChild(background)
        
        zombie.position = CGPoint(x: 400, y: 400)
        addChild(zombie)
        
//        zombie.setScale(2.0)
//        debugDrawPlayableArea()
    }
    
    override func update(currentTime: NSTimeInterval) {
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        }   else {
            dt = 0
        }
        lastUpdateTime = currentTime
        println("\(dt*1000) milliseconds since last update")
        
        if let lastTouch = lastTouchLocation {
            let diff = lastTouch - zombie.position
            if (diff.length() <= zombieMovePointsPerSec * CGFloat(dt)) {
                zombie.position = lastTouchLocation!
                velocity = CGPointZero
            } else {
                moveSprite(zombie, velocity: velocity)
                rotateSprite(zombie, direction: velocity, rotateRadiansPerSec: zombieRotateRadiansPerSec)
            }
        }
        
        boundsCheckZombie()
        
    }
    
    func moveSprite(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = velocity * CGFloat(dt)
        println("Amout to move: \(amountToMove)")
        
        sprite.position += amountToMove
    }
    
    func moveZombieToward(location: CGPoint) {
        let offset = location - zombie.position
        velocity = offset.normalized() * zombieMovePointsPerSec
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        lastTouchLocation = touchLocation
        moveZombieToward(touchLocation)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let nsset = touches as NSSet
        let touch = nsset.anyObject() as! UITouch
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
    }
    
    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let nsset = touches as NSSet
        let touch = nsset.anyObject() as! UITouch
        let touchLocation = touch.locationInNode(self)
        sceneTouched(touchLocation)
    }
    
    func boundsCheckZombie() {
        let bottomLeft = CGPoint(x: 0, y: CGRectGetMinY(playableRect))
        let topRight = CGPoint(x: size.width, y: CGRectGetMaxY(playableRect))
        
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode()
        let path = CGPathCreateMutable()
        CGPathAddRect(path, nil, playableRect)
        shape.path = path
        shape.strokeColor = SKColor.redColor()
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
    func rotateSprite(sprite: SKSpriteNode, direction: CGPoint, rotateRadiansPerSec: CGFloat) {
        let shortest = shortestAngleBetween(sprite.zRotation, velocity.angle)
        let amountToRotate = min(rotateRadiansPerSec * CGFloat(dt), abs(shortest))
        sprite.zRotation += shortest.sign() * amountToRotate
    }
    
}


