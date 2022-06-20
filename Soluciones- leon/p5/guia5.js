//Escriban acá su código.
//Ej 2
  let t = {};
  let f = {};
  //a
    t.ite = function(a,_){return a};
    f.ite = function(_,b){return b};
  //b
    t.mostrar = () => ("Verdadero");
    f.mostrar = () => ("Falso");
  //c
    t.not = () => (f);
    f.not = () => (t);

    t.and = (vf) => (vf);
    f.and = (_) => (f);

//Ej3
  //a
    function Numero () {
      this.esCero = ()=>(true);
      this.succ = function(){
        let nuevo = Object.create(this);
        let viejo = this;
        nuevo.esCero = ()=>(false);
        nuevo.pred = ()=>(viejo);

        return nuevo;
      };
    };
  //b
    Numero.prototype.toNumber = function(){
      let res = 0;
      let numero = this;
      while (!numero.esCero()){
        res += 1;
        numero = numero.pred();
      }
      return res;
    }
  //c
    Numero.prototype.for = function(f){
      let numero = this;
      let paraEvaluar = [];
      paraEvaluar.push(numero);

      while( !numero.esCero() ){
        numero = numero.pred();
        paraEvaluar.push(numero);
      }

      for ( let i = paraEvaluar.length - 1; i>=0; i-=1 ){
        f.eval(paraEvaluar[i]);
      }
    }

    let numerizador = { eval : function( i ){ console.log( i.toNumber() )}};

//Ej 5
    //a
    function Punto(a,b){
      this.x = a;
      thix.y = b;
      this.mostrar = function(){
        return "Punto: ("+this.x+","+this.y+")";
      };

    }
    //b
    Punto.prototype.colorear = function(){
      this.color = "rojo";
      this.mostrar = function(){
        return `PuntoColoreado: (${this.x},${this.y}) ${this.color}`
      };
      return this;
    }
    //c
    function PuntoColoreado(x,y,color){
      Punto.call(this,x,y);
      this.color = color;
      this.mostrar = function(){
        return `PuntoColoreado: (${this.x},${this.y}) ${this.color}`
      };
    }
  
  //Ej 7
    //a
      //como se igualó a=b, ahora a tiene el mensaje g = "Hola", y como C está creado a partir del a viejo, cambiar el a no lo afecta. Con lo que se imprime "Hola Mundo"
    //b
      //Cambiarlo desde C1.prototype.g si cambia a y c, ya que se cambia el prototypo desde el cual referencian g
      //Hacer que a prototype a b tiene un efecto parecido ya que ahora si estamos cambiando el objeto al que hace referencia c.
  
  //Ej 8
    //El primero imprime 2, ya que el prototypo de o2 es Object, el mimso que o1
    //Lo mismo en el segundo caso, se imprime 3


function calcularResultado(){
//Editen esta función para que devuelva lo que quieran ver. Pueden escribir acá sus tests, y descomentar las líneas que siguen para correr los tests predefinidos.
  let res = "";
  
  //res +="<br />"+(new Anillo(1)).agregar(2).siguiente.anterior;//undefined
  //ej2
  res += "<br />"+t.ite("hoy", "mañana"); //hoy
  res += "<br />"+f.ite("hoy", "mañana"); //mañana
  res += "<br />"+t.mostrar()+" y " +f.mostrar();//Verdadero y Falso
  res += "<br />"+t.not().mostrar()+" y "+f.not().and(t).mostrar();//Falso y Verdadero

  //ej3
  res += "<br />"+(new Numero()).esCero(); //true
  res += "<br />"+(new Numero()).succ().esCero();//false
  res += "<br />"+(new Numero()).toNumber(); //0
  res += "<br />"+(new Numero()).succ().succ().succ().succ().succ().toNumber(); //5
  res += "<br />"+(new Numero()).succ().succ().succ().succ().for(numerizador); //undefined pero en la consola 0 1 2 3 4

  return res;
}
