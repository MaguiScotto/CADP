//1) 
program febrero2025;
type 
	inmueble = record
		dire:string;
		hab:integer;
		cod:integer;
	end;	
	lista =^nodo;
	nodo = record
		dato:inmueble;
		sig:lista;
	end;

procedure leerInmueble (var inm:inmueble);
begin
	readln(inm.dire);
	if (inm.dire <> 'ZZZ')then begin
		readln(inm.hab);
		readln(inm.cod);
	end;
end;

function pares (cod:integer) : boolean;
var
	dig,par,impar:integer;
	ok:boolean;
begin
	ok:= false;
	par:= 0;
	impar:= 0;
	while (cod <> 0) do begin
		dig:= cod MOD 10; //agarro ultimo num
		if (dig MOD 2 = 0) then
			par:= par + 1
		else
			impar:= impar + 1;
		cod:= cod DIV 10; //achico num
	end;
	if (par >= impar) then
		ok:= true;
	pares:= ok;
end;

procedure agregarAdelante (var l,ult:lista; inm:inmueble);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:= inm;
	nue^.sig:= l;
	if (l = nil) then
		ult:= nue;
	l:= nue;
end;

procedure agregarAtras(var l,ult:lista; inm:inmueble);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:= inm;
	nue^.sig:= nil;
	if (l = nil) then
		l:= nue
	else
		ult^.sig:= nue;
	ult:= nue;
end;


procedure cargarLista (var l:lista);
var
	inm:inmueble;
	cant:integer;
	ult:lista;
begin
	cant:= 0;
	leerInmueble(inm);
	while (cant <> 50) and (inm.dire <> 'ZZZ') do begin
		if (pares(inm.cod)) then
			agregarAdelante(l,ult,inm)
		else
			agrearAtras(l,ult,inm);
		cant:= cant + 1;
		leerInmueble(inm);
	end;
end;	
 {PROGRAMA PRINCIPAL}
var 
	l:lista;

BEGIN
	l:= nil;
	cargarLista(l);
END.

{2) 17 9 30
   4 9 17

3) El proceso A no es correcto, debido a que cuenta con los siguientes errores:
while (l^.sig <> nil) then begin --> aquí encontramos 2 errores, la condición debe ser (l<>nil), ya que la actual no contempla el ultimo nodo. El segundo error es THEN, cuando debería ser DO.
Por ultimo, no existe l^.dato con doble o, el campo correcto es dato, por lo que no se estaría modificando dicho nodo.

El proceso B, posee un único error que es también la equivocación al poner THEN, el cual pertenece al if, por lo tanto se debe reemplazar por un DO. 


4) a) Falso. No siempre será mas eficiente la búsqueda de un elemento en una lista ordenada, dedo que si el elemento se encuentra al final de la lista, deberé recorrerla toda. Mientras que en el caso del arreglo, cuenta con la búsqueda binaria, permitiéndome "descartar" varias posiciones del vector sin necesidad de recorrerlas, agilizando así dicha búsqueda. 

b) Falso. No es correcto usar un repeat until, ya que primero imprimiría y luego consultaría si cumple ser una posición valida, por lo que si mi dimL es 0, estaría imprimiendo basura, al igual que una vez llegado a la ultima posición de la dimL. Lo correcto seria usar un while en su lugar. 

c) Verdadero. El case permite realizar distintas acciones en base a variables de tipo ordinal y todas las variables simples vistas en esta cursada, son a su vez de tipo ordinal.

d) Falso. El resultado real es 263bytes.

e) Falso. El resultado correcto es 63 UT.
}
