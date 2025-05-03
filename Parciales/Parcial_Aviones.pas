{Una empresa de venta de pasajes aaereos esta analaziando la informacion de los viajes realizados por sus aviones. 
Para ellos se dispone de una estructura de datos con la informacion de todos los viajes. 
De cada viaje se conoce codigo del avion (entre 1000 y 2500), el año en que se realizo el viaje, la cantidad de pasajeros que viajaron, y la ciudad destino. 
La informacion no se encuentra ordenada por ningun criterio.
  
Ademas, la empresa dispone de una estructura de datos con informacion sobre la capacidad maxima de cada avion.

Realizar un programa que procese la informacion de los viajes e:

A) Informe el codigo del avion que realizo la mayor cantidad de viajes.
B) Genere una lista con los viajes realizados en años multiplos de 10 con destino "Punta Cana" en los que el avion no alcanzo su capacidad maxima.
C) COMPLETO: Para cada avion, informe el promedio de pasajeros que viajaron entre todos sus viajes.}

program parcialAviones;
type
  codigo = 1000..2500;
  viaje = record
    cod: codigo;
    año:integer;
    cantp:integer;
    dest:string;
  end;
  lista = ^nodo;
  nodo = record
    dato:viaje;
    sig:lista;
  end;
  vPasajeros = array [codigo] of integer; {vector con capacidad maxima por avion}
  vCodigo = array [codigo] of integer; {vector contador de viajes por codigo de avion}
  
procedure capacidadMaxima (var vP:vPasajeros); // SE DISPONE

procedure cargarLista (var l:lista);

procedure inicializoVector (var vC:vCodigo);
var
  i:codigo;
begin
  for i:= 1000 to 2500 do
    vCod:= 0;
end;

function cumple (vi:viaje; cap:vPasajero) : boolean; 
begin
  cumple:= ((vi.año MOD 10) = 0) and (vi.dest = 'Punta Cana') and (vi.cantp <= cap));
end;

procedure agregarAtras (var pri, ult:lista; vi:viaje); {punto B}
var
  nue: lista;
begin
  new (nue);
  nue^.dato:= vi;
  nue^.sig:= nil;
  if (pri = nil) then
    pri:= nue
  else
    ult^.sig:= nue;
  ult:= nue;
end;

procedure recorrerLista (l:lista; var vC:vCodigo; vP:vPasajeros; var lnueva:lista, lnuevaUlt: lista, var vectorCantPasajeros: vcp)
var
  pri, ult: lista; 
begin
  while (l <> nil) do begin
 { A) Informe el codigo del avion que realizo la mayor cantidad de viajes.}
    vC[l^.dato.cod]:= vC[l^.dato.cod] + 1; {contabiliza los viajes por codigo de avion}
    
    {B) Genere una lista con los viajes realizados en años multiplos de 10 con destino "Punta Cana" en los que el avion no alcanzo su capacidad maxima.}
    if (cumple(l^.dato, vP[l^.dato.cod])) then 
      agregarAtras (lnueva, lnuevaUlt, l^.dato); {agrega en la nueva lista si cumplen la condicion}
      
    {C) COMPLETO: Para cada avion, informe el promedio de pasajeros que viajaron entre todos sus viajes.}
    vectorCantPasajeros[l^.dato.cod]:=vectorCantPasajeros[l^.dato.cod] + l^.dato.cantp;
      
    l:= l^.sig;
  end;
  
end;
    
function maximo (vC: vCodigo) : integer; {va a devolver mi codigo maximo}
var
  max, cod:integer;
  i:codigo;
begin
  max:= -1;
  for i:= 1000 to 2500 do
    if (vC[i] > max) then begin
      max:= vC[i];
      cod:= i;
    end;
end;


 { PROG PRINCIPAL }
var
  l:lista;
  lnueva, lnuevaUlt:  lista;
  codMax:integer;
  vC:vCodigo;
  vP:vPasajeros;
begin
  l:= nil;
  lnueva:= nil;
  lnuevaUlt: = nil;
  capacidadMaxima (vP); {se dispone}
  cargarLista (l); {se dispone}
  inicializoVector (vC);
  recorrerLista (l, vC, vP, lnueva, lnuevaUlt, vectorCantPasajeros);
  
      {C) COMPLETO: Para cada avion, informe el promedio de pasajeros que viajaron entre todos sus viajes.}
    for( i:= 1000 to 2500)do 
        write('el promedio de pasajeros del avion ', i, 'es ', vectorCantPasajeros[i]/ vC[i]);
  
  
  writeln ('El codigo del avion con mas viajes es: ',maximo(vC)); {punto A}
end.
