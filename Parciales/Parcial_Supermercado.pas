{un supermercado necesita analizar la informacion de las compras realizadas el ultimo año 
para reponer stock.

a) realizar un modulo que cargue en una estructura de datos adecuada la informacion de las compras
de cada compra se conoce monto abonado, mes que se realizo, cantidad de productos
y nombre del proveedor. Por cada proveedor puede haber mas de una compra. la informacion
debe quedar ordenada por nombre de proveedor. La lectura finaliza cuando se ingresa
la compra de monto -1

B) Realizar un programa que utilice la informacion generada en el inciso a) e informe;

I- los nombres de los proveedores para los cuales el monto total facturado supero los 30000
II- los dos meses en los que se realizaron mayor cantidad de compras
III- el monto promedio de las compras realizadas durante el mes de julio}
program parcial1;
type
  meses = 1..12;
  compra = record
    monto:real; {monto abonado}
    mes: meses; {mes que se realizo}
    prod:integer; {cantidad de productos}
    nomb:string; {nombre del proveedor}
  end;
  lista = ^nodo;
  nodo = record
    info:compra;
    sig:lista;
  end;
  vector = array [meses] of integer;

procedure inicializoVector (var v:vector);
var
  i:meses;
begin
  for i:= 1 to 12 do
    v[i]:= 0;
end;
   
procedure leerCompra (var c:compra); {lee y carga cada campo del registro}
begin
  writeln ('monto abonado');
  readln (c.monto);
  if (c.monto <> -1) then begin
    writeln ('mes que se realizo');
    readln (c.mes);
    writeln ('cantidad de productos');
    readln (c.prod);
    writeln ('nombre de proveedor');
    readln (c.nomb);
  end;
end;

procedure insertarOrdenado (var l:lista; c:compra);
var
  nuevo, ant, act:lista;
begin
  new (nuevo);
  nuevo^.info:= c;
  act:= l;
  ant:= l;
  while ((act <> nil) and (c.nomb < act^.info.nomb)) do begin // POR QUE NO UN = ?
    ant:= act;
    act:= act^.sig;
  end;
  if (act = ant) then
    l:= nuevo
  else
    ant^.sig:= nuevo;
  nuevo^.sig:= act;
end;

procedure cargarLista (var l:lista);
var 
  c:compra;
begin
  leerCompra (c);
  while (c.monto <> -1) do begin
    insertarOrdenado (l, c);
    leerCompra (c);
  end;
end;

function cumple (montoTot:real) : boolean;
begin
  cumple:= montoTot > 30000;
end;

procedure recorrerLista (l:lista; var v:vector; var mes1,mes2:meses; var totJul:real);
var
  montoTot:real;
  auxNomb:string;
begin
  while (l <> nil) do begin
    montoTot:= 0; {punto B.1} 
    auxNomb:= l^.info.nomb;
    while ((l <> nil) and (auxNomb = l^.info.nomb)) do begin  
      montoTot:= montoTot + l^.info.monto;
      v[l^.info.mes]:= v[l^.info.mes] + 1;
      if (l^.info.mes = 7) then
        totJul:= totJul + l^.info.monto;
      l:= l^.sig;
    end;
    if (cumple(montoTot)) then
      writeln ('El proovedor ', auxNomb,' supera los 30mil facturados');{punto B.1} 
  end;
end;
    
procedure maximos (v:vector; var m1,m2:meses);
var 
  max1,max2:integer;
  i:meses;
begin
  max1:= -1;
  max2:= -1;
  for i:= 1 to 12 do begin
    if (v[i] > max1) then begin
      max2:=max1;
      max1:= v[i];
      m2:= m1;
      m1:= i;
    end
    else 
      if (v[i] > max2) then begin
        max2:= v[i];
        m2:= i;
      end;
   end;
end;

function promedio (jul:integer; tot:real) : real;
begin
  promedio:= tot/jul;
end;

  {PROG PRINCIPAL}
var
  l:lista;
  v:vector;
  mes1, mes2:meses;
  totJul:real;
begin
  l:= nil;
  totJul:=0;
  inicializoVector (v);
  cargarLista (l); {punto A}
  recorrerLista (l, v, mes1, mes2, totJul);
  maximos (v, mes1, mes2);
  writeln ('Los dos meses con mayor ventas fueron el mes ', mes1,' y ', mes2); { punto B.2 }
  writeln ('El monto promedio de Julio es: ', promedio(v[7], totJul));
end.
