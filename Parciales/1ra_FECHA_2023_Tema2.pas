{1ra FECHA 2023 Tema 2:
Un teatro esta analizando la informacion de los tickets vendidos durante el año 2022. Para ello, se dispone de una estructura de datos 
con la informacion de todos los tickets vendidos. De cada ticket se conoce el codigo del evento, dni del comprador, mes de la funcion
(entre 1 y 12) y ubicacion (1:palco, 2:pullman, 3:platea alta, 4:platea baja). La informacion se encuentra ordenada por codigo de evento.
 
 Ademas la empresa dispone de una estructura de datos con informacion del costo del ticket por ubicacion.

 Realizar un programa que procese la informacion de los viajes y:
A) Genere una lista que tenga por cada codigo de evento, la cantidad de tickets vendidos.
B) Informe el mes con mayor monto recaudado.
C) COMPLETO: Informe el promedio recaudado por cada evento entre todos sus tickets.}
program parcialT2; // CORREGIDO POR LA PROFE
Type
  meses = 1..12;
  ubicacion = 1..4;
  ticket = record
    cod:integer;
    dni:integer;
    mes:meses;
    ubi:ubicacion;
  end;
  lista = ^nodo;
  nodo = record
    dato:ticket;
    sig:lista;
  end;
  vCosto = array [ubicacion] of real;
  vMes = array [meses] of real;
  vendido = record
    cod:integer;
    cant:integer;
  end;
  lista2 = ^nodo2;
  nodo2 = record
    dato:vendido;
    sig:lista2;
  end;

procedure cargarLista (var l:lista); { SE DISPONE }

procedure costoTicket (var vC:vCosto); { SE DISPONE }

procedure inicializoVector (var vM:vMes);
var
  i:meses;
begin
  for i:= 1 to 12 do 
    vM[i]:= 0;
end;

procedure agregarAtras (var l2, ult:lista2; ven:vendido); 
var
  nue:lista2;
begin
  new (nue);
  nue^.dato:= ven;
  nue^.sig:= nil;
  if (l2 = nil) then 
    l2:= nue 
  else 
    ult^.sig:=nue;  
  ult:=nue;      
end;

function promedio (cant:integer; monto:real) : real;
begin
  promedio:= monto/cant;
end;

procedure recorrerLista (l:lista; var vM:vMes; vC:vCosto); 
var
  cantTick, auxCod:integer;
  l2, ult:lista2;
  montoTot:real; 
  ven:vendido;
begin
  l2:= nil;
  while (l <> nil) do begin
    cantTick:= 0;
    montoTot:= 0;
    auxCod:= l^.dato.cod;
    while ((l <> nil) and (auxCod = l^.dato.cod)) do begin
      cantTick:= cantTick + 1; {contabilizo el total de ventas por codigo}
      vM[l^.dato.mes]:= vM[l^.dato.mes] + vC[l^.dato.ubi]; {contabilizo el monto de cada mes} 
      montoTot:= montoTot + vC[l^.dato.ubi]; {contabilizo el monto de cada cod de evento}
      l:= l^.sig;
    end;
    ven.cant:= cantTick;
    ven.cod:= auxCod;
    agregarAtras (l2, ult, ven); {punto A}
    writeln ('El evento con codigo ', auxCod,' tiene un promedio recaudado de $', promedio(cantTick, montoTot):4:2); {punto C}
  end;
end;

function maximo (vM:vMes) : integer; {punto B}
var
  max:real;
  mes:integer;
  i:meses;
begin
  max:= -1;
  for i:= 1 to 12 do 
    if (vM[i] > max) then begin
      max:= vM[i];
      mes:= i;
    end;
  maximo:= mes;
end;
 
 { PROG PRINCIPAL }
var
  l:lista;
  vM: vMes;
  vC: vCosto;
begin
  l:=nil;
  costoTicket (vC);
  cargarLista (l);
  recorrerLista (l, vM, vC);
  writeln ('El mes con mayor monto es ', maximo(vM)); {punto B}
end.
