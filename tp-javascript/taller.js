//Escriban acá su código.


function calcularResultado(){
//Editen esta función para que devuelva lo que quieran ver. Pueden escribir acá sus tests, y descomentar las líneas que siguen para correr los tests predefinidos.
  let res = "";
  let anilloCero = {dato: 0};
  anilloCero.siguiente = anilloCero;
  //definimos una función auxiliar agegarA para crear un nuevo integrante al anillo a partir de otro
  function agregarA(anillo, n){
    let siguiente_viejo = anillo.siguiente;
    let siguiente_nuevo = Object.create(anillo)

    anillo.siguiente = siguiente_nuevo
    siguiente_nuevo.dato = n
    siguiente_nuevo.siguiente = siguiente_viejo

    return anillo;
  }
  anilloCero.agregar = function(m){return agregarA(this, m)}

  //ej2, definimos el toString
  anilloCero.toString = function(){
    let str = ""
    str += this.dato
    let sig = this.siguiente
    while(sig !== this){
      str += ` ↝ ${sig.dato}`
      sig = sig.siguiente
    }
    return str
  }

  //ej3, definimos la función constructora Anillo, copia el toString del anilloCero
  function Anillo(d){
    this.toString = anilloCero.toString
    this.agregar = function(n){return agregarA(this,n)}
    this.dato = d
    this.siguiente = this
  }


  //ej4, definimos map, copiar y cant
  //map itera sobre los siguientes hasta dar una vuelta
  Anillo.prototype.map = function(f){
    this.dato = f(this.dato)
    let sig = this.siguiente
    while(sig !== this){
      sig.dato = f(sig.dato)
      sig = sig.siguiente
    }
    return this
  }

  //copiar itera de la misma forma y va agregando al siguiente del anillo nuevo (girando el anillo)
  Anillo.prototype.copiar = function(){
    let anilloNuevo = new Anillo(this.dato)
    let sig = this.siguiente

    while(sig !== this){
      anilloNuevo = anilloNuevo.agregar(sig.dato)

      sig = sig.siguiente
      anilloNuevo = anilloNuevo.siguiente
    }

    return anilloNuevo.siguiente    
  }

  //cantidad itera por el anillo y cuenta cada iteración
  Anillo.prototype.cantidad = function(){
    let cant = 1
    let sig = this.siguiente
    while(sig !== this){
      cant += 1
      sig = sig.siguiente
    }
    return cant
  }

  //ej5
  //definimos agregarBi para reemplazar el agregarA. El nuevo define anteriores ademas del anillo nuevo
  function agregarBi(anillo, n){
    let sig = anillo.siguiente

    let nuevo_sig = Object.create(anillo)
    nuevo_sig.dato = n
    nuevo_sig.siguiente = sig
    nuevo_sig.anterior = anillo

    sig.anterior = nuevo_sig
    anillo.siguiente = nuevo_sig
    return anillo
  }

  //poner anteriores itera sobre los siguientes, cambiando agregar y definiendo el anterior del siguiente.
  Anillo.prototype.ponerAnteriores = function(){
    
    let ant = this
    let sig = this.siguiente
    while(sig !== this){
      sig.agregar = function(n){return agregarBi(this, n)}
      sig.anterior = ant

      ant = sig
      sig = sig.siguiente
      
    }

    sig.agregar = function(n){return agregarBi(sig, n)}
    sig.anterior = ant

    return sig
  }

  let anilloUno = {dato : 1}
  Object.setPrototypeOf(anilloUno,anilloCero);
  anilloUno.siguiente = anilloUno;
  res += anilloUno.agregar(3).agregar(2)+"<br />"+anilloUno.siguiente; //1 ↝ 2 ↝ 3<br />2 ↝ 3 ↝ 1
  res +="<br />"+(new Anillo(0)).agregar(2).agregar(1)+"<br />"+anilloCero.siguiente; //0 ↝ 1 ↝ 2<br />0
  res +="<br />"+(new Anillo(0)).agregar(2).agregar(1).map(e => e+1);//1 ↝ 2 ↝ 3
  res +="<br />"+(new Anillo(0)).agregar(1).map(e => e+4);//4 ↝ 5
  res +="<br />"+(new Anillo(1)).map(e => e*2);//2
  let anilloDos = new Anillo(2).agregar(2);
  let anilloCopia = anilloDos.copiar();
  anilloDos.agregar(2);
  anilloCopia.agregar(1);
  res +="<br />"+anilloDos;//2 ↝ 2 ↝ 2
  res +="<br />"+anilloCopia;//2 ↝ 1 ↝ 2
  res +="<br />"+anilloCopia;//2 ↝ 1 ↝ 2
  res +="<br />"+anilloDos.cantidad();//3
  res +="<br />"+new Anillo(0).agregar(3).agregar(2).ponerAnteriores().agregar(1).siguiente.anterior;//0 ↝ 1 ↝ 2 ↝ 3
  let anilloLetras = (new Anillo("a")).agregar("d").agregar("c");
  anilloLetras.siguiente.ponerAnteriores();
  anilloLetras.agregar("b");
  res +="<br />"+anilloLetras.siguiente.anterior.dato;//a 
  anilloLetras.anterior.agregar("e");
  res +="<br />"+anilloLetras;//a ↝ b ↝ c ↝ d ↝ e
  res +="<br />"+anilloDos.agregar(2).siguiente.anterior;//undefined
  res +="<br />"+(new Anillo(1)).agregar(2).siguiente.anterior;//undefined
  return res;
}
