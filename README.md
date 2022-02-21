# love2d_love.physics_brickBreakerrExemple

### Comment ça marche dans love.physics dans LOVE2D ? 

love.physics utilise une librairie de simulation physique dans un monde en 2d.

Cette librairie se nomme : BOX 2D

pour utiliser cette librairie vous devez créer au moins deux éléments.

un monde et un objets avec un body.

## LE MONDE :
Le Monde regis les objets en leur indiquant des propriétés tels que la gravité X et Y (x le vent par exemple, y la gravité voir l'apesanteur si celui ci est positive)
C'est le monde qui  mets a jour les objets qu'il possede via : `monde:update(dt)`

## LES OBJETS :
chacun des éléments du jeu possède un Body, un Shape et une Fixture et peux aussi posséder des joints.

1- le Body est l'élément principale qui sert de référence a l'objet, il possède les propriétés de l'objet et sa position en un point défini a son centre (x,y) (a voir comme un cercle), c'est aussi lui a qui on insuffle des impulsion ou des forces pour les déplacements.
 le body possède un type de collider: static / dynamic / kinematic
static > ne bouges pas !
dynamic > bougent tout seul selon le monde et les impulsion / forces qu'il subit et les collisions qu'il subis egalement
kinematic > peut bouger mais seulement via une update de sa position. Généralement avec le code suivant :  `body:setPosition(x,y)`
 
2- les collision sont géré avec un Shape. Celui-ci est une forme géométrique soit : rectangle, cercle ou polygone.

3 - pour que le body et le shape soit liés ensemble on utilises les fixtures, c'est une liste qui dit que tels objets possèdent tels ou tels shapes (un body peut en posséder plusieurs)

les joints (généralement des points ) qui rassemblent plusieurs body entre eux (non utilisés dans l'exemple)... mais on peut facilement imaginer ceci avec un camion qui aurait une remorque attaché à celui-ci, quand la remorque collisionne > le camion subis aussi la collision via le joint !

![Rendu](https://i.gyazo.com/f8787c7d655a184027e3c06d7b6ef7f4.gif)

plus d'infos : [Love2d Physics](https://love2d.org/wiki/love.physics_(Fran%C3%A7ais))
