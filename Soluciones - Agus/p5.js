//Ejercicio 1
//a
cli = {
        r: 1,
        i: 1        
      }

//b
cli.sumar = function (nc){this.r = this.r + nc.r,
                          this.i = this.i + nc.i}

//c      
cli.sumar = function (nc){return {r: this.r + nc.r,
                                  i: this.i + nc.i}}
      
//d
//cli.sumar(cli).sumar(cli) -> indefinido

cli = {
    r: 0,
    i: 0,
    sumar: function (nc){return {r: this.r + nc.r,
                                 i: this.i + nc.i,
                                 sumar: this.sumar}}
  }

//e
let c = cli.sumar(cli)
c.restar = function (nc) {return {r: this.r - nc.r,
                                  i: this.i - nc.i}}
//cli.restar(c) -> indefinido

//f
cli.mostrar = function(){return this.r + ' + ' + this.i + 'i'}

//c.mostrar -> indefinido

//Ejercicio 2
//a

t = {ite: function(a, b){return a}}
f = {ite: function(a, b){return b}}

//b

t.mostrar = function(){return "Verdadero"}
f.mostrar = function(){return "Falso"}

//c
t.not = function(){return f}
f.not = function(){return t}

t.and = function(a){return a}
f.and = function(a){return this}

//Ejercicio 3
//a

cero = {
  esCero: true,
  succ: function(){
    return {
      esCero: false,
      succ: this.succ,
      pred: this
    }
  }
}

//b

cero = {
  esCero: true,
  succ: function(){
    return {
      esCero: false,
      succ: this.succ,
      pred: this,
      toNumber: this.toNumber + 1
    }
  },
  toNumber: 0
}

//c

cero = {
  esCero: true,
  succ: function(){
    return {
      esCero: false,
      succ: this.succ,
      pred: this,
      toNumber: this.toNumber + 1,
      for: function(o){
        this.pred.for(o)
        o.eval(this)        
      }
    }
  },
  toNumber: 0
}

cero.for = function(o){}

//4
//a
{
let Punto = {
  new: function(x,y){
    return {
      x: x,
      y: y,
      mostrar: function(){return Punto.mostrar(this.x, this.y)}
      }
    },
  mostrar: function(x, y){
    return "Punto(" + x + " ," + y + ")"
  }
}
let p = Punto.new(1 ,2);
console.log(p.mostrar());
Punto.mostrar = function(){ return " unPunto "};
console.log(p.mostrar());
}
//b
{
let PuntoColoreado = {
  new:  function(x,y){
    nuevoPunto = Punto.new(x,y)
    nuevoPunto.color = "rojo"
    return nuevoPunto
  }
}
let p = PuntoColoreado . new (1 ,2) ;
console .log(p. mostrar () ) ;
Punto . mostrar = function () { return " UnPunto "};
console .log(p. mostrar () ) ;
PuntoColoreado . mostrar = function () { return " UnPuntoColoreado "};
console .log(p. mostrar () ) ;
}

//c

PuntoColoreado.newWithColor = function(x, y, color) {
  nuevoPunto = this.new(x,y)
  nuevoPunto.color = color
  return nuevoPunto
}

//d NO SE HACERLO
let p1 = Punto . new (1 ,2) ;
let pc1 = PuntoColoreado . new (1 ,2) ;
Punto.moverI = function(u) {this.x = this.x + u} //Extensión de Punto para agregar moverX
let p2 = Punto . new (1 ,2) ;
let pc2 = PuntoColoreado . new (1 ,2) ;


//5
//a
{
  function Punto(x,y){
    this.x = x,
    this.y = y,
    this.mostrar = function(){
      return "Punto(" + this.x + " ," + this.y + ")"
    }
  }
  let p = new Punto(1 ,2);
  console.log(p.mostrar());
  Punto.mostrar = function(){ return " unPunto "}; //Esto no anda y no se por qué
  console.log(p.mostrar());
}

//7
//a
//Se mostrará 'Hola Mundo' ya que al crear c se toma la referencia al objeto almacenado en a
//Y luego en a se guarda la referencia al objeto guardado en b 
//(CHEQUEAR)

//b 
//Se mostrará 'Hola Hola'
//Se mostrará 'Hola Mundo' porque cambia el prototipo de a y pasa de ser C2 a C1


//8
//a Da 2 porque create toma o1 como referencia
//b Da 3 porque comparten el mismo prototipo Object