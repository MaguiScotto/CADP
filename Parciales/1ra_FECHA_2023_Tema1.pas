{1ra FECHA 2023 Tema 1:
Una empresa de venta de tickets de tren esta analizando la informacion de los viajes realizados por sus trenes durante el año 2022. 
Para ello, se dispone de una estructura de datos con la informacion de todos los viajes. De cada viaje se conoce el codigo de tren, 
el mes en que se realizo el viaje (entre 1 y 12), la cantidad de pasajeros que viajaron y el codigo de la ciudad de destino 
(entre 1 y 20). La informacion se encuentra ordenada por codigo de tren.
 
 Ademas, la empresa dispone de una estructura de datos con informacion del costo del ticket por ciudad destino.
 
 Realizar un programa que procese la informacion de los viajes y:
A) Genere una lista que tenga por cada codigo del tren, la cantidad de viajes realizados.
B) Informe el mes con mayor monto recaudado.
C) COMPLETO: Informe el promedio de pasajeros por cada tren entre todos sus viajes.}

program parcial2023T1;
type
  meses = 1..12;
  destino = 1..20;
  viaje = record
    cod:integer;
    mes:meses;
    pasaj:integer;
    dest:destino;
  end;
  lista = ^nodo;
  nodo = record
    dato:viaje;
    sig:lista;
  end;
  cantViaje = record
    cant:integer;
    cod:integer;
  end;
  lista2 = ^nodo2;
  nodo2 = record
    dato:cantViaje;
    sig:lista2;
  end;
  vecTick = array [destino] of real;
  vecMeses = array [meses] of real;
  
procedure costoTicket (var v:vecTick); // SE DISPONE

procedure leerViaje (var vi:viaje); // SE DISPONE

procedure insertarOrdenado (var l:lista; vi:viaje); // SE DISPONE

procedure cargarLista (var l:lista); // SE DISPONE

procedure inicializoVector (var vM:vecMeses);
var 
  i:meses;
begin
  for i:= 1 to 12 do
    vM[i]:= 0;
end;

procedure nuevaLista (var pri, ult:lista2; viTot, cod:integer);
var
  nue:lista2;
begin
  new (nue);
  nue^.dato.cant:= viTot; 
  nue^.dato.cod:= cod;
  nue^.sig:= nil;
  if (pri <> nil) then
    pri:= nue
  else
    ult^.sig:= pri;
  ult:= nue;
end;

function maximo (vM:vecMeses) : integer;
var
  i:meses;
  mesMax:integer;
  max:real;
begin
  max:= -1; 
  for i:= 1 to 12 do 
    if (vM[i] > max) then begin
      max:= vM[i];
      mesMax:= i;
    end;
  maximo:= mesMax;  
end;

function prom (vTot, pTot:integer) : real;
begin
  prom:= pTot/vTot;
end;

procedure recorrerLista (l:lista; var pri, ult:lista2; var vM:vecMeses; vT:vecTick);
var
  viTot, pasajTot, auxCod:integer;
begin
  while (l <> nil) do begin
    viTot := 0;
    pasajTot:= 0;
    auxCod:= l^.dato.cod;
    while ((l <> nil) and (auxCod = l^.dato.cod)) do begin
      viTot:= viTot + 1;
      pasajTot:= pasajTot + l^.dato.pasaj;
      vM[l^.dato.mes]:= vM[l^.dato.mes] + vT[l^.dato.dest];
      l:= l^.sig;
    end;
    nuevaLista (pri, ult, viTot, auxCod);
    writeln ('El tren con codigo ', auxCod,' tiene un promedio de ', prom(viTot,pasajTot):2:2,' pasajeros');
  end;
end;
    
  { PROG PRINCIPAL }
var
  l:lista;
  pri, ult:lista2;
  vMes:vecMeses;
  vTick: vecTick;
begin
  l:= nil;
  pri:= nil;
  costoTicket (vTick);
  cargarLista (l);
  inicializoVector (vMes);
  recorrerLista (l, pri, ult, vMes, vT);
  writeln ('El mes con mayor monto recaudado es el mes: ', maximo (vMes));
end.
