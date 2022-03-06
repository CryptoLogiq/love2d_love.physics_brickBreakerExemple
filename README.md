# love2d_love.physics_brickBreakerExemple

### Comment ça marche love.physics dans LOVE2D ? 

love.physics utilise une librairie de simulation physique dans un monde en 2d.

Cette librairie se nomme : BOX 2D

pour utiliser cette librairie vous devez créer au moins deux éléments.

un monde et un objet avec un body.

## LE MONDE :
Le Monde regis les objets en leur indiquant des propriétés tels que la gravité X et Y (x le vent par exemple, y la gravité voir l'apesanteur si celui ci est positive)
C'est le monde qui  mets a jour les objets qu'il possede via : `monde:update(dt)`

## LES OBJETS :
chacun des éléments du jeu possède un Body, un Shape et une Fixture et peux aussi posséder des joints.

1- le Body est l'élément principale qui sert de référence a l'objet, il possède les propriétés de l'objet et sa position en un point défini a son centre (x,y) (a voir comme un cercle), c'est aussi lui a qui on insuffle des impulsion ou des forces pour les déplacements.
 le body possède un type de collider: static / dynamic / kinematic.

-static : ne bouges pas !

-dynamic : bougent tout seul selon le monde et les impulsion / forces qu'il subit et les collisions qu'il subis egalement

-kinematic : peut bouger mais seulement via une update de sa position. Généralement avec le code suivant :  `body:setPosition(x,y)`
 
2- les collision sont géré avec un Shape. Celui-ci est une forme géométrique soit : rectangle, cercle ou polygone.

3 - pour que le body et le shape soit liés ensemble on utilises les fixtures, c'est une liste qui dit que tels objets possèdent tels ou tels shapes (un body peut en posséder plusieurs)

les joints (généralement des points ) qui rassemblent plusieurs body entre eux (non utilisés dans l'exemple)... mais on peut facilement imaginer ceci avec un camion qui aurait une remorque attaché à celui-ci, quand la remorque collisionne ALORS le camion subis aussi la collision via le joint !

## Explications Rapide du processus en 7 étapes :

1. creer le monde : 
```lua
 world = love.physics.newWorld(gravity_x, gravity_y, sleeping_bool)
```
2. creer un objet (ball par exemple) 
```lua
 ball={}
```
3. lui ajouter un body 
```lua
 ball.body = love.physics.newBody(world, x, y, collider_type) -- x,y is pos center of objet
 choix du colidder type : dynamic / kinematic / static
```
4. lui ajouter un shape 
```lua
-- choix entre : rectangle / cercle / polygon(vertices)
 ball.shape = love.physics.newCircleShape( rayon ) -- example cercle (parfait pour notre balle)
 ball.shape = love.physics.newRectangleShape( w, h) -- example rectangle
 ball.shape = love.physics.newPolygonShape( x1, y1, x2, y2, x3, y3, ... ) -- example polygon, on donne les vertices de nos points
```
5. on lie le body et le shape via une fixture 
```lua
 ball.fixture = love.physics.newFixture(brick.body, brick.shape)
```
6. on donne un update a notre objet (ball) pour controler ses collisions : 
```lua
 function ball:update(dt)
  if ball.body:isTouching(pad.body) then -- ball touche pad ?
    -- je fais quoi ?
  elseif ball.body:isTouching(wallTrigger.body) then -- ball touche le bas de l'ecran ?
    -- je fais quoi ?
  end
 end
```

7. notre main ressemble a ça
```lua

world = {}
ball = {}

function love.load()
 world = love.physics.newWorld(0, 200, true)
 --
 ball.body = love.physics.newBody(world, x, y, "dynamic")
 ball.shape = love.physics.newCircleShape( rayon )
 ball.fixture = love.physics.newFixture(brick.body, brick.shape)
end

function ball:update(dt)
  if ball.body:isTouching(pad.body) then -- ball touche pad ?
    -- je fais quoi ?
  elseif ball.body:isTouching(wallTrigger.body) then -- ball touche le bas de l'ecran ?
    -- je fais quoi ?
  end
end

function love.update(dt)
 world:update(dt)
 ball:update(dt)
end
```

## Rendu Final du pojet Complet :

1. en rose nos element **static** : les murs

2. en bleu un element **static** que j'utilise comme trigger : soit un mur que je mets dans une table pour pouvoir l'appeler dans l'update de la balle

-si collision avec la balle, je reset la position de la balle au dessus du pad

3. en vert **dynamic** : la balle, elle subit la gravité, et collisionne avec toutes les catégories de colliders
le pad et les briques sont en kinematic : la gravité ne s'applique pas

4. en blanc les elements **kinematic** : le pad et les bricks.
-- *Ps : si une brick est collisionné, elle passe alors en **dynamic** et je la sors du groupe de collision des autres objets*

![Rendu Complet](https://i.gyazo.com/f8787c7d655a184027e3c06d7b6ef7f4.gif)

-> plus d'infos sur le wiki de love2d : [Love2d Physics](https://love2d.org/wiki/love.physics_(Fran%C3%A7ais))
